import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stema/features/groups/groups_screen.dart';
import 'package:stema/router/side_navigation_bar.dart';
import 'package:stema/router/splash_screen.dart';
import 'package:stema/features/auth/controller/auth_controller.dart';
import 'package:stema/features/auth/view/auth_screen.dart';
import 'package:stema/features/dashboard/dshboard_screen.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    initialLocation: "/splash",
    redirect: (context, state) {
      final isInAuthScreen = state.uri.toString() == "/auth";
      final isInSplashScreen = state.uri.toString() == "/splash";
      final isLoggedIn = ref.watch(userProvider) != null;
      final isInitialyLoaded = ref.watch(initialLoadProvider);

      // show loading screen when app starts and then redirect
      if (isInitialyLoaded) {
        if (isLoggedIn && isInAuthScreen || isInSplashScreen) {
          return "/";
        } else if (!isLoggedIn && !isInAuthScreen) {
          return "/auth";
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: "/splash",
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: "/auth",
        builder: (context, state) => const AuthScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            SideNavigationBar(shell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/",
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: DashboardScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/groups",
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: GroupsScreen(),
                ),
              ),
            ],
          ),
        ],
      )
    ],
  ),
);

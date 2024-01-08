import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stema/features/groups/models/group_model.dart';
import 'package:stema/features/groups/views/group_detail_screen.dart';
import 'package:stema/features/groups/views/groups_screen.dart';
import 'package:stema/router/side_navigation_bar.dart';
import 'package:stema/router/splash_screen.dart';
import 'package:stema/features/auth/controller/auth_controller.dart';
import 'package:stema/features/auth/view/auth_screen.dart';
import 'package:stema/features/dashboard/dshboard_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final routerProvider = Provider(
  (ref) => GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) {
      final isInAuthScreen = state.uri.toString() == "/auth";
      final isInSplashScreen = state.uri.toString() == "/splash";
      final isLoggedIn = ref.watch(userProvider) != null;
      final isInitialyLoaded = ref.watch(initialLoadProvider);

      // show loading screen when app starts and then redirect
      if (isInitialyLoaded) {
        if (isLoggedIn && isInAuthScreen || isInSplashScreen) {
          return "/Dashboard";
        } else if (!isLoggedIn && !isInAuthScreen) {
          return "/auth";
        }
      }
      return null;
    },
    initialLocation: '/splash',
    routes: <RouteBase>[
      GoRoute(
        path: "/splash",
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: SplashScreen()),
      ),
      GoRoute(
        path: "/auth",
        builder: (context, state) => const AuthScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          return SideNavigationBar(shell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          // The route branch for the first tab of the bottom navigation bar.
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/Dashboard',
                name: "Dashboard",
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    const NoTransitionPage(
                  child: DashboardScreen(),
                ),
              ),
            ],
          ),

          // The route branch for the second tab of the bottom navigation bar.
          StatefulShellBranch(
            // It's not necessary to provide a navigatorKey if it isn't also
            // needed elsewhere. If not provided, a default key will be used.
            routes: <RouteBase>[
              GoRoute(
                path: '/Groups',
                name: "Groups",
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: GroupsScreen(),
                ),
                routes: [
                  GoRoute(
                      path: ':name',
                      name: "GroupDetails",
                      pageBuilder: (context, state) {
                        final name = state.pathParameters['name']!;
                        final groupModel = state.extra as GroupModel;
                        return NoTransitionPage(
                          child:
                              GroupDetailsScreen(group: groupModel, name: name),
                        );
                      })
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
);

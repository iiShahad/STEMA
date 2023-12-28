import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stema/router/splash_screen.dart';
import 'package:stema/features/auth/controller/auth_controller.dart';
import 'package:stema/features/auth/view/auth_screen.dart';
import 'package:stema/features/dashboard/dshboard_screen.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    initialLocation: "/splash",
    routes: [
      GoRoute(
        path: "/splash",
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: "/",
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: "/auth",
        builder: (context, state) => const AuthScreen(),
      ),
    ],
    redirect: (context, state) {
      final isInAuthScreen = state.uri.toString() == "/auth";
      final isInSplashScreen = state.uri.toString() == "/splash";
      final isLoggedIn = ref.watch(userProvider) != null;
      final isInitialyLoaded = ref.watch(initialLoadProvider);
      if (isInitialyLoaded) {
        if (isLoggedIn && isInAuthScreen || isInSplashScreen) {
          return "/";
        } else if (!isLoggedIn && !isInAuthScreen) {
          return "/auth";
        }
      }
      return null;
    },
  ),
);

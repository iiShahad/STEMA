import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stema/features/auth/controller/auth_controller.dart';
import 'package:stema/features/auth/view/auth_screen.dart';
import 'package:stema/features/dashboard/dshboard_screen.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    initialLocation: "/auth",
    routes: [
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
      final isLoggedIn = ref.watch(userProvider) != null;
      print('isInAuthScreen : ${isInAuthScreen}');
      print('isLoggedIn : ${isLoggedIn}');
      if (isLoggedIn && isInAuthScreen) {
        return "/";
      } else if (!isLoggedIn && !isInAuthScreen) {
        return "/auth";
      }
      return null;
    },
  ),
);

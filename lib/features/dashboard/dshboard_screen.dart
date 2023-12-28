import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stema/features/auth/controller/auth_controller.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ElevatedButton(
          onPressed: () {
            ref.read(authControllerProvider).signout();
            ref.read(userProvider.notifier).update((state) => null);
          },
          child: Text("logout")),
    );
  }
}

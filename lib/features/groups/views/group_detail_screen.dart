import 'package:flutter/material.dart';
import 'package:stema/core/common/topbar.dart';

class GroupDetailsScreen extends StatelessWidget {
  const GroupDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [TopBar()],
      ),
    );
  }
}

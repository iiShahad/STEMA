import 'package:flutter/material.dart';
import 'package:stema/core/common/topbar.dart';
import 'package:stema/features/groups/models/group_model.dart';

class GroupDetailsScreen extends StatelessWidget {
  final String name;
  final GroupModel group;
  const GroupDetailsScreen(
      {super.key, required this.group, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBar(
            pathArgument: name,
          )
        ],
      ),
    );
  }
}

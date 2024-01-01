import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stema/core/common/topbar.dart';
import 'package:stema/features/groups/views/widgets/group_card.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTopBar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 4 / 2),
              children: [
                GroupCard(
                  onTap: () {
                    context.pushNamed("GroupDetails");
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar() {
    return TopBar(
      actions: [
        SizedBox(
          width: 70,
          height: 25,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(5)),
            onPressed: () {},
            child: const Text(
              "Add +",
              style: TextStyle(fontSize: 12),
            ),
          ),
        )
      ],
    );
  }
}

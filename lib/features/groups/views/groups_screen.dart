import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stema/core/common/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';
import 'package:stema/core/core.dart';
import 'package:stema/features/groups/views/widgets/group_card.dart';
import 'package:stema/features/groups/views/widgets/group_screen_topbar.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const GroupScreenTopBar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                crossAxisCount:
                    MediaQuery.of(context).size.width < ScreenSizeConstants.lg
                        ? 2
                        : 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                height: 200,
              ),
              children: [
                GroupCard(
                  onTap: () {
                    context.pushNamed("GroupDetails");
                  },
                ),
                GroupCard(
                  onTap: () {
                    context.pushNamed("GroupDetails");
                  },
                ),
                GroupCard(
                  onTap: () {
                    context.pushNamed("GroupDetails");
                  },
                ),
                GroupCard(
                  onTap: () {
                    context.pushNamed("GroupDetails");
                  },
                ),
                GroupCard(
                  onTap: () {
                    context.pushNamed("GroupDetails");
                  },
                ),
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
}

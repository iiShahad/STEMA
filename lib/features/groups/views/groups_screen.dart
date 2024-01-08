import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stema/core/common/SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight.dart';
import 'package:stema/core/constants/screen_size_constants.dart';
import 'package:stema/features/groups/controller/groups_controller.dart';
import 'package:stema/features/groups/views/widgets/group_card.dart';
import 'package:stema/features/groups/views/widgets/group_screen_topbar.dart';

class GroupsScreen extends ConsumerWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const GroupScreenTopBar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ref.watch(groupsProvider).when(
                  data: (data) {
                    return GridView.builder(
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        crossAxisCount: MediaQuery.of(context).size.width <
                                ScreenSizeConstants.lg
                            ? 2
                            : 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        height: 200,
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) => GroupCard(
                        data: data[index],
                        onTap: () {
                          context.push(
                              context.namedLocation(
                                'GroupDetails',
                                pathParameters: {'name': data[index].title},
                              ),
                              extra: data[index]);
                        },
                      ),
                    );
                  },
                  error: (error, stackTrace) {
                    return Text(
                      error.toString(),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 100),
                    );
                  },
                  //TODO: change this ugly loading
                  //TODO: Show empty screen
                  loading: () => const Center(
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
          ),
        ),
      ],
    );
  }
}

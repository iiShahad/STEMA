import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stema/core/common/left_overlay.dart';
import 'package:stema/core/common/topbar.dart';
import 'package:stema/features/groups/views/widgets/add_group_form.dart';

class GroupScreenTopBar extends StatelessWidget {
  const GroupScreenTopBar({super.key});

  //the variable declared here because we want to delete the overlay
  @override
  Widget build(BuildContext context) {
    return TopBar(
      actions: [
        SizedBox(
          width: 70,
          height: 25,
          child: Consumer(
            builder: (context, ref, child) => ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(5)),
              onPressed: () {
                LeftOverlay.showOverlay(
                  content: const AddGroupForm(),
                  onPress: () => Overlay.of(context).insert(LeftOverlay.entry),
                );
              },
              child: const Text(
                "Add +",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        )
      ],
    );
  }
}

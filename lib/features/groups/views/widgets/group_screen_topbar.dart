import 'package:flutter/material.dart';
import 'package:stema/core/common/left_overlay.dart';
import 'package:stema/core/common/topbar.dart';

class GroupScreenTopBar extends StatefulWidget {
  const GroupScreenTopBar({super.key});

  @override
  State<GroupScreenTopBar> createState() => _GroupScreenTopBarState();
}

class _GroupScreenTopBarState extends State<GroupScreenTopBar> {
  //the variable declared here because we want to delete the overlay
  late OverlayEntry _entry;

  void _showOverlay() {
    _entry = OverlayEntry(
      builder: (context) => LeftOverlay(
        overlayContent: const Placeholder(),
        removeOverlay: () {
          _entry.remove();
        },
      ),
    );

    Overlay.of(context).insert(_entry);
  }

  @override
  Widget build(BuildContext context) {
    return TopBar(
      actions: [
        SizedBox(
          width: 70,
          height: 25,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(5)),
            onPressed: () {
              _showOverlay();
            },
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

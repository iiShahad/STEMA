import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stema/core/core.dart';

class SideNavigationBar extends StatefulWidget {
  final StatefulNavigationShell shell;
  const SideNavigationBar({super.key, required this.shell});

  @override
  State<SideNavigationBar> createState() => _SideNavigationBarState();
}

class _SideNavigationBarState extends State<SideNavigationBar> {
  void _goBranch(int index) {
    widget.shell.goBranch(
      index,
      initialLocation: index == widget.shell.currentIndex,
    );
  }

  Widget _buildIconButton(
      {required bool isSelected, required IconData icon, required int index}) {
    return GestureDetector(
      onTap: () => _goBranch(index),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: isSelected ? Palette.dark_primaryColor : null,
            shape: BoxShape.circle,
          ),
          child: Icon(icon,
              size: 25,
              color:
                  isSelected ? Palette.onPrimary : Palette.dark_primaryColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 80,
            decoration: const BoxDecoration(
              color: Palette.dark_surface,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                _buildIconButton(
                    icon: Icons.home,
                    isSelected: widget.shell.currentIndex == 0,
                    index: 0),
                const SizedBox(
                  height: 10,
                ),
                _buildIconButton(
                    icon: Icons.groups,
                    isSelected: widget.shell.currentIndex == 1,
                    index: 1),
              ],
            ),
          ),
          Expanded(
            child: widget.shell,
          ),
        ],
      ),
    );
  }
}

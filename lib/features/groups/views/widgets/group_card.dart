import 'package:flutter/material.dart';
import 'package:stema/core/core.dart';

class GroupCard extends StatelessWidget {
  final VoidCallback onTap;
  const GroupCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          decoration: const BoxDecoration(color: Palette.dark_surface),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Bla Bla Bla",
                      style: TextStyle(color: Palette.onPrimary),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz),
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Course: ",
                      ),
                      TextSpan(
                        text: "DBMS",
                        style: TextStyle(color: Palette.text_grey),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

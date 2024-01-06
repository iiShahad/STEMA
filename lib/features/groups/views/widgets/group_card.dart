import 'package:flutter/material.dart';
import 'package:stema/core/core.dart';
import 'package:stema/features/groups/models/group_model.dart';

class GroupCard extends StatelessWidget {
  final VoidCallback onTap;
  final GroupModel data;
  const GroupCard({super.key, required this.onTap, required this.data});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          decoration: BoxDecoration(
              color: Palette.dark_surface,
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        color: Palette.onPrimary,
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
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
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Course: ",
                        style:
                            TextStyle(color: Palette.text_grey, fontSize: 16),
                      ),
                      TextSpan(
                        text: data.course,
                        style: const TextStyle(
                          color: Palette.onPrimary,
                          fontSize: 16,
                        ),
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

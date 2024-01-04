import 'package:flutter/material.dart';
import 'package:stema/core/constants/screen_size_constants.dart';
import 'package:stema/core/theme/pallete.dart';

class LeftOverlay {
  static late OverlayEntry entry;

  static void showOverlay(
      {required Widget content, required VoidCallback onPress}) {
    entry = OverlayEntry(
      builder: (context) => LeftOverlayBuilder(
        overlayContent: content,
        removeOverlay: () {
          entry.remove();
        },
      ),
    );
    onPress();
  }
}

class LeftOverlayBuilder extends StatefulWidget {
  final Widget overlayContent;
  final VoidCallback removeOverlay;
  const LeftOverlayBuilder(
      {super.key, required this.overlayContent, required this.removeOverlay});

  @override
  State<LeftOverlayBuilder> createState() => _LeftOverlayBuilderState();
}

class _LeftOverlayBuilderState extends State<LeftOverlayBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Curve curve = Curves.easeInOut;
  Duration duration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );

    //start the animation when the overlay show in screen (insterted into overlay context)
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //backdrop to hide overlay when clicking on it
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              _controller.reverse();
              //this delay is to let the animation complete, then remove the overlay
              await Future.delayed(duration);
              widget.removeOverlay();
            },
            child: Container(
              color: Palette.dark_bg.withOpacity(0.7),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final animationValue = curve.transform(_controller.value);
            return Positioned(
              right: -ScreenSizeConstants.twoFifths(context) *
                  (1 - animationValue),
              child: child!,
            );
          },
          //here is the overlay container which should be including a form or whatever
          child: Container(
            width: ScreenSizeConstants.twoFifths(context),
            height: ScreenSizeConstants.screenHeight(context),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              color: Palette.dark_surface,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: widget.overlayContent,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stema/core/core.dart';

class ErrorNotification {
  static OverlayEntry? entry;
  static void showOverlay(
      {required VoidCallback onError, required String errorMessage}) {
    //remove the previous notification if it is shown
    _removeOverlay();
    //assign the new notification object
    entry = OverlayEntry(
      builder: (context) => ErrorNotificationBuilder(
        errorMessage: errorMessage,
        removeOverlay: () => _removeOverlay(),
      ),
    );
    onError();
  }

  static void _removeOverlay() {
    entry?.remove();
    entry = null;
  }
}

class ErrorNotificationBuilder extends StatefulWidget {
  final String errorMessage;
  final VoidCallback removeOverlay;
  const ErrorNotificationBuilder(
      {super.key, required this.removeOverlay, required this.errorMessage});

  @override
  State<ErrorNotificationBuilder> createState() =>
      _ErrorNotificationBuilderState();
}

class _ErrorNotificationBuilderState extends State<ErrorNotificationBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Curve curve = Curves.easeOutCirc;
  Duration duration = const Duration(milliseconds: 500);
  final notifWidth = 400.0;
  final notifHeight = 60.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);

    showOverlay();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void showOverlay() async {
    _controller.forward();
    //show the notification for 5 seconds then remove it
    await Future.delayed(const Duration(seconds: 5));
    removeOverlay();
  }

//this method is to reverse the animation and remove the overlay
  void removeOverlay() async {
    if (mounted) {
      _controller.reverse();
      await Future.delayed(duration);
      widget.removeOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final animationValue = curve.transform(_controller.value);
          return Positioned(
            right: 20,
            bottom: -notifHeight * (1 - animationValue) + 20,
            child: child!,
          );
        },
        child: _buildNotification());
  }

  Widget _buildNotification() {
    return Container(
      width: notifWidth,
      height: notifHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Palette.dark_surface,
        border: Border.all(color: Palette.dark_border),
        boxShadow: const [
          BoxShadow(
            blurRadius: 15,
            color: Palette.dark_border,
            spreadRadius: -10,
            offset: Offset(0, 5),
          )
        ],
      ),
      //Notification content
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Error icon
            const Icon(
              Icons.error,
              color: Palette.error,
            ),
            const SizedBox(
              width: 5,
            ),
            //Error message
            Expanded(
              child: Text(
                widget.errorMessage,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(color: Palette.onPrimary, fontSize: 12),
              ),
            ),

            //Close button
            IconButton(
              onPressed: () async {
                removeOverlay();
              },
              icon: const Icon(Icons.close),
              alignment: Alignment.center,
              hoverColor: Colors.transparent,
              iconSize: 15,
            )
          ],
        ),
      ),
    );
  }
}

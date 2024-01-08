import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stema/core/core.dart';

class TopBar extends StatelessWidget {
  final String? pathArgument;
  final List<Widget> actions;
  const TopBar({super.key, this.actions = const [], this.pathArgument});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: const BoxDecoration(
        color: Palette.dark_topbar,
        border: Border(
          bottom: BorderSide(
            color: Palette.dark_border,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getRoute(context, pathArgument),
            Row(mainAxisSize: MainAxisSize.min, children: actions),
          ],
        ),
      ),
    );
  }

  Widget _getRoute(BuildContext context, String? pathArgument) {
    String uri = GoRouterState.of(context).fullPath.toString();
    uri = uri.substring(1);
    final splitter = uri.split("/");
    if (pathArgument != null) {
      splitter.removeLast();
      splitter.add(pathArgument);
    }
    return RichText(
      text: TextSpan(
        children: [
          for (int i = 0; i < splitter.length - 1; i++)
            TextSpan(
              text: "${splitter[i]} / ",
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.goNamed(splitter[i]);
                },
            ),
          TextSpan(
            text: splitter.last,
            style: const TextStyle(color: Palette.text_grey),
          ),
        ],
      ),
    );
  }
}

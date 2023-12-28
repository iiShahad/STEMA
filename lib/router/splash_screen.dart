import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stema/core/core.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      ref.read(initialLoadProvider.notifier).update((state) => true);
    });
    super.initState();
  }

  //TODO: handle connectivity

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(AssetsConstants.logo),
          const SizedBox(
            height: 50,
          ),
          const CircularProgressIndicator(
            color: Colors.white,
          ),
        ],
      ),
    ));
  }
}

final initialLoadProvider = StateProvider<bool>((ref) {
  return false;
});

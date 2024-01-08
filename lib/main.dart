import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stema/features/auth/controller/auth_controller.dart';
import 'package:stema/l10n/l10n.dart';
import 'package:stema/router/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseConstants.url,
    anonKey: SupabaseConstants.anon,
  );
  usePathUrlStrategy();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  void initializeUserData(WidgetRef ref, String id) async {
    final data = await ref.watch(authControllerProvider).getUserData(id);
    ref.read(userProvider.notifier).update((state) => data);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authStateChangeProvider).whenData(
      (data) {
        final id = data.session?.user.id;
        if (id != null && ref.read(userProvider) == null) {
          initializeUserData(ref, id);
        }
      },
    );

    return MaterialApp.router(
      title: 'STEMA',
      theme: Palette.darkModeAppTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      routerConfig: ref.watch(routerProvider),
    );
  }
}

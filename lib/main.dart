import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gpt_flutter/firebase_options.dart';
import 'package:gpt_flutter/providers/active_theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpt_flutter/providers/main_provider.dart';
import 'package:gpt_flutter/screens/onboard/onboard_screen.dart';
import 'package:gpt_flutter/services/voice_handler.dart';
import 'constants/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  VoiceHandler().initTts();
  runApp(const ProviderScope(
    child: App(),
  ));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(mainProvider.notifier).getApiValue();
    print('api key ${ref.read(apiKeyValue.notifier).state}');
    final activeTheme = ref.watch(activeThemeProvider);
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      themeMode: activeTheme == Themes.dark ? ThemeMode.dark : ThemeMode.light,
      home: const OnbodingScreen(),
    );
  }
}

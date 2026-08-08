import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/firebase_config.dart';
import 'providers/app_user_provider.dart';
import 'services/auth_service.dart';
import 'screens/home_screen.dart';
import 'screens/tutorial_screen.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConfig.initialize();

  runApp(
    const ProviderScope(
      child: YoichiyataiApp(),
    ),
  );
}

class YoichiyataiApp extends StatelessWidget {
  const YoichiyataiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '夜市の屋台街',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final minDelay = Future.delayed(const Duration(seconds: 2));
    bool isFirstLaunch = true;

    try {
      final authService = AuthService();
      if (authService.currentUser == null) {
        await authService.signInAnonymously();
      }
      final appUser = await ref.read(appUserProvider.future);
      // totalRevenue が0のままなら未プレイ = 初回起動とみなす
      isFirstLaunch = appUser == null || appUser.totalRevenue == 0;
    } catch (_) {
      // オフライン等でサインインに失敗してもチュートリアルへフォールバック
      isFirstLaunch = true;
    }

    await minDelay;
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) =>
              isFirstLaunch ? const TutorialScreen() : const HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '🌙',
              style: TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 24),
            const Text(
              '夜市の屋台街',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Night Market Tycoon',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 48),
            const SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
        ),
      ),
    );
  }
}

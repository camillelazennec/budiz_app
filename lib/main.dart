import 'pages/sign_up_page.dart';
import 'pages/login_page.dart';
import 'pages/complete_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Clés Supabase en dur pour test rapide
  await Supabase.initialize(
    url: 'https://frtqyiyjxgunaclttrbt.supabase.co',
    anonKey: 'sb_publishable_1rVx7Ibwn-UmrHPdnigFpg_r2ADUIrE',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEC6A6D), // rose
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFEC6A6D),
        ),
      ),
      home: const SplashPage(),
      routes: {
        '/login': (_) => const LoginPage(),
        '/home': (_) => const HomePage(),
      },
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animation du logo
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Animation scale + fade
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    // Timer pour passer à HomePage après 2 secondes
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEC6A6D),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: ScaleTransition(
            scale: _animation,
            child: Image.asset(
              'assets/logo.jpg',
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/logo.jpg',
          height: 40,
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Connexion Supabase réussie 🚀',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SignUpPage()),
                );
              },
              child: const Text('Créer un compte'),
            ),
          ],
        ),
      ),
    );
  }
}



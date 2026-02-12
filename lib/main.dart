import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Pour test rapide, on met les clés directement
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
          seedColor: const Color(0xFFEC6A6D), // Couleur rgb(236,106,109)
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFEC6A6D),
        ),
      ),
      home: const HomePage(),
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
        // Logo dans l'AppBar
        title: Image.asset(
          'assets/logo.jpg', // Assurez-vous que le fichier existe ici
          height: 40,
        ),
      ),
      body: const Center(
        child: Text(
          'Connexion Supabase réussie 🚀',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

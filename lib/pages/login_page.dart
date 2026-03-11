import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'complete_profile_page.dart'; // Page pour compléter le profil

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  Future<void> _login() async {
    setState(() => _loading = true);

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final user = response.user;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email ou mot de passe incorrect')),
        );
      } else {
        // Vérifier si profil complet
        final profile = await Supabase.instance.client
            .from('users')
            .select()
            .eq('id', user.id)
            .maybeSingle();

        if (profile == null ||
            profile['city'] == null ||
            profile['age'] == null) {
          // Profil incomplet → CompleteProfilePage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => CompleteProfilePage(userId: user.id)),
          );
        } else {
          // Profil complet → HomePage
          Navigator.pushReplacementNamed(context, '/home');
        }
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : ${e.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur inconnue : $e')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _login,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}
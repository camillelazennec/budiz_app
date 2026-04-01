import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _ageController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _loading = false;

  Future<void> _signUp() async {
    setState(() => _loading = true);

    try {
      // 1️⃣ Crée le compte utilisateur dans Supabase Auth
      final res = await Supabase.instance.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final user = res.user;
      if (user == null) throw Exception("Erreur lors de la création du compte");

      // 2️⃣ Insère le profil complet dans la table 'users'
      await Supabase.instance.client.from('users').insert({
        'id': user.id,
        'email': user.email ?? _emailController.text.trim(),
        'first_name': _firstNameController.text.trim(),
        'last_name': _lastNameController.text.trim(),
        'city': _cityController.text.trim(),
        'age': int.tryParse(_ageController.text.trim()),
        'description': _descriptionController.text.trim(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compte créé avec succès !')),
      );

      // Redirige vers la Home connectée
      Navigator.pushReplacementNamed(context, '/home');

    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur Supabase : ${e.message}')),
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
      appBar: AppBar(title: const Text('Créer un compte')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _firstNameController, decoration: const InputDecoration(labelText: "Prénom")),
            TextField(controller: _lastNameController, decoration: const InputDecoration(labelText: "Nom")),
            TextField(controller: _cityController, decoration: const InputDecoration(labelText: "Ville")),
            TextField(controller: _ageController, decoration: const InputDecoration(labelText: "Âge"), keyboardType: TextInputType.number),
            TextField(controller: _descriptionController, decoration: const InputDecoration(labelText: "Description")),
            const SizedBox(height: 20),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: _passwordController, decoration: const InputDecoration(labelText: "Mot de passe"), obscureText: true),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _loading ? null : _signUp,
              child: _loading ? const CircularProgressIndicator() : const Text("Créer mon compte"),
            )
          ],
        ),
      ),
    );
  }
}
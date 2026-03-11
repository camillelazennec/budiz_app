import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompleteProfilePage extends StatefulWidget {
  final String userId;

  const CompleteProfilePage({super.key, required this.userId});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final _cityController = TextEditingController();
  final _ageController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _loading = false;

  Future<void> _saveProfile() async {
    setState(() => _loading = true);

    try {
      final updates = {
        'city': _cityController.text,
        'age': int.tryParse(_ageController.text),
        'description': _descriptionController.text,
      };

      await Supabase.instance.client
          .from('users')
          .update(updates)
          .eq('id', widget.userId);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil mis à jour !')),
      );

      Navigator.pushReplacementNamed(context, '/home');
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
      appBar: AppBar(title: const Text('Compléter mon profil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: 'Ville'),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Âge'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _saveProfile,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
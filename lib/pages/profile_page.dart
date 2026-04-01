import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Map<String, dynamic>? profile;

  Future<void> loadProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    try {
      final data = await Supabase.instance.client
          .from("users")
          .select()
          .eq("id", user.id)
          .maybeSingle();

      if (!mounted) return;
      setState(() {
        profile = data ?? <String, dynamic>{};
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        profile = <String, dynamic>{};
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Impossible de charger le profil : $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {

    if (profile == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Mon Profil")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text("Prénom : ${profile!["first_name"] ?? ''}"),
            Text("Nom : ${profile!["last_name"] ?? ''}"),
            Text("Ville : ${profile!["city"] ?? ''}"),
            Text("Age : ${profile!["age"] ?? ''}"),
            Text("Description : ${profile!["description"] ?? ''}"),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: logout,
              child: const Text("Se déconnecter"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/home");
              },
              child: const Text("Retour accueil"),
            ),

          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CreateActivityPage extends StatefulWidget {
  const CreateActivityPage({super.key});

  @override
  State<CreateActivityPage> createState() => _CreateActivityPageState();
}

class _CreateActivityPageState extends State<CreateActivityPage> {
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _addressController = TextEditingController();
  final _participantsController = TextEditingController();
  final _detailsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _addressController.dispose();
    _participantsController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  void _submit() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const ActivityCreatedSuccessPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Créer une activité',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _LabeledField(
                label: "Nom de l'activité",
                child: TextField(
                  controller: _nameController,
                  decoration: _activityDecoration("Nom de l'activité"),
                ),
              ),
              _LabeledField(
                label: 'Date',
                child: TextField(
                  controller: _dateController,
                  keyboardType: TextInputType.datetime,
                  decoration: _activityDecoration(
                    'JJ/MM/AAAA',
                    suffix: const Icon(Icons.calendar_today_outlined),
                  ),
                ),
              ),
              _LabeledField(
                label: 'Heure',
                child: TextField(
                  controller: _timeController,
                  keyboardType: TextInputType.datetime,
                  decoration: _activityDecoration('Heure'),
                ),
              ),
              _LabeledField(
                label: 'Adresse',
                child: TextField(
                  controller: _addressController,
                  decoration: _activityDecoration('Adresse'),
                ),
              ),
              _LabeledField(
                label: 'Nombre de participant',
                child: TextField(
                  controller: _participantsController,
                  keyboardType: TextInputType.number,
                  decoration: _activityDecoration('Nombre de participant'),
                ),
              ),
              _LabeledField(
                label: "Détails de l'activité",
                child: TextField(
                  controller: _detailsController,
                  minLines: 4,
                  maxLines: 5,
                  decoration: _activityDecoration('Texte'),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _submit,
                style: budizPrimaryButtonStyle(),
                child: const Text('Valider'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _activityDecoration(String hint, {Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      hintStyle: TextStyle(
        color: Colors.black.withValues(alpha: 0.25),
        fontSize: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.22)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.22)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.coral, width: 1.4),
      ),
    );
  }
}

class ActivityCreatedSuccessPage extends StatelessWidget {
  const ActivityCreatedSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(26, 24, 26, 28),
          child: Column(
            children: [
              const SizedBox(height: 92),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: AppColors.searchFill,
                        borderRadius: BorderRadius.circular(88),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/logo.jpg',
                          height: 110,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.thumb_up_alt_rounded,
                            color: AppColors.teal,
                            size: 96,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 34),
                    const Text(
                      'Vous avez créé une activité\navec succès !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        height: 1.45,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop('activities'),
                style: budizPrimaryButtonStyle(),
                child: const Text('Voir mes activités'),
              ),
              const SizedBox(height: 14),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 54),
                  foregroundColor: AppColors.coral,
                  side: const BorderSide(color: AppColors.coral),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                child: const Text("Retour à la page d'accueil"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

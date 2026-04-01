import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Logo texte « BUDIZ » style maquette (arrondi, corail).
class BudizWordmark extends StatelessWidget {
  const BudizWordmark({super.key, this.fontSize = 36});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      'BUDIZ',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
        color: AppColors.coral,
        height: 1.0,
      ),
    );
  }
}

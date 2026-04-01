import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'home_dashboard_page.dart';

/// Conteneur principal après connexion : onglets + FAB (maquette).
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      extendBody: true,
      body: IndexedStack(
        index: _index,
        sizing: StackFit.expand,
        children: [
          SizedBox.expand(child: HomeDashboardPage()),
          SizedBox.expand(child: const _ExplorerPlaceholder()),
          SizedBox.expand(child: const _ActivitiesPlaceholder()),
          SizedBox.expand(child: const _ChatPlaceholder()),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 56),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.coral,
          elevation: 4,
          child: const Icon(Icons.add, color: Colors.white, size: 32),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavEntry(
                  assetPath: 'assets/home.webp',
                  label: 'Accueil',
                  selected: _index == 0,
                  onTap: () => setState(() => _index = 0),
                ),
                _NavEntry(
                  assetPath: 'assets/Loupe.webp',
                  label: 'Explorer',
                  selected: _index == 1,
                  onTap: () => setState(() => _index = 1),
                ),
                _NavEntry(
                  assetPath: 'assets/calendrier.webp',
                  label: 'Activités',
                  selected: _index == 2,
                  onTap: () => setState(() => _index = 2),
                ),
                _NavEntry(
                  assetPath: 'assets/chat.webp',
                  label: 'Chat',
                  selected: _index == 3,
                  onTap: () => setState(() => _index = 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavEntry extends StatelessWidget {
  const _NavEntry({
    required this.assetPath,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String assetPath;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.coral : AppColors.textSecondary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Opacity(
              opacity: selected ? 1 : 0.55,
              child: Image.asset(
                assetPath,
                height: 26,
                width: 26,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.circle_outlined,
                  size: 26,
                  color: color,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExplorerPlaceholder extends StatelessWidget {
  const _ExplorerPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const _SimplePlaceholder(title: 'Explorer', message: 'Carte à venir');
  }
}

class _ActivitiesPlaceholder extends StatelessWidget {
  const _ActivitiesPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const _SimplePlaceholder(
      title: 'Activités',
      message: 'Tes activités à venir',
    );
  }
}

class _ChatPlaceholder extends StatelessWidget {
  const _ChatPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const _SimplePlaceholder(title: 'Chat', message: 'Discussions à venir');
  }
}

class _SimplePlaceholder extends StatelessWidget {
  const _SimplePlaceholder({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.scaffoldBg,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

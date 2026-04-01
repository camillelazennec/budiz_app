import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../theme/app_theme.dart';

/// Contenu de l’onglet Accueil (maquette).
class HomeDashboardPage extends StatelessWidget {
  const HomeDashboardPage({super.key});

  String _welcomeName() {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return 'Invité';
    final meta = user.userMetadata;
    final first = meta?['first_name'] as String?;
    if (first != null && first.isNotEmpty) return first;
    final email = user.email;
    if (email != null && email.contains('@')) {
      return email.split('@').first;
    }
    return 'toi';
  }

  String _initials() {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return '?';
    final meta = user.userMetadata;
    final first = (meta?['first_name'] as String?) ?? '';
    final last = (meta?['last_name'] as String?) ?? '';
    if (first.isNotEmpty && last.isNotEmpty) {
      return '${first[0]}${last[0]}'.toUpperCase();
    }
    if (first.length >= 2) return first.substring(0, 2).toUpperCase();
    final email = user.email;
    if (email != null && email.length >= 2) {
      return email.substring(0, 2).toUpperCase();
    }
    return 'B';
  }

  @override
  Widget build(BuildContext context) {
    final name = _welcomeName();
    final initials = _initials();

    return ColoredBox(
      color: AppColors.scaffoldBg,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.teal,
                    child: Text(
                      initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bienvenue',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black.withValues(alpha: 0.55),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    style: IconButton.styleFrom(
                      side: BorderSide(
                        color: Colors.black.withValues(alpha: 0.12),
                      ),
                      shape: const CircleBorder(),
                    ),
                    icon: const Icon(Icons.notifications_none_rounded),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      onTap: () {},
                      decoration: InputDecoration(
                        hintText: 'Rechercher un évènement',
                        hintStyle: TextStyle(
                          color: Colors.black.withValues(alpha: 0.35),
                          fontSize: 15,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 8),
                          child: Image.asset(
                            'assets/Loupe.webp',
                            width: 22,
                            height: 22,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.search,
                              color: Colors.black.withValues(alpha: 0.35),
                            ),
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 44,
                          minHeight: 48,
                        ),
                        filled: true,
                        fillColor: AppColors.searchFill,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Material(
                    color: AppColors.coral,
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(14),
                      child: const SizedBox(
                        width: 52,
                        height: 52,
                        child: Icon(
                          Icons.tune_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: _sectionHeader('Gagné des récompenses')),
          SliverToBoxAdapter(child: _rewardsRow()),
          SliverToBoxAdapter(child: _sectionHeader('Mes activités')),
          SliverToBoxAdapter(child: _mesActivitesCard()),
          SliverToBoxAdapter(
            child: _sectionHeader('Activités autour de Rennes'),
          ),
          SliverToBoxAdapter(child: _activityCarousel(context)),
          SliverToBoxAdapter(child: _sectionHeader('Nos recommandations')),
          SliverToBoxAdapter(child: _recommendationsCarousel(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          Text(
            'Voir tout >',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.teal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _rewardsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.teal.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _rewardStep(done: true, icon: Icons.check_rounded),
              _rewardLine(done: true),
              _rewardStep(done: true, icon: Icons.check_rounded),
              _rewardLine(done: true),
              _rewardStep(
                done: false,
                icon: Icons.emoji_events_rounded,
                highlight: true,
              ),
              _rewardLine(done: false),
              _rewardStep(done: false, icon: Icons.lock_outline_rounded),
              _rewardLine(done: false),
              _rewardStep(done: false, icon: Icons.lock_outline_rounded),
              _rewardLine(done: false),
              _rewardStep(done: false, icon: Icons.lock_outline_rounded),
              _rewardLine(done: false),
              _rewardStep(done: false, icon: Icons.lock_outline_rounded),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rewardLine({required bool done}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        width: 18,
        height: 3,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: done
              ? AppColors.teal.withValues(alpha: 0.55)
              : AppColors.teal.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _rewardStep({
    required bool done,
    required IconData icon,
    bool highlight = false,
  }) {
    final Color bg = highlight
        ? const Color(0xFFFFD54F)
        : done
            ? AppColors.teal
            : Colors.white;
    final Color fg = highlight
        ? Colors.black87
        : done
            ? Colors.white
            : AppColors.teal.withValues(alpha: 0.35);
    final double size = highlight ? 40 : 32;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        border: Border.all(
          color: done || highlight
              ? Colors.transparent
              : AppColors.teal.withValues(alpha: 0.25),
        ),
      ),
      child: Icon(icon, size: highlight ? 22 : 16, color: fg),
    );
  }

  Widget _mesActivitesCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.coral,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text(
                    '2',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Cette semaine',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.95),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: 56,
              color: Colors.white.withValues(alpha: 0.45),
            ),
            Expanded(
              child: Column(
                children: [
                  const Text(
                    '3',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Terminé',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.95),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _activityCarousel(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _ActivityCard(
            imageAsset: 'assets/soireeamie1.webp',
            title: 'Soirée chill entre amis',
            dateLabel: '3 Déc. 19h30',
            showParticipate: true,
            avatarAssets: const [
              'assets/profil1.webp',
              'assets/profil2.webp',
              'assets/profil3.webp',
            ],
          ),
          const SizedBox(width: 14),
          _ActivityCard(
            imageAsset: 'assets/soireeamie2.webp',
            title: 'On brunch\'',
            dateLabel: '3 Déc. 19h30',
            showParticipate: false,
            avatarAssets: const [
              'assets/profil1.webp',
              'assets/profil2.webp',
            ],
          ),
        ],
      ),
    );
  }

  Widget _recommendationsCarousel(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _ActivityCard(
            imageAsset: 'assets/soireeamie2.webp',
            title: 'Soirée chill entre amis',
            dateLabel: '3 Déc. 19h30',
            showParticipate: false,
            avatarAssets: const [
              'assets/profil1.webp',
              'assets/profil2.webp',
              'assets/profil3.webp',
            ],
          ),
          const SizedBox(width: 14),
          _ActivityCard(
            imageAsset: 'assets/soireeamie1.webp',
            title: 'On brunch\'',
            dateLabel: '3 Déc. 19h30',
            showParticipate: false,
            avatarAssets: const [
              'assets/profil2.webp',
            ],
          ),
        ],
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({
    required this.imageAsset,
    required this.title,
    required this.dateLabel,
    required this.showParticipate,
    required this.avatarAssets,
  });

  final String imageAsset;
  final String title;
  final String dateLabel;
  final bool showParticipate;
  final List<String> avatarAssets;

  @override
  Widget build(BuildContext context) {
    const width = 280.0;
    return SizedBox(
      width: width,
      child: Material(
        elevation: 4,
        shadowColor: Colors.black26,
        borderRadius: BorderRadius.circular(18),
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 118,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    imageAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.searchFill,
                      child: const Icon(Icons.image_not_supported_outlined),
                    ),
                  ),
                  if (showParticipate)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Je participe',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.favorite_border_rounded,
                            size: 20,
                            color: AppColors.coral,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            for (var i = 0; i < avatarAssets.length; i++)
                              Transform.translate(
                                offset: Offset(-8.0 * i, 0),
                                child: _miniAvatar(avatarAssets[i]),
                              ),
                          ],
                        ),
                      ),
                      Text(
                        dateLabel,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withValues(alpha: 0.55),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniAvatar(String asset) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        asset,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => ColoredBox(
          color: AppColors.teal.withValues(alpha: 0.3),
          child: const Icon(Icons.person, size: 16, color: Colors.white),
        ),
      ),
    );
  }
}

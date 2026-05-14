class MockActivity {
  const MockActivity({
    required this.title,
    required this.imageAsset,
    required this.dateLabel,
    required this.timeLabel,
    required this.participants,
    required this.statusLabel,
    required this.statusColorHex,
  });

  final String title;
  final String imageAsset;
  final String dateLabel;
  final String timeLabel;
  final List<String> participants;
  final String statusLabel;
  final int statusColorHex;
}

const mockActivities = [
  MockActivity(
    title: 'Soirée chill entre amis',
    imageAsset: 'assets/soireeamie1.webp',
    dateLabel: '3 Déc.',
    timeLabel: '19h30',
    participants: [
      'assets/profil1.webp',
      'assets/profil2.webp',
      'assets/profil3.webp',
      'assets/profil1.webp',
      'assets/profil2.webp',
      'assets/profil3.webp',
      'assets/profil1.webp',
      'assets/profil2.webp',
    ],
    statusLabel: 'Je participe',
    statusColorHex: 0xFF1FAE4B,
  ),
  MockActivity(
    title: 'Soirée chill entre amis',
    imageAsset: 'assets/soireeamie2.webp',
    dateLabel: '3 Déc.',
    timeLabel: '19h30',
    participants: [
      'assets/profil1.webp',
      'assets/profil2.webp',
      'assets/profil3.webp',
      'assets/profil1.webp',
      'assets/profil2.webp',
      'assets/profil3.webp',
      'assets/profil1.webp',
      'assets/profil2.webp',
    ],
    statusLabel: 'Je participe',
    statusColorHex: 0xFF1FAE4B,
  ),
];

const completedMockActivities = [
  MockActivity(
    title: 'Soirée chill entre amis',
    imageAsset: 'assets/soireeamie1.webp',
    dateLabel: '3 Déc.',
    timeLabel: '19h30',
    participants: [
      'assets/profil1.webp',
      'assets/profil2.webp',
      'assets/profil3.webp',
      'assets/profil1.webp',
      'assets/profil2.webp',
      'assets/profil3.webp',
      'assets/profil1.webp',
      'assets/profil2.webp',
    ],
    statusLabel: "J'y étais",
    statusColorHex: 0xFF8B8B8B,
  ),
  MockActivity(
    title: 'Soirée chill entre amis',
    imageAsset: 'assets/soireeamie2.webp',
    dateLabel: '3 Déc.',
    timeLabel: '19h30',
    participants: [
      'assets/profil1.webp',
      'assets/profil2.webp',
      'assets/profil3.webp',
      'assets/profil1.webp',
      'assets/profil2.webp',
      'assets/profil3.webp',
      'assets/profil1.webp',
      'assets/profil2.webp',
    ],
    statusLabel: "J'y étais",
    statusColorHex: 0xFF8B8B8B,
  ),
];

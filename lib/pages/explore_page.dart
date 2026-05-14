import 'package:flutter/material.dart';

import '../data/mock_activities.dart';
import '../theme/app_theme.dart';
import 'create_activity_page.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return ColoredBox(
      color: const Color(0xFFFFF6F6),
      child: Stack(
        children: [
          const Positioned.fill(
            bottom: 310,
            child: _InteractiveRennesMap(),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 10,
            left: 18,
            child: _RoundIconButton(
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: () {},
            ),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 10,
            right: 18,
            child: _RoundIconButton(
              icon: Icons.search_rounded,
              onTap: () {},
              dark: true,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(18, 44, 18, 108 + bottomInset),
              decoration: const BoxDecoration(
                color: Color(0xFFFFF7F7),
                borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final activity in [
                    mockActivities[1],
                    mockActivities[0],
                    mockActivities[1],
                    mockActivities[0],
                  ]) ...[
                    _MapActivityTile(activity: activity),
                    const SizedBox(height: 14),
                  ],
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 292 + bottomInset,
            child: Center(
              child: FloatingActionButton(
                heroTag: 'explore-map-plus',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const CreateActivityPage(),
                    ),
                  );
                },
                backgroundColor: AppColors.coral,
                elevation: 3,
                child: const Icon(Icons.add, color: Colors.white, size: 34),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InteractiveRennesMap extends StatelessWidget {
  const _InteractiveRennesMap();

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: InteractiveViewer(
        minScale: 1,
        maxScale: 2.4,
        boundaryMargin: const EdgeInsets.all(80),
        child: SizedBox(
          width: 620,
          height: 560,
          child: Stack(
            fit: StackFit.expand,
            children: [
              const CustomPaint(painter: _MapPainter()),
              const Positioned(
                top: 170,
                left: 180,
                child: Text(
                  'Rennes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              _MapMarker(
                top: 132,
                left: 214,
                assetPath: 'assets/soireeamie1.webp',
              ),
              _MapMarker(
                top: 168,
                left: 286,
                assetPath: 'assets/soireeamie2.webp',
              ),
              _MapMarker(
                top: 220,
                left: 176,
                assetPath: 'assets/profil1.webp',
              ),
              _MapMarker(
                top: 246,
                left: 292,
                assetPath: 'assets/profil2.webp',
              ),
              Positioned(
                top: 330,
                left: 254,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6EFF0).withValues(alpha: 0.75),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 17,
                      height: 17,
                      decoration: const BoxDecoration(
                        color: Color(0xFF5A8493),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  const _MapPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFF182733);
    canvas.drawRect(Offset.zero & size, bg);

    final water = Paint()..color = const Color(0xFF0C6B6F);
    final river = Path()
      ..moveTo(size.width * 0.34, 0)
      ..cubicTo(
        size.width * 0.45,
        size.height * 0.25,
        size.width * 0.36,
        size.height * 0.48,
        size.width * 0.52,
        size.height,
      )
      ..lineTo(size.width * 0.63, size.height)
      ..cubicTo(
        size.width * 0.47,
        size.height * 0.58,
        size.width * 0.57,
        size.height * 0.34,
        size.width * 0.43,
        0,
      )
      ..close();
    canvas.drawPath(river, water);

    final roadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.16)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final smallRoadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < 10; i++) {
      final y = 35.0 + i * 55;
      canvas.drawLine(Offset(-20, y), Offset(size.width + 20, y + 70), smallRoadPaint);
    }
    for (var i = 0; i < 8; i++) {
      final x = 25.0 + i * 72;
      canvas.drawLine(Offset(x, -20), Offset(x + 40, size.height + 20), smallRoadPaint);
    }
    canvas.drawLine(
      Offset(0, size.height * 0.42),
      Offset(size.width, size.height * 0.31),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.18, 0),
      Offset(size.width * 0.68, size.height),
      roadPaint,
    );

    _drawLabel(canvas, 'NORD ST MARTIN', Offset(40, 135));
    _drawLabel(canvas, 'THABOR', Offset(330, 258));
    _drawLabel(canvas, 'MUSÉE DES\nRENNES', Offset(88, 244));
    _drawLabel(canvas, 'SAINT HÉLIER', Offset(355, 298));
    _drawLabel(canvas, 'Champs Libres', Offset(8, 355));
  }

  void _drawLabel(Canvas canvas, String text, Offset offset) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.58),
          fontSize: 19,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.3,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MapMarker extends StatelessWidget {
  const _MapMarker({
    required this.top,
    required this.left,
    required this.assetPath,
  });

  final double top;
  final double left;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: 74,
        height: 74,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.coral.withValues(alpha: 0.95),
        ),
        child: ClipOval(
          child: Image.asset(assetPath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class _MapActivityTile extends StatelessWidget {
  const _MapActivityTile({required this.activity});

  final MockActivity activity;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.black12,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 108,
        child: Row(
          children: [
            SizedBox(
              width: 150,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(activity.imageAsset, fit: BoxFit.cover),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.black87,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 6, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "On brunch?",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${activity.dateLabel}\n${activity.timeLabel}',
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    _ParticipantRow(assets: activity.participants.take(3).toList()),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: CircleAvatar(
                radius: 19,
                backgroundColor: AppColors.teal,
                child: const Icon(
                  Icons.ios_share_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ParticipantRow extends StatelessWidget {
  const _ParticipantRow({required this.assets});

  final List<String> assets;
  static const double _radius = 13;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _radius * 2 + 4,
      child: Stack(
        children: [
          for (var i = 0; i < assets.length; i++)
            Positioned(
              left: i * (_radius + 2),
              child: Container(
                width: _radius * 2 + 2,
                height: _radius * 2 + 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(assets[i], fit: BoxFit.cover),
              ),
            ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.onTap,
    this.dark = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: dark ? Colors.black.withValues(alpha: 0.46) : Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}

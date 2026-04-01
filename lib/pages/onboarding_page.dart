import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';
import 'login_page.dart';
import 'sign_up_page.dart';

/// Couleur corail des maquettes (#F66D6D).
const Color _kOnboardingCoral = Color(0xFFF66D6D);

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;

  static const _pages = [
    _OnboardingSlide(
      assetPath: 'assets/OnBoarding1.webp',
      title: 'Trouve des gens qui te ressemblent',
      subtitle:
          'Découvre des groupes formés autour d\'activités et de passions communes. Ici, tout commence par ce que tu aimes.',
      showSkip: true,
    ),
    _OnboardingSlide(
      assetPath: 'assets/OnBoarding2.webp',
      title: 'Rejoins des rencontres près de toi',
      subtitle:
          'Explore la carte, clique sur un événement et inscris-toi en un geste. Bars, cafés, ciné, sport... choisis ce qui te fait vibrer.',
      showSkip: true,
    ),
    _OnboardingSlide(
      assetPath: 'assets/OnBoarding3.webp',
      title: 'Budiz, c\'est l\'app des vraies rencontres',
      subtitle:
          'Sans swipe, sans pression. Juste toi, tes passions, et des personnes qui veulent créer du lien.',
      showSkip: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  void _openSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SignUpPage()),
    );
  }

  void _openLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (i) => setState(() => _pageIndex = i),
        itemBuilder: (context, index) {
          return _OnboardingSlideView(
            slide: _pages[index],
            slideIndex: index,
            currentPage: _pageIndex,
            totalPages: _pages.length,
            isLast: index == _pages.length - 1,
            onSkip: _goHome,
            onNext: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 320),
                curve: Curves.easeOutCubic,
              );
            },
            onBack: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 320),
                curve: Curves.easeOutCubic,
              );
            },
            onSignUp: _openSignUp,
            onLogin: _openLogin,
            onGuest: _goHome,
          );
        },
      ),
    );
  }
}

class _OnboardingSlide {
  const _OnboardingSlide({
    required this.assetPath,
    required this.title,
    required this.subtitle,
    required this.showSkip,
  });

  final String assetPath;
  final String title;
  final String subtitle;
  final bool showSkip;
}

class _OnboardingSlideView extends StatelessWidget {
  const _OnboardingSlideView({
    required this.slide,
    required this.slideIndex,
    required this.currentPage,
    required this.totalPages,
    required this.isLast,
    required this.onSkip,
    required this.onNext,
    required this.onBack,
    required this.onSignUp,
    required this.onLogin,
    required this.onGuest,
  });

  final _OnboardingSlide slide;
  final int slideIndex;
  final int currentPage;
  final int totalPages;
  final bool isLast;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onSignUp;
  final VoidCallback onLogin;
  final VoidCallback onGuest;

  static const _titleStyle = TextStyle(
    color: Colors.white,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static const _subtitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          slide.assetPath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) =>
              const ColoredBox(color: Colors.black),
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0, -0.2),
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Color(0x66000000),
                Color(0xE6000000),
                Color(0xFF000000),
              ],
              stops: [0.0, 0.35, 0.65, 1.0],
            ),
          ),
        ),
        SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (slide.showSkip)
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, right: 16),
                    child: TextButton(
                      onPressed: onSkip,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: _kOnboardingCoral,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Passer',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                )
              else
                const SizedBox(height: 52),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      slide.title,
                      textAlign: TextAlign.center,
                      style: _titleStyle,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      slide.subtitle,
                      textAlign: TextAlign.center,
                      style: _subtitleStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              if (isLast) ...[
                _PageDots(
                  count: totalPages,
                  activeIndex: currentPage,
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: _CoralFilledButton(
                          label: 'Créer un compte',
                          onPressed: onSignUp,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _CoralFilledButton(
                          label: 'Se connecter',
                          onPressed: onLogin,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: onGuest,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white, width: 1.2),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.black.withValues(alpha: 0.25),
                      ),
                      child: const Text(
                        'Continuer en tant qu\'invité',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12 + bottomInset),
              ] else ...[
                SizedBox(
                  height: 56,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      _PageDots(
                        count: totalPages,
                        activeIndex: currentPage,
                      ),
                      Positioned(
                        left: 8,
                        bottom: 0,
                        child: slideIndex > 0
                            ? IconButton(
                                onPressed: onBack,
                                icon: const Icon(
                                  Icons.chevron_left,
                                  color: Colors.white,
                                  size: 36,
                                ),
                                padding: EdgeInsets.zero,
                              )
                            : const SizedBox(width: 48),
                      ),
                      Positioned(
                        right: 16,
                        bottom: 0,
                        child: Material(
                          color: _kOnboardingCoral,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: onNext,
                            borderRadius: BorderRadius.circular(12),
                            child: const SizedBox(
                              width: 52,
                              height: 52,
                              child: Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16 + bottomInset),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({
    required this.count,
    required this.activeIndex,
  });

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == activeIndex;
        return Container(
          width: active ? 8 : 7,
          height: active ? 8 : 7,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? _kOnboardingCoral : Colors.white,
          ),
        );
      }),
    );
  }
}

class _CoralFilledButton extends StatelessWidget {
  const _CoralFilledButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: _kOnboardingCoral,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      child: Text(label, textAlign: TextAlign.center),
    );
  }
}

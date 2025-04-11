// lib/screens/home_screen.dart
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/widgets/navbar.dart';
import 'package:portfolio/sections/hero_section.dart';
import 'package:portfolio/sections/skills_section.dart';
import 'package:portfolio/sections/contact_section.dart';
import 'package:portfolio/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../sections/project_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  late AnimationController _animationController;
  int _currentSection = 0;

  final List<String> _sectionNames = [
    'Home',
    'Skills',
    'Projects',
    'Contact',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    itemPositionsListener.itemPositions.addListener(_updateCurrentSection);
  }

  void _updateCurrentSection() {
    final positions = itemPositionsListener.itemPositions.value;
    if (positions.isEmpty) return;

    // This gets the item that takes up most of the viewport
    final position = positions.where((item) {
      return item.itemTrailingEdge > 0 && item.itemLeadingEdge < 1;
    }).reduce((max, position) {
      return position.itemLeadingEdge < max.itemLeadingEdge ? position : max;
    });

    final index = position.index;
    if (index != _currentSection) {
      setState(() {
        _currentSection = index;
      });
    }
  }

  void scrollToSection(int index) {
    itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          _BackgroundAnimation(isDarkMode: themeProvider.isDarkMode),

          // Content with ScrollablePositionedList
          SafeArea(
            child: Column(
              children: [
                NavBar(
                  currentIndex: _currentSection,
                  onTap: scrollToSection,
                  sectionNames: _sectionNames,
                ),
                Expanded(
                  child: ScrollablePositionedList.builder(
                    itemCount: 5, // 4 sections + 1 footer
                    itemScrollController: itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return HeroSection(
                          onExplorePressed: () => scrollToSection(1),
                        );
                      } else if (index == 1) {
                        return const SkillsSection();
                      } else if (index == 2) {
                        return const ProjectsSection();
                      } else if (index == 3) {
                        // return const ContactSection();
                        return SizedBox();
                      } else {
                        // return const Footer();
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          // Glassmorphic floating action button for theme toggle
          Positioned(
            bottom: 24,
            right: 24,
            child: GlassmorphicContainer(
              borderRadius: 30,
              blur: 20,
              opacity: 0.2,
              borderGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.5),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundAnimation extends StatefulWidget {
  final bool isDarkMode;

  const _BackgroundAnimation({
    Key? key,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  State<_BackgroundAnimation> createState() => _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<_BackgroundAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _BackgroundPainter(
            animation: _controller,
            isDarkMode: widget.isDarkMode,
          ),
          child: Container(),
        );
      },
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final Animation<double> animation;
  final bool isDarkMode;

  _BackgroundPainter({
    required this.animation,
    required this.isDarkMode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Background gradient
    final backgroundGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDarkMode
          ? [
        const Color(0xFF121212),
        const Color(0xFF1E1E1E),
      ]
          : [
        const Color(0xFFF8F9FF),
        const Color(0xFFF0F4FF),
      ],
    ).createShader(rect);

    canvas.drawRect(rect, Paint()..shader = backgroundGradient);

    // Draw animated blobs
    _drawBlob(
      canvas: canvas,
      size: size,
      color: const Color(0xFF6E44FF).withOpacity(0.1),
      offsetX: size.width * 0.1,
      offsetY: size.height * 0.2,
      radiusX: size.width * 0.25,
      radiusY: size.height * 0.25,
      animationValue: animation.value,
    );

    _drawBlob(
      canvas: canvas,
      size: size,
      color: const Color(0xFF58E6D9).withOpacity(0.1),
      offsetX: size.width * 0.7,
      offsetY: size.height * 0.3,
      radiusX: size.width * 0.3,
      radiusY: size.height * 0.3,
      animationValue: 1 - animation.value,
    );

    _drawBlob(
      canvas: canvas,
      size: size,
      color: const Color(0xFFFF7DDB).withOpacity(0.1),
      offsetX: size.width * 0.5,
      offsetY: size.height * 0.7,
      radiusX: size.width * 0.35,
      radiusY: size.height * 0.35,
      animationValue: animation.value * 0.5,
    );
  }

  void _drawBlob({
    required Canvas canvas,
    required Size size,
    required Color color,
    required double offsetX,
    required double offsetY,
    required double radiusX,
    required double radiusY,
    required double animationValue,
  }) {
    final path = Path();
    final points = List.generate(8, (i) {
      final angle = i * 45 * 3.14159 / 180;
      final noise = (0.8 + 0.4 * sin(animationValue * 2 * 3.14159 + i));
      final x = offsetX + radiusX * noise * cos(angle);
      final y = offsetY + radiusY * noise * sin(angle);
      return Offset(x, y);
    });

    // Create a closed curve through all the points
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length; i++) {
      final p1 = points[i];
      final p2 = points[(i + 1) % points.length];
      final controlPoint1 = Offset(
        p1.dx + (p2.dx - p1.dx) / 3,
        p1.dy + (p2.dy - p1.dy) / 3,
      );
      final controlPoint2 = Offset(
        p1.dx + 2 * (p2.dx - p1.dx) / 3,
        p1.dy + 2 * (p2.dy - p1.dy) / 3,
      );

      path.cubicTo(
        controlPoint1.dx, controlPoint1.dy,
        controlPoint2.dx, controlPoint2.dy,
        p2.dx, p2.dy,
      );
    }

    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_BackgroundPainter oldDelegate) => true;
}

class GlassmorphicContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blur;
  final double opacity;
  final Gradient borderGradient;

  const GlassmorphicContainer({
    Key? key,
    required this.child,
    required this.borderRadius,
    required this.blur,
    required this.opacity,
    required this.borderGradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(opacity),
                Colors.white.withOpacity(opacity / 2),
              ],
            ),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
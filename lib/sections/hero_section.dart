// lib/sections/hero_section.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/theme/theme_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;
import 'dart:ui';

class HeroSection extends StatefulWidget {
  final VoidCallback onExplorePressed;

  const HeroSection({
    Key? key,
    required this.onExplorePressed,
  }) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(
      begin: -10.0,
      end: 10.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
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
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1024;
    final isTablet = size.width >= 768 && size.width < 1024;
    final isMobile = size.width < 768;

    return Container(
      height: size.height,
      width: size.width,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : (isTablet ? 40 : 20),
      ),
      child: Stack(
        children: [
          // Animated background elements
          Positioned(
            top: size.height * 0.1,
            right: size.width * 0.15,
            child: _buildFloatingShape(
              themeProvider.isDarkMode,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              size: 150,
              sides: 6,
            ),
          ),

          Positioned(
            bottom: size.height * 0.15,
            left: size.width * 0.1,
            child: _buildFloatingShape(
              themeProvider.isDarkMode,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
              size: 120,
              sides: 5,
              rotationOffset: 0.5,
            ),
          ),

          Positioned(
            top: size.height * 0.5,
            left: size.width * 0.4,
            child: _buildFloatingShape(
              themeProvider.isDarkMode,
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
              size: 80,
              sides: 4,
              rotationOffset: 1.0,
            ),
          ),

          // Content with parallax effect
          _ParallaxContainer(
            parallaxOffset: 100,
            child: Center(
              child: isMobile
                  ? _buildMobileContent(context)
                  : _buildDesktopContent(context),
            ),
          ),

          // Scroll indicator
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: InkWell(
                onTap: widget.onExplorePressed,
                child: Column(
                  children: [
                    Text(
                      'Explore More',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildScrollIndicator(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildDesktopContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left side content
        Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreeting(context),
              const SizedBox(height: 24),
              Text(
                "I'm Alex Morgan",
                style: GoogleFonts.rubik(
                  fontSize: 62,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 16),
              _buildAnimatedTitle(context),
              const SizedBox(height: 32),
              SizedBox(
                width: 500,
                child: Text(
                  "Crafting intuitive mobile experiences and stunning user interfaces that blend functionality and visual appeal. Let's build something amazing together.",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  _buildPrimaryButton(
                    context: context,
                    text: 'View My Work',
                    onPressed: () {},
                  ),
                  const SizedBox(width: 16),
                  _buildOutlineButton(
                    context: context,
                    text: 'Contact Me',
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 40),
              _buildSocialLinks(context),
            ],
          ),
        ),

        // Space between
        const SizedBox(width: 32),

        // Right side - avatar/illustration
        Expanded(
          flex: 4,
          child: _buildHeroImage(context),
        ),
      ],
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildHeroImage(context, isMobile: true),
        const SizedBox(height: 40),
        _buildGreeting(context),
        const SizedBox(height: 16),
        Text(
          "I'm Alex Morgan",
          style: GoogleFonts.rubik(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        _buildAnimatedTitle(context, centered: true),
        const SizedBox(height: 24),
        Text(
          "Crafting intuitive mobile experiences and stunning user interfaces that blend functionality and visual appeal.",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Column(
          children: [
            _buildPrimaryButton(
              context: context,
              text: 'View My Work',
              onPressed: () {},
              fullWidth: true,
            ),
            const SizedBox(height: 16),
            _buildOutlineButton(
              context: context,
              text: 'Contact Me',
              onPressed: () {},
              fullWidth: true,
            ),
          ],
        ),
        const SizedBox(height: 32),
        _buildSocialLinks(context),
      ],
    );
  }

  Widget _buildGreeting(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Text(
        '👋 Hello there!',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildAnimatedTitle(BuildContext context, {bool centered = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "A ",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
          ),
        ),
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Mobile Developer',
              textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
              speed: const Duration(milliseconds: 100),
            ),
            TypewriterAnimatedText(
              'UI/UX Designer',
              textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
              speed: const Duration(milliseconds: 100),
            ),
            TypewriterAnimatedText(
              'Flutter Expert',
              textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.bold,
              ),
              speed: const Duration(milliseconds: 100),
            ),
          ],
          totalRepeatCount: 3,
          pause: const Duration(milliseconds: 1000),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ),
      ],
    );
  }

  Widget _buildPrimaryButton({
    required BuildContext context,
    required String text,
    required VoidCallback onPressed,
    bool fullWidth = false,
  }) {
    return Container(
      width: fullWidth ? double.infinity : null,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildOutlineButton({
    required BuildContext context,
    required String text,
    required VoidCallback onPressed,
    bool fullWidth = false,
  }) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.onBackground.withOpacity(0.7);
    final iconSize = 24.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(context, FontAwesomeIcons.github, () {}, iconColor, iconSize),
        const SizedBox(width: 24),
        _buildSocialIcon(context, FontAwesomeIcons.linkedin, () {}, iconColor, iconSize),
        const SizedBox(width: 24),
        _buildSocialIcon(context, FontAwesomeIcons.twitter, () {}, iconColor, iconSize),
        const SizedBox(width: 24),
        _buildSocialIcon(context, FontAwesomeIcons.dribbble, () {}, iconColor, iconSize),
      ],
    );
  }

  Widget _buildSocialIcon(BuildContext context, IconData icon, VoidCallback onTap, Color color, double size) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: FaIcon(
          icon,
          color: color,
          size: size,
        ),
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context, {bool isMobile = false}) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatingAnimation.value),
          child: Container(
            width: isMobile ? 250 : 450,
            height: isMobile ? 250 : 450,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  Theme.of(context).colorScheme.background.withOpacity(0),
                ],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background circle
                Container(
                  width: isMobile ? 220 : 400,
                  height: isMobile ? 220 : 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                ),

                // Avatar placeholder
                ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.network(
                    'https://avataaars.io/?avatarStyle=Circle&topType=ShortHairShortWaved&accessoriesType=Blank&hairColor=Black&facialHairType=Blank&clotheType=Hoodie&clotheColor=Blue03&eyeType=Happy&eyebrowType=Default&mouthType=Smile&skinColor=Light',
                    width: isMobile ? 200 : 380,
                    height: isMobile ? 200 : 380,
                    fit: BoxFit.cover,
                  ),
                ),

                // Glassmorphic floating tech icons
                if (!isMobile) ...[
                  _buildFloatingTechIcon(context, 'assets/flutter.svg', Alignment.topRight),
                  _buildFloatingTechIcon(context, 'assets/react.svg', Alignment.bottomLeft),
                  _buildFloatingTechIcon(context, 'assets/figma.svg', Alignment.bottomRight),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingTechIcon(BuildContext context, String svgPath, Alignment alignment) {
    return Positioned(
      top: alignment == Alignment.topRight ? 40 : null,
      bottom: alignment == Alignment.bottomLeft || alignment == Alignment.bottomRight ? 40 : null,
      left: alignment == Alignment.bottomLeft ? 40 : null,
      right: alignment == Alignment.topRight || alignment == Alignment.bottomRight ? 40 : null,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Icon(
          alignment == Alignment.topRight
              ? Icons.flutter_dash
              : (alignment == Alignment.bottomLeft ? Icons.code : Icons.design_services),
          size: 28,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildFloatingShape(bool isDarkMode, {
    required Color color,
    required double size,
    required int sides,
    double rotationOffset = 0.0,
  }) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final rotate = _animationController.value * math.pi * rotationOffset;
        final translateX = math.sin(_animationController.value * math.pi * 2) * 15;
        final translateY = math.cos(_animationController.value * math.pi * 2) * 15;

        return Transform.translate(
          offset: Offset(translateX, translateY),
          child: Transform.rotate(
            angle: rotate,
            child: ClipPath(
              clipper: _PolygonClipper(sides: sides),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  border: Border.all(
                    color: color.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildScrollIndicator(BuildContext context) {
    return Container(
      width: 30,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _animationController.value * 20),
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PolygonClipper extends CustomClipper<Path> {
  final int sides;

  _PolygonClipper({required this.sides});

  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    for (int i = 0; i < sides; i++) {
      final angle = 2 * math.pi * i / sides - math.pi / 2;
      final point = center + Offset(radius * math.cos(angle), radius * math.sin(angle));

      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class _ParallaxContainer extends StatefulWidget {
  final Widget child;
  final double parallaxOffset;

  const _ParallaxContainer({
    Key? key,
    required this.child,
    this.parallaxOffset = 50.0,
  }) : super(key: key);

  @override
  _ParallaxContainerState createState() => _ParallaxContainerState();
}

class _ParallaxContainerState extends State<_ParallaxContainer> {
  Offset _position = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        final size = MediaQuery.of(context).size;
        final centerX = size.width / 2;
        final centerY = size.height / 2;

        // Calculate distance from center
        final dx = (event.position.dx - centerX) / centerX;
        final dy = (event.position.dy - centerY) / centerY;

        setState(() {
          _position = Offset(
            dx * widget.parallaxOffset,
            dy * widget.parallaxOffset,
          );
        });
      },
      onExit: (_) {
        setState(() {
          _position = Offset.zero;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.translationValues(_position.dx, _position.dy, 0),
        child: widget.child,
      ),
    );
  }
}
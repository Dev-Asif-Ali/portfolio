// lib/sections/skills_section.dart
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1024;
    final isTablet = size.width >= 768 && size.width < 1024;
    final isMobile = size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : (isTablet ? 40 : 20),
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header with glassmorphic effect
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '🚀 My Skills',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Section title
          Center(
            child: Text(
              'Tech Stack & Expertise',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),

          // Section description
          Center(
            child: SizedBox(
              width: isDesktop ? 700 : double.infinity,
              child: Text(
                'I specialize in modern mobile and web development with a focus on creating beautiful, responsive interfaces and seamless user experiences.',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 64),

          // Skills content
          isMobile
              ? _buildMobileSkillsContent(context)
              : _buildDesktopSkillsContent(context),
        ],
      ),
    );
  }

  Widget _buildDesktopSkillsContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - skill categories
        Expanded(
          flex: 5,
          child: _buildSkillCategories(context),
        ),

        const SizedBox(width: 48),

        // Right side - skill chart
        Expanded(
          flex: 5,
          child: _buildSkillLevelsChart(context),
        ),
      ],
    );
  }

  Widget _buildMobileSkillsContent(BuildContext context) {
    return Column(
      children: [
        _buildSkillCategories(context),
        const SizedBox(height: 48),
        _buildSkillLevelsChart(context),
      ],
    );
  }

  Widget _buildSkillCategories(BuildContext context) {
    final categories = [
      {
        'title': 'Frontend Development',
        'icon': Icons.code,
        'skills': ['Flutter', 'React', 'Angular', 'Vue.js', 'SwiftUI'],
      },
      {
        'title': 'UI/UX Design',
        'icon': Icons.design_services,
        'skills': ['Figma', 'Adobe XD', 'Sketch', 'Prototyping', 'Wireframing'],
      },
      {
        'title': 'Backend Development',
        'icon': Icons.storage,
        'skills': ['Node.js', 'Firebase', 'GraphQL', 'REST APIs', 'MongoDB'],
      }
    ];

    return Column(
      children: categories.map((category) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: GlassmorphicContainer(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: 16,
            blur: 10,
            opacity: 0.1,
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.2),
                Colors.white.withOpacity(0.1),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          category['icon'] as IconData,
                          color: Theme.of(context).colorScheme.primary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        category['title'] as String,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: (category['skills'] as List<String>).map((skill) {
                      return Chip(
                        label: Text(skill),
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ).animate()
            .fadeIn(duration: 600.ms, delay: 200.ms)
            .slideY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuint);
      }).toList(),
    );
  }

  Widget _buildSkillLevelsChart(BuildContext context) {
    final skills = [
      {'name': 'Flutter', 'level': 0.95},
      {'name': 'UI/UX Design', 'level': 0.85},
      {'name': 'React Native', 'level': 0.80},
      {'name': 'Firebase', 'level': 0.75},
      {'name': 'Node.js', 'level': 0.70},
    ];

    return GlassmorphicContainer(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: 16,
      blur: 10,
      opacity: 0.1,
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.2),
          Colors.white.withOpacity(0.1),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Proficiency Levels',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            ...skills.asMap().entries.map((entry) {
              final index = entry.key;
              final skill = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          skill['name'] as String,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '${((skill['level'] as double) * 100).toInt()}%',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          children: [
                            // Background bar
                            Container(
                              width: constraints.maxWidth,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),

                            // Foreground bar with animation
                            AnimatedContainer(
                              duration: Duration(milliseconds: 800 + (index * 200)),
                              width: constraints.maxWidth * (skill['level'] as double),
                              height: 8,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(context).colorScheme.secondary,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ).animate()
                  .fadeIn(duration: 600.ms, delay: (200 + index * 100).ms)
                  .slideX(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuint);
            }),
          ],
        ),
      ),
    );
  }
}

class GlassmorphicContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blur;
  final double opacity;
  final Gradient borderGradient;
  final Color color;

  const GlassmorphicContainer({
  Key? key,
  required this.child,
  this.borderRadius = 20,
    this.blur = 20,
    this.opacity = 0.2,
    required this.borderGradient,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(opacity),
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
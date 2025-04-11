// lib/sections/projects_section.dart
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({Key? key}) : super(key: key);

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _categories = ['All', 'Mobile Apps', 'UI/UX', 'Web'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '💼 Featured Work',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
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
              'Recent Projects',
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
                'Explore my portfolio of recent projects, showcasing my expertise in mobile development, UI/UX design, and web applications.',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 48),

          // Category tabs
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: isMobile,
              tabs: _categories.map((category) {
                return Tab(text: category);
              }).toList(),
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              ),
              labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: Theme.of(context).textTheme.titleMedium,
              padding: const EdgeInsets.all(8),
            ),
          ),
          const SizedBox(height: 48),

          // Projects grid view
          SizedBox(
            height: isMobile ? 1500 : (isTablet ? 1000 : 800),
            child: TabBarView(
              controller: _tabController,
              children: _categories.map((category) {
                return _buildProjectsGrid(context, category, isMobile, isTablet);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, String category, bool isMobile, bool isTablet) {
    final projects = _getFilteredProjects(category);

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: isMobile ? 0.8 : 0.75,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return _buildProjectCard(context, project, index);
      },
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project, int index) {
    return GlassmorphicProjectCard(
      title: project['title'] as String,
      description: project['description'] as String,
      imageUrl: project['image'] as String,
      tags: project['tags'] as List<String>,
      index: index,
    ).animate()
        .fadeIn(duration: 600.ms, delay: (100 * index).ms)
        .slideY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuint);
  }

  List<Map<String, dynamic>> _getFilteredProjects(String category) {
    final allProjects = _getProjects();

    if (category == 'All') {
      return allProjects;
    }

    return allProjects.where((project) {
      final tags = project['tags'] as List<String>;
      return tags.contains(category);
    }).toList();
  }

  List<Map<String, dynamic>> _getProjects() {
    return [
      {
        'title': 'Taskify',
        'description': 'A beautiful task management app with intuitive UI, real-time collaboration, and smart organization features.',
        'image': 'https://cdn.dribbble.com/users/1615584/screenshots/17037906/media/03650637c64d6d736e89344188e8ee25.jpg',
        'tags': ['Mobile Apps', 'UI/UX'],
      },
      {
        'title': 'FinTrack',
        'description': 'Personal finance tracker with expense analytics, budget planning, and financial insights.',
        'image': 'https://cdn.dribbble.com/users/3847465/screenshots/15285500/media/f0f6a831321ccaf304dd671bad27b6fd.png',
        'tags': ['Mobile Apps', 'UI/UX'],
      },
      {
        'title': 'Designify',
        'description': 'UI/UX design system with reusable components and atomic design principles.',
        'image': 'https://cdn.dribbble.com/users/1615584/screenshots/16225731/media/6f19297f9e9c12ab132e1c43b5682148.jpg',
        'tags': ['UI/UX', 'Web'],
      },
      {
        'title': 'E-Commerce Dashboard',
        'description': 'Comprehensive admin panel for e-commerce platforms with analytics and inventory management.',
        'image': 'https://cdn.dribbble.com/users/1615584/screenshots/14864297/media/901ef00e60a5c16437313339fc1662be.jpg',
        'tags': ['Web', 'UI/UX'],
      },
      {
        'title': 'TravelBuddy',
        'description': 'Travel companion app with trip planning, itinerary management, and location-based recommendations.',
        'image': 'https://cdn.dribbble.com/users/1615584/screenshots/15571949/media/7e190968742d59fd36a60ec875033a0d.jpg',
        'tags': ['Mobile Apps'],
      },
      {
        'title': 'Fitbit App Redesign',
        'description': 'A conceptual redesign of the Fitbit mobile app with enhanced user experience and visual appeal.',
        'image': 'https://cdn.dribbble.com/users/1615584/screenshots/15696885/media/82deb2f3bcffcd7a31d3d5bef5fbdab4.jpg',
        'tags': ['Mobile Apps', 'UI/UX'],
      },
    ];
  }
}

class GlassmorphicProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> tags;
  final int index;

  const GlassmorphicProjectCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.tags,
    required this.index,
  }) : super(key: key);

  @override
  State<GlassmorphicProjectCard> createState() => _GlassmorphicProjectCardState();
}

class _GlassmorphicProjectCardState extends State<GlassmorphicProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuint,
          transform:
          Matrix4.identity()..translate(00),

    child: GestureDetector(
          onTap: () {
            // Navigate to project details
          },
          child: Stack(
            children: [
              // Card background
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ),

              // Overlay gradient
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.9),
                        ],
                        stops: const [0.5, 1.0],
                      ),
                    ),
                  ),
                ),
              ),

              // Content
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutQuint,
                  transform: Matrix4.identity()..translate(0, -10),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tags
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.tags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),

                      // Title
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Description
                      Text(
                        widget.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 16),

                      // View project button
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: _isHovered ? 1.0 : 0.0,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to project details
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'View Project',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_forward,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
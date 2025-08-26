// ============================================================================
// MODEL
// ============================================================================

import 'package:jaspr/server.dart';

class Project {
  final String id;
  final String title;
  final String description;
  final List<String> technologies;
  final String? imageUrl;
  final String? liveUrl;
  final String? githubUrl;
  final DateTime createdAt;
  final bool isFeatured;
  final ProjectStatus status;
  final bool isGithubPublic;
  final String category;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.technologies,
    this.imageUrl,
    this.liveUrl,
    this.githubUrl,
    required this.createdAt,
    this.isFeatured = false,
    this.status = ProjectStatus.completed,
    this.isGithubPublic = true,
    required this.category,
  });

  @decoder
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      technologies: List<String>.from(json['technologies'] as List),
      imageUrl: json['imageUrl'] as String?,
      liveUrl: json['liveUrl'] as String?,
      githubUrl: json['githubUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isFeatured: json['isFeatured'] as bool? ?? false,
      status: ProjectStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ProjectStatus.completed,
      ),
      isGithubPublic: json['isGithubPublic'] as bool? ?? true,
      category: json['category'] as String,
    );
  }

  @encoder
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'technologies': technologies,
      'imageUrl': imageUrl,
      'liveUrl': liveUrl,
      'githubUrl': githubUrl,
      'createdAt': createdAt.toIso8601String(),
      'isFeatured': isFeatured,
      'status': status.name,
      'isGithubPublic': isGithubPublic,
      'category': category,
    };
  }
}

enum ProjectStatus {
  inProgress,
  completed,
  archived;

  String get displayName {
    switch (this) {
      case ProjectStatus.inProgress:
        return 'In Progress';
      case ProjectStatus.completed:
        return 'Live';
      case ProjectStatus.archived:
        return 'Archived';
    }
  }
}

// Extension for List<Project> operations
extension ProjectListExtensions on List<Project> {
  
  /// Get featured projects sorted by creation date (newest first)
  List<Project> get featuredProjects => 
      where((project) => project.isFeatured)
          .toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  /// Get all projects sorted by featured first, then by creation date (newest first)
  List<Project> get latestProjects =>
      toList()..sort((a, b) {
        // Featured projects come first
        if (a.isFeatured && !b.isFeatured) return -1;
        if (!a.isFeatured && b.isFeatured) return 1;
        // Then sort by creation date (newest first)
        return b.createdAt.compareTo(a.createdAt);
      });

  /// Get non-featured projects sorted by creation date (newest first)
  List<Project> get nonFeaturedProjects =>
      where((project) => !project.isFeatured)
          .toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  /// Get projects by category sorted by featured first, then by creation date
  List<Project> getProjectsByCategory(String category) {
    final filtered = category.toLowerCase() == 'all' 
        ? this 
        : where((project) => project.category == category).toList();
    
    return filtered..sort((a, b) {
      // Featured projects come first
      if (a.isFeatured && !b.isFeatured) return -1;
      if (!a.isFeatured && b.isFeatured) return 1;
      // Then sort by creation date (newest first)
      return b.createdAt.compareTo(a.createdAt);
    });
  }

  /// Get unique categories from all projects
  List<String> get availableCategories {
    final categories = map((project) => project.category).toSet().toList();
    categories.sort();
    return ['All', ...categories];
  }

  /// Get projects by technology
  List<Project> getProjectsByTechnology(String technology) {
    return where((project) => project.technologies.contains(technology))
        .toList()
        ..sort((a, b) {
          // Featured projects come first
          if (a.isFeatured && !b.isFeatured) return -1;
          if (!a.isFeatured && b.isFeatured) return 1;
          // Then sort by creation date (newest first)
          return b.createdAt.compareTo(a.createdAt);
        });
  }

  /// Get projects by status
  List<Project> getProjectsByStatus(ProjectStatus status) {
    return where((project) => project.status == status)
        .toList()
        ..sort((a, b) {
          // Featured projects come first
          if (a.isFeatured && !b.isFeatured) return -1;
          if (!a.isFeatured && b.isFeatured) return 1;
          // Then sort by creation date (newest first)
          return b.createdAt.compareTo(a.createdAt);
        });
  }

  /// Get public projects only
  List<Project> get publicProjects =>
      where((project) => project.isGithubPublic)
          .toList()
          ..sort((a, b) {
            // Featured projects come first
            if (a.isFeatured && !b.isFeatured) return -1;
            if (!a.isFeatured && b.isFeatured) return 1;
            // Then sort by creation date (newest first)
            return b.createdAt.compareTo(a.createdAt);
          });

  /// Get completed projects only
  List<Project> get completedProjects =>
      where((project) => project.status == ProjectStatus.completed)
          .toList()
          ..sort((a, b) {
            // Featured projects come first
            if (a.isFeatured && !b.isFeatured) return -1;
            if (!a.isFeatured && b.isFeatured) return 1;
            // Then sort by creation date (newest first)
            return b.createdAt.compareTo(a.createdAt);
          });

  /// Get recent projects (last 6 months)
  List<Project> get recentProjects {
    final sixMonthsAgo = DateTime.now().subtract(const Duration(days: 180));
    return where((project) => project.createdAt.isAfter(sixMonthsAgo))
        .toList()
        ..sort((a, b) {
          // Featured projects come first
          if (a.isFeatured && !b.isFeatured) return -1;
          if (!a.isFeatured && b.isFeatured) return 1;
          // Then sort by creation date (newest first)
          return b.createdAt.compareTo(a.createdAt);
        });
  }

  /// Get projects from a specific year
  List<Project> getProjectsByYear(int year) {
    return where((project) => project.createdAt.year == year)
        .toList()
        ..sort((a, b) {
          // Featured projects come first
          if (a.isFeatured && !b.isFeatured) return -1;
          if (!a.isFeatured && b.isFeatured) return 1;
          // Then sort by creation date (newest first)
          return b.createdAt.compareTo(a.createdAt);
        });
  }
}

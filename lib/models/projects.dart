// ============================================================================
// MODEL
// ============================================================================

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
  });
}

enum ProjectStatus {
  inProgress,
  completed,
  archived,
}

// ============================================================================
// SAMPLE DATA
// ============================================================================

class SampleProjects {
  static final List<Project> projects = [
    Project(
      id: 'portfolio-website',
      title: 'Portfolio Website',
      description:
          'A modern, responsive portfolio website built with Jaspr framework. Features dark/light theme switching, smooth animations, and server-side rendering for optimal performance.',
      technologies: ['Dart', 'Jaspr', 'Tailwind CSS', 'Riverpod'],
      imageUrl: '/images/projects/portfolio.png',
      liveUrl: 'https://gozieihejirika.com',
      githubUrl: 'https://github.com/gozie/portfolio',
      createdAt: DateTime(2024, 12, 1),
      isFeatured: true,
      status: ProjectStatus.completed,
    ),
    Project(
      id: 'task-manager',
      title: 'Jaspr Task Manager',
      description:
          'A full-stack task management application showcasing Jaspr\'s capabilities with real-time updates, user authentication, and responsive design.',
      technologies: ['Dart', 'Jaspr', 'PostgreSQL', 'Shelf', 'WebSockets'],
      imageUrl: '/images/projects/task-manager.png',
      liveUrl: 'https://tasks.gozieihejirika.com',
      githubUrl: 'https://github.com/gozie/jaspr-tasks',
      createdAt: DateTime(2024, 11, 15),
      isFeatured: true,
      status: ProjectStatus.completed,
    ),
    Project(
      id: 'weather-app',
      title: 'Weather Dashboard',
      description:
          'Clean and intuitive weather application with location-based forecasts, beautiful animations, and offline support.',
      technologies: ['Dart', 'Jaspr', 'OpenWeather API', 'Service Worker'],
      imageUrl: '/images/projects/weather.png',
      liveUrl: 'https://weather.gozieihejirika.com',
      githubUrl: 'https://github.com/gozie/weather-dashboard',
      createdAt: DateTime(2024, 10, 20),
      isFeatured: false,
      status: ProjectStatus.completed,
    ),
    Project(
      id: 'ecommerce-platform',
      title: 'E-commerce Platform',
      description:
          'Modern e-commerce solution with payment integration, inventory management, and admin dashboard. Built for scalability and performance.',
      technologies: ['Dart', 'Jaspr', 'Stripe', 'Firebase', 'Docker'],
      imageUrl: '/images/projects/ecommerce.png',
      githubUrl: 'https://github.com/gozie/ecommerce-jaspr',
      createdAt: DateTime(2024, 9, 10),
      isFeatured: true,
      status: ProjectStatus.inProgress,
    ),
    Project(
      id: 'blog-engine',
      title: 'Markdown Blog Engine',
      description:
          'Lightweight blog engine that converts markdown files to beautiful web pages with syntax highlighting and SEO optimization.',
      technologies: ['Dart', 'Jaspr', 'Markdown', 'Prism.js'],
      imageUrl: '/images/projects/blog.png',
      liveUrl: 'https://blog.gozieihejirika.com',
      githubUrl: 'https://github.com/gozie/markdown-blog',
      createdAt: DateTime(2024, 8, 5),
      isFeatured: false,
      status: ProjectStatus.completed,
    ),
    Project(
      id: 'chat-app',
      title: 'Real-time Chat Application',
      description:
          'Feature-rich chat application with rooms, file sharing, and emoji reactions. Demonstrates real-time capabilities of Jaspr.',
      technologies: ['Dart', 'Jaspr', 'WebSockets', 'Redis', 'Docker'],
      imageUrl: '/images/projects/chat.png',
      githubUrl: 'https://github.com/gozie/jaspr-chat',
      createdAt: DateTime(2024, 7, 12),
      isFeatured: false,
      status: ProjectStatus.archived,
    ),
  ];
}

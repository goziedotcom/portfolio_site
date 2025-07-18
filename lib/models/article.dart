// ============================================================================
// MODEL
// ============================================================================

class Article {
  final String id;
  final String title;
  final String excerpt;
  final String content;
  final List<String> tags;
  final String? imageUrl;
  final DateTime publishedAt;
  final DateTime? updatedAt;
  final int readTimeMinutes;
  final bool isPublished;
  final ArticleCategory category;

  const Article({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.tags,
    this.imageUrl,
    required this.publishedAt,
    this.updatedAt,
    required this.readTimeMinutes,
    this.isPublished = true,
    required this.category,
  });
}

enum ArticleCategory {
  dart,
  jaspr,
  webDevelopment,
  tutorial,
  thoughts,
}

// ============================================================================
// SAMPLE DATA
// ============================================================================

class SampleArticles {
  static final List<Article> articles = [
    Article(
      id: 'getting-started-jaspr',
      title: 'Getting Started with Jaspr: The Future of Dart Web Development',
      excerpt:
          'Discover how Jaspr is revolutionizing web development with Dart. Learn the basics and build your first server-side rendered application.',
      content: 'Full article content would go here...',
      tags: ['Jaspr', 'Dart', 'Web Development', 'SSR'],
      imageUrl: '/images/articles/jaspr-intro.png',
      publishedAt: DateTime(2024, 12, 10),
      readTimeMinutes: 8,
      category: ArticleCategory.jaspr,
    ),
    Article(
      id: 'dart-web-performance',
      title: 'Optimizing Web Performance with Dart and Jaspr',
      excerpt:
          'Learn advanced techniques for building lightning-fast web applications using Dart and Jaspr framework.',
      content: 'Full article content would go here...',
      tags: ['Performance', 'Dart', 'Jaspr', 'Optimization'],
      imageUrl: '/images/articles/performance.png',
      publishedAt: DateTime(2024, 11, 28),
      readTimeMinutes: 12,
      category: ArticleCategory.webDevelopment,
    ),
    Article(
      id: 'state-management-riverpod',
      title: 'State Management in Jaspr with Riverpod',
      excerpt:
          'Master state management in your Jaspr applications using Riverpod. From basics to advanced patterns.',
      content: 'Full article content would go here...',
      tags: ['Riverpod', 'State Management', 'Jaspr', 'Architecture'],
      imageUrl: '/images/articles/riverpod.png',
      publishedAt: DateTime(2024, 11, 15),
      readTimeMinutes: 15,
      category: ArticleCategory.tutorial,
    ),
    Article(
      id: 'responsive-design-tailwind',
      title: 'Building Responsive UIs with Tailwind CSS and Jaspr',
      excerpt:
          'Create beautiful, responsive user interfaces that work perfectly across all devices using Tailwind CSS with Jaspr.',
      content: 'Full article content would go here...',
      tags: ['Tailwind CSS', 'Responsive Design', 'UI/UX', 'Jaspr'],
      imageUrl: '/images/articles/responsive.png',
      publishedAt: DateTime(2024, 10, 30),
      readTimeMinutes: 10,
      category: ArticleCategory.tutorial,
    ),
    Article(
      id: 'dart-future-web',
      title: 'Why Dart is the Future of Web Development',
      excerpt:
          'Explore the unique advantages Dart brings to web development and why it\'s becoming the go-to choice for modern applications.',
      content: 'Full article content would go here...',
      tags: ['Dart', 'Web Development', 'Future', 'Technology'],
      imageUrl: '/images/articles/dart-future.png',
      publishedAt: DateTime(2024, 10, 15),
      readTimeMinutes: 7,
      category: ArticleCategory.thoughts,
    ),
    Article(
      id: 'jaspr-vs-flutter-web',
      title: 'Jaspr vs Flutter Web: Choosing the Right Framework',
      excerpt:
          'A comprehensive comparison between Jaspr and Flutter Web to help you choose the best framework for your next project.',
      content: 'Full article content would go here...',
      tags: ['Jaspr', 'Flutter Web', 'Comparison', 'Framework'],
      imageUrl: '/images/articles/comparison.png',
      publishedAt: DateTime(2024, 9, 20),
      readTimeMinutes: 11,
      category: ArticleCategory.dart,
    ),
  ];
}

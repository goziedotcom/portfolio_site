// ============================================================================
// MODEL
// ============================================================================

class Article {
  final String id;
  final String title;
  final String excerpt;
  final String articleUrl;
  final List<String> tags;
  final String? imageUrl;
  final DateTime publishedAt;
  final int readTimeMinutes;
  final String category;
  final bool isFeatured;

  const Article({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.articleUrl,
    required this.tags,
    this.imageUrl,
    required this.publishedAt,
    required this.readTimeMinutes,
    required this.category,
    this.isFeatured = false,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as String,
      title: json['title'] as String,
      excerpt: json['excerpt'] as String,
      articleUrl: json['articleUrl'] as String,
      tags: List<String>.from(json['tags'] as List),
      imageUrl: json['imageUrl'] as String?,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      readTimeMinutes: json['readTimeMinutes'] as int,
      category: json['category'] as String,
      isFeatured: json['isFeatured'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'excerpt': excerpt,
      'articleUrl': articleUrl,
      'tags': tags,
      'imageUrl': imageUrl,
      'publishedAt': publishedAt.toIso8601String(),
      'readTimeMinutes': readTimeMinutes,
      'category': category,
      'isFeatured': isFeatured,
    };
  }

  // Helper method to format date
  String get formattedDate {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[publishedAt.month - 1]} ${publishedAt.day}, ${publishedAt.year}';
  }

  // Helper method to format read time
  String get readTime => '$readTimeMinutes min read';
}

// Extension for List<Article> operations
extension ArticleListExtensions on List<Article> {
  /// Get featured articles sorted by publication date (newest first)
  List<Article> get featuredArticles => where((article) => article.isFeatured).toList()
    ..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));

  /// Get all articles sorted by featured first, then by publication date (newest first)
  List<Article> get latestArticles => toList()
    ..sort((a, b) {
      // Featured articles come first
      if (a.isFeatured && !b.isFeatured) return -1;
      if (!a.isFeatured && b.isFeatured) return 1;
      // Then sort by publication date (newest first)
      return b.publishedAt.compareTo(a.publishedAt);
    });

  /// Get non-featured articles sorted by publication date (newest first)
  List<Article> get nonFeaturedArticles => where((article) => !article.isFeatured).toList()
    ..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));

  /// Get articles by category sorted by featured first, then by publication date
  List<Article> getArticlesByCategory(String category) {
    final filtered = category.toLowerCase() == 'all'
        ? this
        : where((article) => article.category == category).toList();

    return filtered
      ..sort((a, b) {
        // Featured articles come first
        if (a.isFeatured && !b.isFeatured) return -1;
        if (!a.isFeatured && b.isFeatured) return 1;
        // Then sort by publication date (newest first)
        return b.publishedAt.compareTo(a.publishedAt);
      });
  }

  /// Get unique categories from all articles
  List<String> get availableCategories {
    final categories = map((article) => article.category).toSet().toList();
    categories.sort();
    return ['All', ...categories];
  }

  /// Get articles by tag sorted by featured first, then by publication date
  List<Article> getArticlesByTag(String tag) {
    return where((article) => article.tags.contains(tag)).toList()
      ..sort((a, b) {
        // Featured articles come first
        if (a.isFeatured && !b.isFeatured) return -1;
        if (!a.isFeatured && b.isFeatured) return 1;
        // Then sort by publication date (newest first)
        return b.publishedAt.compareTo(a.publishedAt);
      });
  }

  /// Get recent articles (last 30 days)
  List<Article> get recentArticles {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    return where((article) => article.publishedAt.isAfter(thirtyDaysAgo)).toList()
      ..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }

  /// Get articles from a specific year
  List<Article> getArticlesByYear(int year) {
    return where((article) => article.publishedAt.year == year).toList()
      ..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }
}

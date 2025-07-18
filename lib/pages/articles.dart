// ============================================================================
// ARTICLES PAGE
// ============================================================================

import 'package:jaspr/jaspr.dart';
import 'package:portfolio_site/models/article.dart';

class ArticlesPage extends StatelessComponent {
  const ArticlesPage({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final recentArticles = SampleArticles.articles.take(3).toList();
    final categories = ArticleCategory.values;

    yield div(
      classes: 'min-h-screen bg-bg-primary theme-transition',
      [
        // Hero Section
        section(
          classes: 'section-container',
          [
            div(
              classes: 'text-center mb-16',
              [
                h1(
                  classes: 'section-title',
                  [text('Articles & Insights')],
                ),
                p(
                  classes: 'text-xl text-gray-600 dark:text-gray-400 max-w-3xl mx-auto',
                  [text('Thoughts, tutorials, and insights about Dart, Jaspr, and modern web development. Sharing knowledge and experiences from the journey.')],
                ),
              ],
            ),
          ],
        ),

        // Category Filter (placeholder for future functionality)
        section(
          classes: 'py-8 bg-gray-50 dark:bg-gray-900/50',
          [
            div(
              classes: 'max-w-6xl mx-auto px-8',
              [
                div(
                  classes: 'flex flex-wrap justify-center gap-4 mb-8',
                  [
                    button(
                      classes: 'px-4 py-2 rounded-full bg-purple-500 text-white font-medium',
                      [text('All')],
                    ),
                    for (final category in categories)
                      button(
                        classes: 'px-4 py-2 rounded-full bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 hover:bg-purple-50 dark:hover:bg-purple-900/20 transition-colors duration-200',
                        [text(_formatCategoryName(category))],
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // Recent Articles
        section(
          classes: 'section-container',
          [
            div(
              classes: 'px-8',
              [
                h2(
                  classes: 'text-3xl font-bold mb-8 text-center gradient-text',
                  [text('Latest Articles')],
                ),
                div(
                  classes: 'articles-grid',
                  [
                    for (final article in recentArticles)
                      _buildArticleCard(article, isRecent: true),
                  ],
                ),
              ],
            ),
          ],
        ),

        // All Articles
        section(
          classes: 'py-20 bg-gray-50 dark:bg-gray-900/50',
          [
            div(
              classes: 'max-w-6xl mx-auto px-8',
              [
                h2(
                  classes: 'text-3xl font-bold mb-12 text-center text-gray-900 dark:text-white',
                  [text('All Articles')],
                ),
                div(
                  classes: 'articles-grid',
                  [
                    for (final article in SampleArticles.articles)
                      _buildArticleCard(article),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildArticleCard(Article article, {bool isRecent = false}) {
    return div(
      classes: 'article-card ${isRecent ? 'ring-2 ring-purple-500/20' : ''}',
      [
        // Article Image
        if (article.imageUrl != null)
          div(
            classes: 'w-full h-48 mb-6 rounded-lg overflow-hidden bg-gray-100 dark:bg-gray-800',
            [
              img(
                src: article.imageUrl!,
                alt: article.title,
                classes: 'w-full h-full object-cover hover:scale-105 transition-transform duration-300',
              ),
            ],
          ),

        // Category and Date
        div(
          classes: 'flex justify-between items-center mb-4',
          [
            span(
              classes: 'bg-purple-100 dark:bg-purple-900/30 text-purple-800 dark:text-purple-400 text-xs px-2 py-1 rounded-full font-medium',
              [text(_formatCategoryName(article.category))],
            ),
            div(
              classes: 'text-sm text-gray-500 dark:text-gray-400',
              [text(_formatDate(article.publishedAt))],
            ),
          ],
        ),

        // Article Title
        h3(
          classes: 'article-title',
          [text(article.title)],
        ),

        // Article Excerpt
        p(
          classes: 'article-excerpt',
          [text(article.excerpt)],
        ),

        // Tags
        div(
          classes: 'tech-tags',
          [
            for (final tag in article.tags.take(3))
              span(
                classes: 'tech-tag',
                [text(tag)],
              ),
          ],
        ),

        // Read More and Meta
        div(
          classes: 'flex justify-between items-center',
          [
            a(
              href: '/articles/${article.id}',
              classes: 'read-more',
              [text('Read More →')],
            ),
            span(
              classes: 'text-sm text-gray-500 dark:text-gray-400',
              [text('${article.readTimeMinutes} min read')],
            ),
          ],
        ),
      ],
    );
  }

  String _formatCategoryName(ArticleCategory category) {
    switch (category) {
      case ArticleCategory.dart:
        return 'Dart';
      case ArticleCategory.jaspr:
        return 'Jaspr';
      case ArticleCategory.webDevelopment:
        return 'Web Dev';
      case ArticleCategory.tutorial:
        return 'Tutorial';
      case ArticleCategory.thoughts:
        return 'Thoughts';
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

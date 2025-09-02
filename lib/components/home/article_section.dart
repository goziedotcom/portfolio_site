import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:portfolio_site/components/ui/button.dart';
import 'package:portfolio_site/models/article_model.dart';
import 'package:portfolio_site/components/article/components.dart';

class ArticlesSection extends StatelessComponent {
  const ArticlesSection({super.key, required this.articles});

  final List<Article> articles;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    // Get first 2 articles (featured first, then by date)
    final featuredArticles = articles.take(2).toList();

    // Get next 2 articles (skipping the first 2)
    final otherArticles = articles.skip(2).take(2).toList();

    yield section(
      id: 'articles',
      classes: 'py-20',
      [
        div(
          classes: 'container mx-auto px-4 sm:px-6 lg:px-8',
          [
            // Section Header
            _buildSectionHeader(),

            // Featured Articles (Large cards with images)
            if (featuredArticles.isNotEmpty) ...[
              FeaturedArticlesGrid(
                articles: featuredArticles,
              )
            ],

            // Other Recent Articles (Compact cards)
            if (otherArticles.isNotEmpty) ...[
              CompactArticlesGrid(
                articles: otherArticles,
                startDelay: 2, // Animation delay after featured articles
              )
            ],

            // View All Articles CTA
            div(classes: "text-center", [
              Link(
                to: '/articles',
                child: TButton.outline(
                  text: 'View All Articles',
                  subtleBorder: false,
                  customClasses: "text-center",
                ),
              ),
            ]),
          ],
        ),
      ],
    );
  }

  Component _buildSectionHeader() {
    return div(
      classes: 'text-center mb-16',
      [
        h2(
          classes: 'text-3xl md:text-4xl font-bold font-display mb-4',
          [
            text('Latest '),
            span(
              classes: 'gradient-text',
              [text('Articles')],
            ),
          ],
        ),
        p(
          classes: 'text-xl text-muted-foreground max-w-2xl mx-auto',
          [
            text('Sharing knowledge and insights about mobile development'),
          ],
        ),
      ],
    );
  }
}

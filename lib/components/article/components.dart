import 'package:jaspr/jaspr.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart' as lucide;
import 'package:portfolio_site/components/ui/badge.dart';
import 'package:portfolio_site/components/ui/card.dart';
import 'package:portfolio_site/components/ui/icon.dart';
import 'package:portfolio_site/models/article_model.dart';

// Featured Article Card Component
class FeaturedArticleCard extends StatelessComponent {
  final Article article;
  final int index;

  const FeaturedArticleCard({
    required this.article,
    required this.index,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Card(
      additionalClasses:
          'group overflow-hidden hover-scale border-border/50 hover:border-primary/30 transition-all duration-300 hover:shadow-card glass cursor-pointer animate-bounce-in',
      styles: {'animation-delay': '${index * 0.2}s'},
      children: [
        // Article Image with Category Badge
        _buildArticleImage(),

        // Card Content
        CardHeader(
          children: [
            // Date and Read Time
            _buildArticleMeta(),

            // Title
            CardTitle(
              additionalClasses:
                  'text-xl group-hover:text-primary transition-colors duration-300 line-clamp-2 leading-relaxed mb-3',
              children: [text(article.title)],
            ),

            // Excerpt
            CardDescription(
              additionalClasses: 'line-clamp-3 leading-relaxed',
              children: [text(article.excerpt)],
            ),
          ],
        ),

        CardContent(
          children: [
            // Read More Link
            _buildReadMoreLink(article.articleUrl),
          ],
        ),
      ],
    );
  }

  Component _buildArticleImage() {
    return div(
      classes: 'relative overflow-hidden',
      [
        // Article image
        img(
          classes:
              'w-full h-48 object-cover group-hover:scale-110 transition-transform duration-500',
          src: article.imageUrl ??
              'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=400&h=200&fit=crop',
          alt: article.title,
          attributes: {
            'loading': 'lazy',
            'decoding': 'async',
          },
        ),

        // Category badge
        div(
          classes: 'absolute top-4 left-4',
          [
            Badge(
              additionalClasses: 'bg-primary/90 text-primary-foreground',
              children: [text(article.category)],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildArticleMeta() {
    return div(
      classes: 'flex items-center gap-4 text-sm text-muted-foreground mb-3',
      [
        // Published date
        div(
          classes: 'flex items-center gap-2',
          [
            TIcon(
              lucideIcon: lucide.calendar,
              theme: IconTheme.monochrome,
              width: const Unit.pixels(16),
              height: const Unit.pixels(16),
            ),
            text(article.formattedDate),
          ],
        ),

        // Read time
        div(
          classes: 'flex items-center gap-2',
          [
            TIcon(
              lucideIcon: lucide.clock,
              theme: IconTheme.monochrome,
              width: const Unit.pixels(16),
              height: const Unit.pixels(16),
            ),
            text(article.readTime),
          ],
        ),
      ],
    );
  }
}

// Secondary Article Card Component
class SecondaryArticleCard extends StatelessComponent {
  final Article article;
  final int index;

  const SecondaryArticleCard({
    required this.article,
    required this.index,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Card(
      additionalClasses:
          'group hover-scale border-border/50 hover:border-primary/30 transition-all duration-300 glass cursor-pointer animate-fade-in-up',
      styles: {'animation-delay': '${index * 0.1}s'},
      children: [
        CardHeader(
          children: [
            // Category and Meta Info
            div(
              classes: 'flex items-center justify-between mb-3',
              [
                Badge(
                  variant: BadgeVariant.outline,
                  additionalClasses: 'text-xs',
                  children: [text(article.category)],
                ),

                // Compact meta info
                div(
                  classes: 'flex items-center gap-4 text-sm text-muted-foreground',
                  [
                    div(
                      classes: 'flex items-center gap-1',
                      [
                        TIcon(
                          lucideIcon: lucide.calendar,
                          theme: IconTheme.monochrome,
                          width: const Unit.pixels(14),
                          height: const Unit.pixels(14),
                        ),
                        text(article.formattedDate),
                      ],
                    ),
                    div(
                      classes: 'flex items-center gap-1',
                      [
                        TIcon(
                          lucideIcon: lucide.clock,
                          theme: IconTheme.monochrome,
                          width: const Unit.pixels(14),
                          height: const Unit.pixels(14),
                        ),
                        text(article.readTime),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            // Title
            CardTitle(
              additionalClasses:
                  'text-lg group-hover:text-primary transition-colors duration-300 line-clamp-2 leading-relaxed mb-3',
              children: [text(article.title)],
            ),

            // Excerpt
            CardDescription(
              additionalClasses: 'line-clamp-2 leading-relaxed',
              children: [text(article.excerpt)],
            ),
          ],
        ),
        CardContent(
          children: [
            // Read More Link
            _buildReadMoreLink(article.articleUrl),
          ],
        ),
      ],
    );
  }
}

Component _buildReadMoreLink(String articleUrl) {
  return a(
    href: articleUrl,
    target: Target.blank,
    [
      div(
        classes:
            'flex items-center gap-2 text-primary font-medium group-hover:translate-x-2 transition-all duration-300',
        [
          text('Read More'),
          TIcon(
            lucideIcon: lucide.arrowRight,
            theme: IconTheme.monochrome,
            width: const Unit.pixels(16),
            height: const Unit.pixels(16),
            customStyles: {
              'color': 'currentColor', // Match the text color (primary)
            },
            customClasses: 'transition-transform duration-300 group-hover:translate-x-1',
          )
        ],
      ),
    ],
  );
}

// Article Grid Components for layout
class FeaturedArticlesGrid extends StatelessComponent {
  final List<Article> articles;

  const FeaturedArticlesGrid({
    required this.articles,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes: 'grid lg:grid-cols-2 gap-8 mb-16',
      [
        for (int index = 0; index < articles.length; index++)
          FeaturedArticleCard(
            article: articles[index],
            index: index,
          ),
      ],
    );
  }
}

class CompactArticlesGrid extends StatelessComponent {
  final List<Article> articles;
  final int startDelay;

  const CompactArticlesGrid({
    required this.articles,
    this.startDelay = 2,
    Key? key,
  }) : super(key: key);

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes: 'grid md:grid-cols-2 gap-6 mb-12',
      [
        for (int index = 0; index < articles.length; index++)
          SecondaryArticleCard(
            article: articles[index],
            index: index + startDelay,
          ),
      ],
    );
  }
}

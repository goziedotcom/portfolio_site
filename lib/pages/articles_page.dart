// ============================================================================
// ARTICLES PAGE
// ============================================================================

import 'package:jaspr/jaspr.dart';
import 'package:portfolio_site/components/article/components.dart';
import 'package:portfolio_site/models/article_model.dart';

class ArticlesPage extends StatelessComponent {
  const ArticlesPage({super.key, required this.articles});
  final List<Article> articles;

  @override
  Iterable<Component> build(BuildContext context) sync* {

    yield div(
      classes: 'pt-24 pb-16',
      [
        div(
          classes: 'container mx-auto px-4 sm:px-6 lg:px-8',
          [
            div(
              classes: 'max-w-7xl mx-auto',
              [
                // Header
                _buildHeader(),

                // Articles Grid
                FeaturedArticlesGrid(
                  articles: articles,
                ),

                // Newsletter CTA
                // _buildNewsletterCTA(),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildHeader() {
    return div(
      classes: 'text-center mb-16',
      [
        h1(
          classes: 'text-4xl md:text-5xl font-bold font-display mb-4',
          [
            text('Articles & '),
            span(
              classes: 'gradient-text',
              [text('Insights')],
            ),
          ],
        ),
        p(
          classes: 'text-xl text-muted-foreground max-w-2xl mx-auto',
          [
            text(
                'Sharing knowledge and insights about mobile development, web technologies, and modern software engineering practices.'),
          ],
        ),
      ],
    );
  }

  // Component _buildNewsletterCTA() {
  //   return Card(
  //     hoverEffect: CardHoverEffect.slideBar,
  //     additionalClasses: 'text-center',
  //     children: [
  //       CardContent(
  //         additionalClasses: 'p-8 mt-6',
  //         children: [
  //           h3(
  //             classes: 'text-2xl font-bold font-display mb-4',
  //             [
  //               text('Stay '),
  //               span(
  //                 classes: 'gradient-text',
  //                 [text('Updated')],
  //               ),
  //             ],
  //           ),
  //           p(
  //             classes: 'text-muted-foreground mb-6 max-w-2xl mx-auto',
  //             [
  //               text(
  //                   'Get notified when I publish new articles about mobile development, Flutter, and web technologies.'),
  //             ],
  //           ),
  //           TButton(
  //             text: 'Subscribe to Newsletter',
  //             customClasses: 'px-8 py-4',
  //             onClick: () {
  //               print('Subscribe button clicked');
  //             },
  //           )
  //         ],
  //       ),
  //     ],
  //   );
  // }
}

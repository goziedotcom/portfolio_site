// ============================================================================
// ARTICLES PAGE
// ============================================================================

import 'package:jaspr/server.dart';
// import 'package:portfolio_site/components/ui/button.dart';
// import 'package:portfolio_site/components/ui/card.dart';
import 'package:portfolio_site/components/article/components.dart';
import 'package:portfolio_site/services/remote/remote_service.dart';

class ArticlesPage extends AsyncStatelessComponent {
  const ArticlesPage({super.key});

  @override
  Stream<Component> build(BuildContext context) async* {
    final allArticles = await RemoteService().getArticles();

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
                  articles: allArticles,
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

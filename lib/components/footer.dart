import 'package:jaspr/jaspr.dart';

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final currentYear = DateTime.now().year;

    yield footer(
      classes: 'bg-white dark:bg-gray-900 border-t border-gray-200 dark:border-gray-700 theme-transition',
      [
        div(
          classes: 'max-w-6xl mx-auto px-8 py-8',
          [
            div(
              classes: 'flex flex-col md:flex-row justify-between items-center space-y-4 md:space-y-0',
              [
                // Copyright
                p(
                  classes: 'text-gray-600 dark:text-gray-400 text-sm theme-transition',
                  [
                    text('© $currentYear '),
                    span(
                      classes: 'font-medium',
                      [text("Gozie Ihejirika")],
                    ),
                    text('. All rights reserved.'),
                  ],
                ),

                // Built with love
                div(
                  classes: 'flex items-center text-sm text-gray-600 dark:text-gray-400 theme-transition',
                  [
                    text('Built with '),
                    span(
                      classes: 'text-red-500 animate-pulse mx-1',
                      [text('❤️')],
                    ),
                    text(' using '),
                    a(
                      classes: 'text-purple-500 hover:text-purple-400 font-medium transition-colors duration-300 mx-1',
                      href: 'https://github.com/schultek/jaspr',
                      target: Target.blank,
                      [text('Jaspr')],
                    ),
                    text(' and '),
                    a(
                      classes: 'text-purple-500 hover:text-purple-400 font-medium transition-colors duration-300 ml-1',
                      href: 'https://tailwindcss.com',
                      target: Target.blank,
                      [text('Tailwind CSS')],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
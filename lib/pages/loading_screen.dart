import 'package:jaspr/jaspr.dart';

class LoadingScreen extends StatelessComponent {
  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes: 'min-h-screen bg-gray-900 flex items-center justify-center',
      styles: Styles(
        raw: {
          'color-scheme': 'dark',
          'background': 'linear-gradient(135deg, #1e1b4b 0%, #7c3aed 100%)',
        },
      ),
      [
        div(
          classes: 'text-center space-y-6',
          [
            // Your logo or brand
            div(
              classes: 'text-4xl font-bold text-white mb-4',
              [text('Gozie Ihejirika')],
            ),

            // Loading animation
            div(
              classes: 'flex justify-center',
              [
                div(
                  classes:
                      'animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-purple-300',
                  [],
                ),
              ],
            ),

            // Loading text
            div(
              classes: 'text-purple-200 text-lg',
              [text('Loading your experience...')],
            ),
          ],
        ),
      ],
    );
  }
}

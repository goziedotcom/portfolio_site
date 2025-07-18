import 'package:jaspr/jaspr.dart';

// By using the @client annotation this component will be automatically compiled to javascript and mounted
// on the client. Therefore:
// - this file and any imported file must be compilable for both server and client environments.
// - this component and any child components will be built once on the server during pre-rendering and then
//   again on the client during normal rendering.

@client
class Home extends StatelessComponent {
  const Home({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield section(
      classes: 'hero-container', // Uses your CSS class
      [
        div(
          classes: 'hero-content', // Uses your CSS class
          [
            h1(
              classes: 'hero-title', // Uses your CSS class
              [text('Gozie Ihejirika')],
            ),
            h2(
              classes: 'hero-subtitle', // Uses your CSS class
              [text('Mobile Developer')],
            ),
            p(
              classes: 'hero-description', // Uses your CSS class
              [
                text(
                    'Passionate mobile developer crafting beautiful, performant mobile applications with Flutter.')
              ],
            ),
            a(
              href: '/projects',
              classes: 'cta-button', // Uses your CSS class
              [text('View My Work')],
            ),
          ],
        ),
        div(
          classes: 'hero-image', // Uses your CSS class
          [
            img(
              classes: 'hero-avatar', // Uses your CSS class
              src: '/images/avatar.svg',
              alt: 'Gozie Ihejirika Avatar',
              // classes: 'w-full h-full object-cover', // Fill the container completely
            ),
          ],
        ),
      ],
    );
  }
}

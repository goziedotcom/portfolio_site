import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:portfolio_site/components/footer.dart';
import 'package:portfolio_site/pages/articles.dart';
import 'package:portfolio_site/pages/projects.dart';
import 'package:portfolio_site/providers/theme_providers.dart';

import 'components/header.dart';
import 'pages/contact.dart';
import 'pages/home.dart';

// The main component of your application.
//
// By using multi-page routing, this component will only be built on the server during pre-rendering and
// **not** executed on the client. Instead only the nested [Home] and [About] components will be mounted on the client.
class App extends StatefulComponent {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    context.read(themeProvider);
    super.initState();
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes: 'min-h-screen flex flex-col bg-bg-primary theme-transition',
      [
        const Header(),
        div(
          classes: 'flex-1',
          [Router(routes: routes)],
        ),
        const Footer(),
      ],
    );
  }
}

// Define routes for the application
final routes = [
  Route(
    path: '/',
    title: 'Home',
    builder: (context, state) => const Home(),
  ),
  Route(
    path: '/projects',
    title: 'Projects',
    builder: (_, state) => const ProjectsView(),
  ),
  Route(
    path: '/articles',
    title: 'Articles',
    builder: (_, state) => const ArticlesPage(),
  ),
  Route(
    path: '/contact',
    title: 'Contact',
    builder: (_, state) => const ContactPage(),
  ),
];

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:portfolio_site/components/footer.dart';
import 'package:portfolio_site/components/lazy_loader.dart';
import 'package:portfolio_site/components/scroll_to_top_button.dart';
import 'package:portfolio_site/pages/about_page.dart';
import 'package:portfolio_site/pages/articles_page.dart';
import 'package:portfolio_site/pages/projects_page.dart';

import 'components/header.dart';
import 'pages/contact_page.dart';
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
    super.initState();
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Header();
    yield div(
      classes: 'min-h-screen flex flex-col bg-bg-primary theme-transition',
      [
        const Header(),
        Router(routes: routes),
        const Footer(),
        ScrollToTopButton(),
      ],
    );
  }
}

// Define routes for the application
final routes = [
  Route(
    path: '/',
    builder: (context, state) => LazyComponent(
      loader: () async {
        await Future.delayed(Duration(milliseconds: 100));
        return const Home();
      },
    ),
  ),
  Route(
    path: '/about',
    builder: (context, state) => LazyComponent(
      loader: () async {
        await Future.delayed(Duration(milliseconds: 100));
        return const AboutPage();
      },
    ),
  ),
  Route(
    path: '/projects',
    builder: (context, state) => LazyComponent(
      loader: () async {
        await Future.delayed(Duration(milliseconds: 100));
        return const ProjectsPage();
      },
    ),
  ),
  Route(
    path: '/articles',
    builder: (context, state) => LazyComponent(
      loader: () async {
        await Future.delayed(Duration(milliseconds: 100));
        return const ArticlesPage();
      },
    ),
  ),
  Route(
    path: '/contact',
    builder: (context, state) => LazyComponent(
      loader: () async {
        await Future.delayed(Duration(milliseconds: 100));
        return const ContactPage();
      },
    ),
  ),
];

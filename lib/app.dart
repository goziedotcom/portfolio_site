import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:portfolio_site/components/footer.dart';
import 'package:portfolio_site/components/lazy_loader.dart';
import 'package:portfolio_site/components/scroll_to_top_button.dart';
import 'package:portfolio_site/pages/about_page.dart';
import 'package:portfolio_site/pages/articles_page.dart';
import 'package:portfolio_site/pages/projects_page.dart';
import 'package:portfolio_site/services/remote/remote_service.dart';

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
        final projects = await RemoteService().getProjects();
        final articles = await RemoteService().getArticles();
        return Home(projects: projects, articles: articles);
      },
    ),
  ),
  Route(
    path: '/about',
    builder: (context, state) => LazyComponent(
      loader: () async {
        final achievements = await RemoteService().getAchievements();
        return AboutPage(achievements: achievements);
      },
    ),
  ),
  Route(
    path: '/projects',
    builder: (context, state) => LazyComponent(
      loader: () async {
        final projects = await RemoteService().getProjects();
        return ProjectsPage(projects: projects);
      },
    ),
  ),
  Route(
    path: '/articles',
    builder: (context, state) => LazyComponent(
      loader: () async {
        final articles = await RemoteService().getArticles();
        return ArticlesPage(articles: articles);
      },
    ),
  ),
  Route(
    path: '/contact',
    builder: (context, state) => LazyComponent(
      loader: () async {
        await Future.delayed(Duration(milliseconds: 500));
        return ContactPage();
      },
    ),
  ),
];

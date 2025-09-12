import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:portfolio_site/components/footer.dart';
import 'package:portfolio_site/components/lazy_loader.dart';
import 'package:portfolio_site/components/scroll_to_top_button.dart';
import 'package:portfolio_site/services/remote/remote_service.dart';

import 'components/header.dart';
import 'pages/home.dart'; // Home loaded immediately

// Deferred imports for lazy loading
import 'pages/about_page.dart' deferred as about;
import 'pages/articles_page.dart' deferred as articles;
import 'pages/projects_page.dart' deferred as projects;
import 'pages/contact_page.dart' deferred as contact;

// The main component of my site.
//
// By using client-side routing with lazy loading, components will be loaded on-demand
// improving initial page load performance.
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

// Define routes for the application with lazy loading
final routes = [
  // Home route - always loaded (no deferred import)
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
  
  // About route - lazy loaded
  Route.lazy(
    path: '/about',
    load: about.loadLibrary,
    builder: (context, state) => LazyComponent(
      loader: () async {
        final achievements = await RemoteService().getAchievements();
        return about.AboutPage(achievements: achievements);
      },
    ),
  ),
  
  // Projects route - lazy loaded
  Route.lazy(
    path: '/projects',
    load: projects.loadLibrary,
    builder: (context, state) => LazyComponent(
      loader: () async {
        final projectsList = await RemoteService().getProjects();
        return projects.ProjectsPage(projects: projectsList);
      },
    ),
  ),
  
  // Articles route - lazy loaded
  Route.lazy(
    path: '/articles',
    load: articles.loadLibrary,
    builder: (context, state) => LazyComponent(
      loader: () async {
        final articlesList = await RemoteService().getArticles();
        return articles.ArticlesPage(articles: articlesList);
      },
    ),
  ),
  
  // Contact route - lazy loaded
  Route.lazy(
    path: '/contact',
    load: contact.loadLibrary,
    builder: (context, state) => LazyComponent(
      loader: () async {
        await Future.delayed(Duration(milliseconds: 500));
        return contact.ContactPage();
      },
    ),
  ),
];

// Optional: Preload function for better UX
class NavigationHelper {
  static void preloadRoute(BuildContext context, String path) {
    Router.of(context).preload(path);
  }
}
import 'package:jaspr/server.dart';
import 'package:portfolio_site/components/home/article_section.dart';
import 'package:portfolio_site/components/home/contact_section.dart';
import 'package:portfolio_site/components/home/hero_section.dart';
import 'package:portfolio_site/components/home/projects_section.dart';
import 'package:portfolio_site/components/home/services_section.dart';
import 'package:portfolio_site/components/home/technologies_section.dart';
import 'package:portfolio_site/services/remote/remote_service.dart';

// By using the @client annotation this component will be automatically compiled to javascript and mounted
// on the client. Therefore:
// - this file and any imported file must be compilable for both server and client environments.
// - this component and any child components will be built once on the server during pre-rendering and then
//   again on the client during normal rendering.

class Home extends AsyncStatelessComponent {
  const Home({super.key});

  @override
  Stream<Component> build(BuildContext context) async* {
    final projects = await RemoteService().getProjects();
    final articles = await RemoteService().getArticles();
    
    yield HeroSection();
    yield ServicesSection();
    yield TechnologiesSection();
    yield ProjectsSection(projects: projects);
    yield ArticlesSection(articles: articles);
    yield ContactSection();
  }
}

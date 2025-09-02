import 'package:jaspr/jaspr.dart';
import 'package:portfolio_site/components/home/article_section.dart';
import 'package:portfolio_site/components/home/contact_section.dart';
import 'package:portfolio_site/components/home/hero_section.dart';
import 'package:portfolio_site/components/home/projects_section.dart';
import 'package:portfolio_site/components/home/services_section.dart';
import 'package:portfolio_site/components/home/technologies_section.dart';
import 'package:portfolio_site/models/article_model.dart';
import 'package:portfolio_site/models/project_model.dart';

// By using the @client annotation this component will be automatically compiled to javascript and mounted
// on the client. Therefore:
// - this file and any imported file must be compilable for both server and client environments.
// - this component and any child components will be built once on the server during pre-rendering and then
//   again on the client during normal rendering.

class Home extends StatelessComponent {
  const Home({super.key, required this.projects, required this.articles});
  final List<Project> projects;
  final List<Article> articles;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    
    
    yield HeroSection();
    yield ServicesSection();
    yield TechnologiesSection();
    yield ProjectsSection(projects: projects);
    yield ArticlesSection(articles: articles);
    yield ContactSection();
  }
}

// ============================================================================
// PROJECTS PAGE
// ============================================================================

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:portfolio_site/components/projects/featured_project.dart';
import 'package:portfolio_site/components/projects/projects_view.dart';
import 'package:portfolio_site/components/ui/button.dart';
import 'package:portfolio_site/components/ui/card.dart';
import 'package:portfolio_site/models/project_model.dart';

class ProjectsPage extends StatelessComponent {
  const ProjectsPage({super.key, required this.projects});
  final List<Project> projects;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    if (projects.isEmpty) {
      yield div(
        classes: 'min-h-screen flex items-center justify-center',
        [
          div(
            classes: 'text-center py-16',
            [text('No projects found')],
          ),
        ],
      );
      return;
    }

    yield div(
      classes: 'min-h-screen',
      [
        div(
          classes: 'container mx-auto px-4 sm:px-6 lg:px-8 max-w-7xl',
          [
            // Header Section
            div(
              classes: 'pt-24 pb-8',
              [_buildHeader()],
            ),

            // Featured Projects Section
            div(
              classes: 'pb-12',
              [_buildFeaturedProjects(projects.take(2).toList())],
            ),
          ],
        ),

        // Interactive Projects View
        ProjectsView(projects: projects),

        // CTA Section
        div(
          classes: 'container mx-auto px-4 sm:px-6 lg:px-8 max-w-7xl',
          [
            div(
              classes: 'pt-8 pb-16',
              [_buildCTASection(context)],
            ),
          ],
        ),
      ],
    );
  }
}

Component _buildHeader() {
  return div(
    classes: 'text-center mb-16',
    [
      h1(
        classes: 'text-4xl md:text-5xl font-bold font-display mb-4',
        [
          text('My '),
          span(
            classes: 'gradient-text',
            [text('Projects')],
          ),
        ],
      ),
      p(
        classes: 'text-xl text-muted-foreground max-w-2xl mx-auto',
        [
          text(
              'A showcase of my recent work spanning mobile apps, web applications, and open source contributions.'),
        ],
      ),
    ],
  );
}

Component _buildFeaturedProjects(List<Project> featuredProjects) {
  return div(
    classes: 'mb-16',
    [
      h2(
        classes: 'text-3xl font-bold font-display mb-8',
        [
          span(
            classes: 'gradient-text',
            [text('Featured')],
          ),
          text(' Projects'),
        ],
      ),
      div(
        classes: 'grid lg:grid-cols-2 gap-8',
        [
          for (int index = 0; index < featuredProjects.length; index++)
            FeaturedProjectCard(
              project: featuredProjects[index],
              index: index,
            ),
        ],
      ),
    ],
  );
}

Component _buildCTASection(BuildContext context) {
  return div(
    classes: 'text-center mt-8',
    [
      Card(
        hoverEffect: CardHoverEffect.slideBar,
        children: [
          CardContent(
            additionalClasses: 'p-8 mt-6',
            children: [
              h3(
                classes: 'text-2xl font-bold font-display mb-4',
                [
                  text('Have a Project in '),
                  span(
                    classes: 'gradient-text',
                    [text('Mind?')],
                  ),
                ],
              ),
              p(
                classes: 'text-muted-foreground mb-6 max-w-2xl mx-auto',
                [
                  text("I'm always excited to work on new and challenging projects. "),
                  text("Let's discuss how we can bring your ideas to life."),
                ],
              ),
              TButton(
                text: 'Get In Touch',
                customClasses: 'px-8 py-4',
                onClick: () => context.push('/contact'),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

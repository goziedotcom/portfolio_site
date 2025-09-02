import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:portfolio_site/components/projects/alt_featured_project.dart';
import 'package:portfolio_site/components/ui/button.dart';
import 'package:portfolio_site/models/project_model.dart';

class ProjectsSection extends StatelessComponent {
  const ProjectsSection({super.key, required this.projects});

  final List<Project> projects;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final featuredProjects = projects.take(4).toList();

    yield section(
      id: 'projects',
      classes: 'py-20 bg-gradient-to-b from-secondary/20 to-background',
      [
        div(
          classes: 'container mx-auto px-4 sm:px-6 lg:px-8',
          [
            // Section Header
            _buildSectionHeader(),

            // Featured Projects (Large cards with images)
            if (featuredProjects.isNotEmpty) ...[
              _buildFeaturedProjects(featuredProjects),
            ],

            // View All Projects CTA
            div(classes: 'text-center', [
              Link(
                to: '/projects',
                child: TButton.outline(
                  text: 'View All Projects',
                  subtleBorder: false,
                ),
              )
            ]),
          ],
        ),
      ],
    );
  }

  Component _buildSectionHeader() {
    return div(
      classes: 'text-center mb-16',
      [
        h2(
          classes: 'text-3xl md:text-4xl font-bold font-display mb-4',
          [
            text('Featured '),
            span(
              classes: 'gradient-text',
              [text('Projects')],
            ),
          ],
        ),
        p(
          classes: 'text-xl text-muted-foreground max-w-2xl mx-auto',
          [
            text('Showcasing some of my best mobile development work'),
          ],
        ),
      ],
    );
  }

  Component _buildFeaturedProjects(List<Project> featuredProjects) {
    return div(
      classes: 'grid lg:grid-cols-2 gap-8 mb-16',
      [
        for (int index = 0; index < featuredProjects.length; index++)
          AltFeaturedProjectCard(
            project: featuredProjects[index],
            index: index,
          ),
      ],
    );
  }
}



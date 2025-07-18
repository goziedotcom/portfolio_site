

// ============================================================================
// PROJECTS PAGE
// ============================================================================

import 'package:jaspr/jaspr.dart';
import 'package:portfolio_site/models/projects.dart';

class ProjectsView extends StatelessComponent {
  const ProjectsView({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final featuredProjects = SampleProjects.projects.where((p) => p.isFeatured).toList();
    final otherProjects = SampleProjects.projects.where((p) => !p.isFeatured).toList();

    yield div(
      classes: 'min-h-screen bg-bg-primary theme-transition',
      [
        // Hero Section
        section(
          classes: 'section-container',
          [
            div(
              classes: 'text-center mb-16',
              [
                h1(
                  classes: 'section-title',
                  [text('My Projects')],
                ),
                p(
                  classes: 'text-xl text-gray-600 dark:text-gray-400 max-w-3xl mx-auto',
                  [text('A collection of projects showcasing my expertise in Dart, Jaspr, and modern web development. From simple utilities to complex applications.')],
                ),
              ],
            ),
          ],
        ),

        // Featured Projects
        if (featuredProjects.isNotEmpty) ...[
          section(
            classes: 'py-12 bg-gray-50 dark:bg-gray-900/50',
            [
              div(
                classes: 'max-w-6xl mx-auto px-8',
                [
                  h2(
                    classes: 'text-3xl font-bold mb-8 text-center gradient-text',
                    [text('Featured Projects')],
                  ),
                  div(
                    classes: 'projects-grid',
                    [
                      for (final project in featuredProjects)
                        _buildProjectCard(project, isFeatured: true),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],

        // All Projects
        section(
          classes: 'section-container',
          [
            div(
              classes: 'px-8',
              [
                h2(
                  classes: 'text-3xl font-bold mb-8 text-center text-gray-900 dark:text-white',
                  [text('All Projects')],
                ),
                div(
                  classes: 'projects-grid',
                  [
                    for (final project in SampleProjects.projects)
                      _buildProjectCard(project),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildProjectCard(Project project, {bool isFeatured = false}) {
    return div(
      classes: 'project-card ${isFeatured ? 'ring-2 ring-purple-500/20' : ''}',
      [
        // Project Image
        if (project.imageUrl != null)
          div(
            classes: 'w-full h-48 mb-6 rounded-lg overflow-hidden bg-gray-100 dark:bg-gray-800',
            [
              img(
                src: project.imageUrl!,
                alt: project.title,
                classes: 'w-full h-full object-cover hover:scale-105 transition-transform duration-300',
              ),
            ],
          ),

        // Status Badge
        div(
          classes: 'flex justify-between items-start mb-4',
          [
            _buildStatusBadge(project.status),
            if (isFeatured)
              span(
                classes: 'bg-gradient-to-r from-purple-500 to-purple-400 text-white text-xs px-2 py-1 rounded-full',
                [text('Featured')],
              ),
          ],
        ),

        // Project Title
        h3(
          classes: 'project-title',
          [text(project.title)],
        ),

        // Project Description
        p(
          classes: 'project-description',
          [text(project.description)],
        ),

        // Technologies
        div(
          classes: 'tech-tags',
          [
            for (final tech in project.technologies)
              span(
                classes: 'tech-tag',
                [text(tech)],
              ),
          ],
        ),

        // Action Links
        div(
          classes: 'flex gap-4',
          [
            if (project.liveUrl != null)
              a(
                href: project.liveUrl!,
                classes: 'project-link',
                target: Target.blank,
                [text('Live Demo →')],
              ),
            if (project.githubUrl != null)
              a(
                href: project.githubUrl!,
                classes: 'project-link',
                target: Target.blank,
                [text('View Code →')],
              ),
          ],
        ),
      ],
    );
  }

  Component _buildStatusBadge(ProjectStatus status) {
    String textString;
    String classes;

    switch (status) {
      case ProjectStatus.completed:
        textString = 'Completed';
        classes = 'bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-400';
        break;
      case ProjectStatus.inProgress:
        textString = 'In Progress';
        classes = 'bg-blue-100 text-blue-800 dark:bg-blue-900/30 dark:text-blue-400';
        break;
      case ProjectStatus.archived:
        textString = 'Archived';
        classes = 'bg-gray-100 text-gray-800 dark:bg-gray-800 dark:text-gray-400';
        break;
    }

    return span(
      classes: '$classes text-xs px-2 py-1 rounded-full font-medium',
      [text(textString)],
    );
  }
}
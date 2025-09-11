import 'package:jaspr/jaspr.dart';
import 'package:jaspr_lucide/generated_icons/external_link.dart' show externalLink;
import 'package:jaspr_lucide/generated_icons/github.dart' show github;
import 'package:portfolio_site/components/ui/badge.dart';
import 'package:portfolio_site/components/ui/card.dart';
import 'package:portfolio_site/components/ui/icon.dart';
import 'package:portfolio_site/models/project_model.dart';

class AltFeaturedProjectCard extends StatelessComponent {
  const AltFeaturedProjectCard({
    super.key,
    required this.project,
    required this.index,
  });

  final Project project;
  final int index;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Card(
      additionalClasses:
          'group overflow-hidden hover-scale border-border/50 hover:border-primary/30 transition-all duration-300 hover:shadow-card glass animate-bounce-in',
      styles: {'animation-delay': '${index * 0.2}s'},
      children: [
        // Project Image with Overlay
        _buildProjectImage(project),

        // Card Content
        CardHeader(
          children: [
            CardTitle(
              additionalClasses: 'text-xl group-hover:text-primary transition-colors duration-300 mb-3',
              children: [text(project.title)],
            ),
            CardDescription(
              children: [text(project.description)],
            ),
          ],
        ),

        CardContent(
          children: [
            // Technology badges
            div(
              classes: 'flex flex-wrap gap-2',
              [
                for (String tech in project.technologies)
                  Badge(
                    variant: BadgeVariant.secondary,
                    additionalClasses: 'text-xs',
                    children: [text(tech)],
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildProjectImage(Project project) {
    return div(
      classes: 'relative overflow-hidden',
      [
        // Main project image
        img(
          classes:
              'w-full h-48 object-cover group-hover:scale-110 transition-transform duration-500',
          src: project.imageUrl ??
              'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=500&h=300&fit=crop',
          alt: project.title,
          attributes: {
            'loading': 'lazy',
            'decoding': 'async',
          },
        ),

        // Hover overlay
        div(
          classes:
              'absolute inset-0 bg-gradient-to-t from-black/60 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300',
          [],
        ),

        // Action buttons that appear on hover
        div(
          classes:
              'absolute bottom-4 right-4 flex gap-2 opacity-0 group-hover:opacity-100 transition-opacity duration-300',
          [
            // GitHub button (only if public and available)
            if (project.githubUrl != null && project.isGithubPublic)
              _buildActionButton(
                icon: github,
                href: project.githubUrl!,
                label: 'View on GitHub',
              ),

            // Live demo button
            if (project.liveUrl != null)
              _buildActionButton(
                icon: externalLink,
                href: project.liveUrl!,
                label: 'View Live Demo',
              ),
          ],
        ),
      ],
    );
  }

  Component _buildActionButton({
    required LucideIcon icon,
    required String href,
    required String label,
  }) {
    return a(
      classes:
          'inline-flex items-center justify-center h-8 w-8 p-0 rounded-md bg-secondary hover:bg-secondary/80 transition-colors duration-200',
      href: href,
      target: Target.blank,
      attributes: {
        'rel': 'noopener noreferrer',
        'aria-label': label,
        'title': label,
      },
      [
        TIcon(
          lucideIcon: icon,
          theme: IconTheme.monochrome,
          width: const Unit.pixels(16),
          height: const Unit.pixels(16),
        ),
      ],
    );
  }
}

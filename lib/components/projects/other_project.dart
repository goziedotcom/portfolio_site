import 'package:jaspr/jaspr.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart' as lucide;
import 'package:portfolio_site/components/ui/badge.dart';
import 'package:portfolio_site/components/ui/button.dart';
import 'package:portfolio_site/components/ui/card.dart';
import 'package:portfolio_site/models/project_model.dart';

// Other Project Card Component (for non-featured projects)
class OtherProjectCard extends StatelessComponent {
  final Project project;
  final int index;

  const OtherProjectCard({required this.project, required this.index, Key? key}) : super(key: key);

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Card(
      hoverEffect: CardHoverEffect.subtle, // Subtle hover for secondary projects
      additionalClasses: 'group overflow-hidden animate-fade-in-up transition-all duration-300',
      styles: {'animation-delay': '${index * 0.05}s'},
      children: [
        // Project Image with subtle hover effects
        _buildProjectImage(),

        CardHeader(children: [_buildCardHeader()]),

        CardContent(
          children: [_buildProjectDescription(), _buildTechnologyBadges(), _buildActionButtons()],
        ),
      ],
    );
  }

  Component _buildProjectImage() {
    return div(classes: 'relative aspect-video bg-muted rounded-t-lg overflow-hidden', [
      img(
        classes:
            'w-full h-full object-cover group-hover:scale-105 transition-transform duration-500 ease-out',
        src:
            project.imageUrl ??
            'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=500&h=300&fit=crop',
        alt: project.title,
        attributes: {'loading': 'lazy', 'decoding': 'async'},
      ),

      // Subtle overlay on hover (less intense than featured)
      div(
        classes:
            'absolute inset-0 bg-gradient-to-t from-black/30 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-400',
        [],
      ),
    ]);
  }

  Component _buildCardHeader() {
    return div(classes: 'flex items-start justify-between', [
      CardTitle(
        additionalClasses: 'text-lg group-hover:text-primary transition-colors duration-300',
        children: [text(project.title)],
      ),
      Badge(
        variant: project.status == ProjectStatus.completed
            ? BadgeVariant.outline
            : BadgeVariant.secondary,
        additionalClasses: project.status == ProjectStatus.completed
            ? 'border-primary text-primary'
            : 'text-xs "text-muted-foreground',
        children: [text(project.status.displayName)],
      ),
    ]);
  }

  Component _buildProjectDescription() {
    return p(
      classes:
          'text-muted-foreground text-sm mb-4 line-clamp-3 leading-relaxed group-hover:text-foreground/70 transition-colors duration-300',
      [text(project.description)],
    );
  }

  Component _buildTechnologyBadges() {
    return div(classes: 'flex flex-wrap gap-1 mb-4', [
      for (int i = 0; i < (project.technologies.length > 3 ? 3 : project.technologies.length); i++)
        Badge(
          variant: BadgeVariant.secondary,
          additionalClasses:
              'text-xs hover:bg-primary/5 hover:text-primary/80 transition-colors duration-200 cursor-default',
          children: [text(project.technologies[i])],
        ),
      if (project.technologies.length > 3)
        Badge(
          variant: BadgeVariant.secondary,
          additionalClasses: 'text-xs opacity-75 hover:opacity-100 transition-opacity duration-200',
          children: [text('+${project.technologies.length - 3}')],
        ),
    ]);
  }

  Component _buildActionButtons() {
    return div(classes: 'flex space-x-2', [
      if (project.liveUrl != null)
        a(href: project.liveUrl!, target: Target.blank, [
          TButton.outline(
            text: 'Demo',
            icon: lucide.externalLink,
            size: ButtonSize.small,
            customClasses: 'px-3 py-1.5',
          ),
        ]),
      if (project.githubUrl != null && project.isGithubPublic)
        a(href: project.githubUrl!, target: Target.blank, [
          TButton.outline(
            text: 'Code',
            icon: lucide.github,
            size: ButtonSize.small,
            customClasses: 'px-3 py-1.5',
          ),
        ]),
    ]);
  }
}
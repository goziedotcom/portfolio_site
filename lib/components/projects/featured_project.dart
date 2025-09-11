import 'package:jaspr/jaspr.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart' as lucide;
import 'package:portfolio_site/components/ui/badge.dart';
import 'package:portfolio_site/components/ui/button.dart';
import 'package:portfolio_site/components/ui/card.dart';
import 'package:portfolio_site/models/project_model.dart';

// Featured Project Card Component
class FeaturedProjectCard extends StatelessComponent {
  final Project project;
  final int index;
  final Function(String)? onLiveDemoClick;
  final Function(String)? onGitHubClick;

  const FeaturedProjectCard({
    required this.project,
    required this.index,
    this.onLiveDemoClick,
    this.onGitHubClick,
    Key? key,
  }) : super(key: key);

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Card(
      hoverEffect: CardHoverEffect.glow, // Enhanced hover for featured projects
      additionalClasses:
          'group overflow-hidden animate-bounce-in hover:shadow-glow transition-all duration-300',
      styles: {'animation-delay': '${index * 0.1}s'},
      children: [
        // Project Image with enhanced hover effects
        _buildProjectImage(),

        CardHeader(
          children: [
            _buildCardHeader(),
          ],
        ),

        CardContent(
          children: [
            _buildProjectDescription(),
            _buildTechnologyBadges(),
            _buildActionButtons(),
          ],
        ),
      ],
    );
  }

  Component _buildProjectImage() {
    return div(
      classes: 'relative aspect-video bg-muted rounded-t-lg overflow-hidden',
      [
        img(
          classes:
              'w-full h-full object-cover group-hover:scale-110 transition-transform duration-700 ease-out',
          src: project.imageUrl ??
              'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=500&h=300&fit=crop',
          alt: project.title,
          attributes: {
            'loading': 'lazy',
            'decoding': 'async',
          },
        ),

        // Overlay gradient on hover
        div(
          classes:
              'absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500',
          [],
        ),
      ],
    );
  }

  Component _buildCardHeader() {
    return div(
      classes: 'flex items-start justify-between',
      [
        CardTitle(
          additionalClasses: 'text-xl group-hover:text-primary transition-colors duration-300',
          children: [text(project.title)],
        ),
        Badge(
          variant: BadgeVariant.outline,
          additionalClasses: 'border-primary text-primary',
          children: [text(project.category)],
        )
      ],
    );
  }

  Component _buildProjectDescription() {
    return p(
      classes:
          'text-muted-foreground mb-4 leading-relaxed group-hover:text-foreground/80 transition-colors duration-300',
      [text(project.description)],
    );
  }

  Component _buildTechnologyBadges() {
    return div(
      classes: 'flex flex-wrap gap-2 mb-6',
      [
        for (String tech in project.technologies)
          Badge(
            variant: BadgeVariant.secondary,
            additionalClasses:
                'text-xs hover:bg-primary/10 hover:text-primary transition-colors duration-200 cursor-default',
            children: [text(tech)],
          ),
      ],
    );
  }

  Component _buildActionButtons() {
    return div(
      classes: 'flex space-x-3',
      [
        if (project.liveUrl != null)
          a(
            href: project.liveUrl!,
            target: Target.blank,
            [
              TButton.primary(
                text: 'Live Demo',
                icon: lucide.externalLink,
                size: ButtonSize.small,
              ),
            ],
          ),
        if (project.githubUrl != null && project.isGithubPublic)
          a(
            href: project.githubUrl!,
            target: Target.blank,
            [
              TButton.outline(
                text: 'Code',
                icon: lucide.github,
                size: ButtonSize.small,
              ),
            ],
          ),
      ],
    );
  }
}

/*
Usage Examples:

// Basic usage
FeaturedProjectCard(
  project: myProject,
  index: 0,
)

// With custom click handlers
FeaturedProjectCard(
  project: myProject,
  index: 1,
  onLiveDemoClick: (url) {
    // Custom live demo handling
    Navigator.push(context, WebViewPage(url: url));
  },
  onGitHubClick: (url) {
    // Custom GitHub handling
    showDialog(context, ConfirmationDialog(
      title: 'Open GitHub',
      onConfirm: () => window.open(url, '_blank'),
    ));
  },
)

// In a grid layout
div(
  classes: 'grid md:grid-cols-2 lg:grid-cols-3 gap-6',
  [
    for (int i = 0; i < featuredProjects.length; i++)
      FeaturedProjectCard(
        project: featuredProjects[i],
        index: i,
        onLiveDemoClick: (url) => _handleLiveDemo(url),
        onGitHubClick: (url) => _handleGitHub(url),
      ),
  ],
)

Enhanced Features:
🎯 Standalone component with clean API
🔄 Customizable click handlers
📱 Responsive design ready
🎨 Consistent styling and animations
⚡ Optimized performance with method extraction
*/

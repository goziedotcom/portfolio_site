import 'package:jaspr/jaspr.dart';
import 'package:portfolio_site/components/ui/badge.dart';
import 'package:portfolio_site/config/site_config.dart';
import 'package:portfolio_site/models/technology_model.dart';

// Technologies Section Component
class TechnologiesSection extends StatelessComponent {
  const TechnologiesSection({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield section(
      classes: 'py-20',
      [
        div(
          classes: 'container mx-auto px-4 sm:px-6 lg:px-8',
          [
            // Section Header
            _buildSectionHeader(),

            // Technologies Grid
            _buildTechnologiesGrid(),

            // Experience Highlight
            _buildExperienceHighlight(),
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
            text('Technologies & '),
            span(
              classes: 'gradient-text',
              [text('Skills')],
            ),
          ],
        ),
        p(
          classes: 'text-xl text-muted-foreground max-w-2xl mx-auto',
          [
            text('Modern tools and technologies I use to build exceptional mobile experiences'),
          ],
        ),
      ],
    );
  }

  Component _buildTechnologiesGrid() {
    return div(
      classes: 'grid md:grid-cols-2 lg:grid-cols-3 gap-8',
      [
        for (int categoryIndex = 0; categoryIndex < SiteConfig.technologiesData.length; categoryIndex++)
          _buildTechnologyCategory(SiteConfig.technologiesData[categoryIndex], categoryIndex),
      ],
    );
  }

  Component _buildTechnologyCategory(TechnologyCategory category, int categoryIndex) {
    return div(
      classes: 'space-y-4 animate-bounce-in',
      styles: Styles(raw: {'animation-delay': '${categoryIndex * 0.1}s'}),
      [
        // Category title
        h3(
          classes: 'text-lg font-semibold font-display text-primary',
          [text(category.name)],
        ),

        // Technology badges container
        div(
          classes: 'flex flex-wrap gap-2',
          [
            for (int techIndex = 0; techIndex < category.technologies.length; techIndex++)
              _buildTechnologyBadge(
                category.technologies[techIndex],
                categoryIndex,
                techIndex,
              ),
          ],
        ),
      ],
    );
  }

  Component _buildTechnologyBadge(String technology, int categoryIndex, int techIndex) {
    final animationDelay = (categoryIndex * 0.1) + (techIndex * 0.05);

    return Badge(
      variant: BadgeVariant.secondary,
      additionalClasses:
          'hover-scale cursor-pointer bg-card hover:bg-primary/10 border border-border/50 hover:border-primary/30 transition-all duration-300 animate-fade-in-up',
      styles: {'animation-delay': '${animationDelay}s'},
      attributes: {
        'title': 'Technology: $technology',
        'aria-label': technology,
      },
      events: {
        'click': (event) {
          // Optional: Add click handler for technology badges
          print('Clicked on: $technology');
        },
      },
      children: [text(technology)],
    );
  }

  Component _buildExperienceHighlight() {
    return div(
      classes: 'mt-16 text-center',
      [
        div(
          classes:
              'inline-flex items-center justify-center p-8 rounded-2xl shadow-glow animate-pulse-glow hover-scale transition-all duration-500',
          styles: Styles(raw: {'background': 'var(--gradient-primary)'}),
          attributes: {
            'aria-label': 'Experience highlight',
          },
          [
            div(
              classes: 'text-center text-primary-foreground',
              [
                div(
                  classes: 'text-2xl font-bold mb-2',
                  [text('4+ Years')],
                ),
                div(
                  classes: 'text-primary-foreground/90',
                  [text('Mobile Development Experience')],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

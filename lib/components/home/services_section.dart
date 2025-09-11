import 'package:jaspr/jaspr.dart';
import 'package:portfolio_site/components/ui/card.dart';
import 'package:portfolio_site/components/ui/icon.dart';
import 'package:portfolio_site/config/site_config.dart';
import 'package:portfolio_site/models/services_model.dart';

class ServicesSection extends StatelessComponent {
  const ServicesSection({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield section(
      id: 'services',
      classes: 'py-20 bg-gradient-to-b from-background to-secondary/20',
      [
        div(
          classes: 'container mx-auto px-4 sm:px-6 lg:px-8',
          [
            // Section Header
            _buildSectionHeader(),

            // Services Grid
            _buildServicesGrid(),
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
            text('Services I '),
            span(
              classes: 'gradient-text',
              [text('Offer')],
            ),
          ],
        ),
        p(
          classes: 'text-xl text-muted-foreground max-w-2xl mx-auto',
          [
            text('Comprehensive software development services to bring your ideas and projects to life'),
          ],
        ),
      ],
    );
  }

  Component _buildServicesGrid() {
    return div(
      classes: 'grid md:grid-cols-2 lg:grid-cols-3 gap-8',
      [
        for (int index = 0; index < SiteConfig.services.length; index++)
          _buildServiceCard(SiteConfig.services[index], index),
      ],
    );
  }

  Component _buildServiceCard(ServiceModel service, int index) {
    return Card(
      additionalClasses:
          'group hover-scale border-border/50 hover:border-primary/30 transition-all duration-300 hover:shadow-card glass animate-fade-in-up',
      styles: {'animation-delay': '${index * 0.1}s'},
      children: [
        CardHeader(
          children: [
            // Icon container with network SVG
            _buildServiceIcon(service.icon),

            // Title
            CardTitle(
              additionalClasses:
                  'text-xl font-semibold group-hover:text-primary transition-colors duration-300',
              children: [text(service.title)],
            ),

            // Description
            CardDescription(
              children: [text(service.description)],
            ),
          ],
        ),
        CardContent(
          children: [
            // Features list
            ul(
              classes: 'space-y-2',
              [
                for (String feature in service.features) _buildFeatureItem(feature),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildServiceIcon(LucideIcon icon) {
    return div(
      classes:
          'w-12 h-12 rounded-lg bg-gradient-primary flex items-center justify-center mb-4 group-hover:scale-110 transition-transform duration-300',
      [
        TIcon(
          lucideIcon: icon,
          theme: IconTheme.monochrome,
          width: const Unit.pixels(24),
          height: const Unit.pixels(24),
          customClasses: 'text-white dark:text-black', // White in light mode, black in dark mode
        ),
      ],
    );
  }

  Component _buildFeatureItem(String feature) {
    return li(
      classes: 'flex items-center text-sm text-muted-foreground',
      [
        // Bullet point
        div(
          classes: 'w-1.5 h-1.5 rounded-full bg-primary mr-3 flex-shrink-0',
          [],
        ),
        // Feature text
        text(feature),
      ],
    );
  }
}

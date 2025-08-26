import 'package:jaspr/jaspr.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart' as lucide;
import 'package:portfolio_site/components/ui/card.dart';
import 'package:portfolio_site/components/ui/icon.dart';
import 'package:portfolio_site/models/services_model.dart';

class ServicesSection extends StatelessComponent {
  const ServicesSection({super.key});

  static const List<ServiceModel> services = [
    ServiceModel(
      icon: lucide.smartphone,
      title: 'Mobile App Development',
      description:
          'Native-quality Flutter apps for iOS and Android with beautiful UIs and smooth performance.',
      features: ['Cross-platform development', 'Native performance', 'Custom UI components'],
    ),
    ServiceModel(
      icon: lucide.searchCheck,
      title: 'Free App Audit',
      description:
          'Comprehensive analysis of your existing app\'s performance, security, and user experience with actionable recommendations.',
      features: [
        'Performance analysis',
        'Security assessment',
        'UX evaluation',
        'Improvement roadmap'
      ],
    ),
    ServiceModel(
      icon: lucide.messageCircle,
      title: 'Mobile App Consultation',
      description:
          'Expert guidance and strategic planning for your mobile app project from concept to launch.',
      features: [
        'Project feasibility analysis',
        'Technology recommendations',
        'Development roadmap',
        'Cost estimation'
      ],
    ),
    ServiceModel(
      icon: lucide.zap,
      title: 'Backend Integration',
      description:
          'Seamless API integration with Firebase, Serverpod, and custom backend solutions.',
      features: ['Real-time data sync', 'Cloud functions', 'Database optimization'],
    ),
    ServiceModel(
      icon: lucide.globe,
      title: 'Web Development',
      description:
          'Modern web applications using Flutter Web and Jaspr for consistent experiences across platforms.',
      features: ['Responsive design', 'PWA capabilities', 'SEO optimization'],
    ),
    ServiceModel(
      icon: lucide.shield,
      title: 'App Security',
      description:
          'Implementing robust security measures including authentication, encryption, and secure storage.',
      features: ['User authentication', 'Data encryption', 'Secure API calls'],
    ),
  ];

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
            text('Full-stack mobile development services to bring your ideas to life'),
          ],
        ),
      ],
    );
  }

  Component _buildServicesGrid() {
    return div(
      classes: 'grid md:grid-cols-2 lg:grid-cols-3 gap-8',
      [
        for (int index = 0; index < services.length; index++)
          _buildServiceCard(services[index], index),
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

import 'package:jaspr/jaspr.dart';
import 'package:portfolio_site/components/contact/contact_form.dart';
import 'package:portfolio_site/components/ui/card.dart';
import 'package:portfolio_site/components/ui/icon.dart';
import 'package:portfolio_site/config/site_config.dart';
import 'package:portfolio_site/models/contact_model.dart';

// ============================================================================
// CONTACT PAGE COMPONENT
// ============================================================================

class ContactPage extends StatelessComponent {
  const ContactPage({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes: 'pt-24 pb-16',
      [
        div(
          classes: 'container mx-auto px-4 sm:px-6 lg:px-8',
          [
            div(
              classes: 'max-w-4xl mx-auto',
              [
                // Header
                _buildHeader(),

                // Main content grid
                div(
                  classes: 'grid lg:grid-cols-2 gap-12',
                  [
                    // Contact Form
                    ContactFormCard(),

                    // Contact Info
                    _buildContactInfo(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildHeader() {
    return div(
      classes: 'text-center mb-12',
      [
        h1(
          classes: 'text-4xl md:text-5xl font-bold font-display mb-4',
          [
            text('Get In '),
            span(
              classes: 'gradient-text',
              [text('Touch')],
            ),
          ],
        ),
        p(
          classes: 'text-xl text-muted-foreground max-w-2xl mx-auto',
          [
            text(
                'Ready to bring your project to life? Whether you\'re a client with an exciting idea or a fellow developer looking to collaborate, I\'d love to hear from you.'),
          ],
        ),
      ],
    );
  }

  Component _buildContactInfo() {
    return div(
      classes: 'space-y-8',
      [
        // Contact info cards
        for (final info in SiteConfig.contactInfo)
          _buildContactInfoCard(info),

        // Why work with me card
        _buildBenefitsCard(),
      ],
    );
  }

  Component _buildContactInfoCard(ContactInfo info) {
    return Card(
      hoverEffect: CardHoverEffect.slideBar,
      children: [
        CardContent(
          additionalClasses: 'p-8 pt-4',
          children: [
            div(
              classes: 'flex items-center space-x-4',
              [
                div(
                  classes: 'p-3 rounded-lg bg-primary/10',
                  [
                    TIcon(lucideIcon: info.lucideIcon,theme: IconTheme.purple),
                  ],
                ),
                div(
                  [
                    h3(
                      classes: 'font-semibold text-foreground',
                      [text(info.title)],
                    ),
                    p(
                      classes: 'text-muted-foreground',
                      [text(info.description)],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildBenefitsCard() {
    return Card(
      hoverEffect: CardHoverEffect.slideBar,
      additionalClasses: 'animate-fade-in-up',
      styles: {'animation-delay': '0.3s'},
      children: [
        CardHeader(
          children: [
            CardTitle(
              additionalClasses: 'text-lg',
              children: [text('Why Work With Me?')],
            ),
          ],
        ),
        CardContent(
          additionalClasses: 'space-y-3',
          children: [
            for (String benefit in SiteConfig.benefits)
              div(
                classes: 'flex items-start space-x-3',
                [
                  div(
                    classes: 'w-2 h-2 rounded-full bg-primary mt-2 flex-shrink-0',
                    [],
                  ),
                  p(
                    classes: 'text-sm text-muted-foreground',
                    [text(benefit)],
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

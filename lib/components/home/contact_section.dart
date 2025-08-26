import 'package:jaspr/jaspr.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart' as lucide;
import 'package:jaspr_router/jaspr_router.dart';
import 'package:portfolio_site/components/ui/button.dart';
import 'package:portfolio_site/components/ui/card.dart';
import 'package:portfolio_site/components/ui/icon.dart';
import 'package:portfolio_site/config/site_config.dart';

// Contact Section Component for Home Page
class ContactSection extends StatelessComponent {
  const ContactSection({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield section(
      id: 'contact',
      classes: 'py-20 relative overflow-hidden',
      [
        // Background decoration with floating orbs
        _buildBackgroundDecorations(),

        div(
          classes: 'container mx-auto px-4 sm:px-6 lg:px-8 relative z-10',
          [
            // Section Header
            _buildSectionHeader(),

            // Main Content Grid
            div(
              classes: 'grid lg:grid-cols-2 gap-12 items-center',
              [
                // Contact Info & Why Choose Me
                _buildContactInfo(),

                // Enhanced CTA Card
                ContactCtaCard(),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildBackgroundDecorations() {
    return div(
      classes: 'absolute inset-0',
      [
        // Top-right floating orb
        div(
          classes: 'absolute top-20 right-20 w-64 h-64 bg-primary/10 rounded-full blur-3xl',
          [],
        ),
        // Bottom-left floating orb
        div(
          classes: 'absolute bottom-20 left-20 w-64 h-64 bg-accent/10 rounded-full blur-3xl',
          [],
        ),
      ],
    );
  }

  Component _buildSectionHeader() {
    return div(
      classes: 'text-center mb-14',
      [
        h2(
          classes: 'text-3xl md:text-4xl font-bold font-display mb-4',
          [
            text("Let's Work "),
            span(
              classes: 'gradient-text',
              [text('Together')],
            ),
          ],
        ),
        p(
          classes: 'text-xl text-muted-foreground max-w-3xl mx-auto',
          [
            text("Ready to transform your app idea into reality? Let's discuss your project!"),
          ],
        ),
      ],
    );
  }

  Component _buildContactInfo() {
    return div(
      classes: 'space-y-8 animate-bounce-in',
      [
        // Contact Methods
        div(
          classes: 'space-y-6',
          [
            ...SiteConfig.contactInfo.take(2).map((info) {
              return _buildContactItem(
                icon: info.lucideIcon,
                title: info.title,
                description: info.description,
              );
            }),
          ],
        ),

        // Why Choose Me Section
        div(
          classes: 'pt-8',
          [
            h3(
              classes: 'font-semibold text-lg mb-4 flex items-center gap-2',
              [
                text('Why Choose Me?'),
              ],
            ),
            ul(
              classes: 'space-y-3',
              [
                for (final benefit in SiteConfig.benefits) _buildBenefitItem(benefit),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildContactItem({
    required Component Function({
      Unit? width,
      Unit? height,
      String? viewBox,
      Map<String, String>? attributes,
      String? id,
      Key? key,
      String? classes,
      Styles? styles,
      Map<String, EventCallback>? events,
    }) icon,
    required String title,
    required String description,
  }) {
    return div(
      classes: 'flex items-center gap-4 group',
      [
        // Icon container
        div(
          classes:
              'w-12 h-12 rounded-xl bg-gradient-primary flex items-center justify-center group-hover:scale-110 transition-transform duration-300',
          [
            TIcon(
              lucideIcon: icon,
              theme: IconTheme.monochrome,
              width: const Unit.pixels(24),
              height: const Unit.pixels(24),
              customClasses: 'text-white dark:text-black',
            ),
          ],
        ),

        // Text content
        div(
          [
            h3(
              classes: 'font-semibold text-lg',
              [text(title)],
            ),
            p(
              classes: 'text-muted-foreground',
              [text(description)],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildBenefitItem(String benefit) {
    return li(
      classes: 'flex items-center gap-3',
      [
        // Purple bullet point
        div(
          classes: 'w-2 h-2 rounded-full bg-primary flex-shrink-0',
          [],
        ),
        // Benefit text
        span(
          classes: 'text-muted-foreground',
          [text(benefit)],
        ),
      ],
    );
  }
}

class ContactCtaCard extends StatelessComponent {
  const ContactCtaCard({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes: 'animate-bounce-in',
      styles: Styles(raw: {'animation-delay': '0.2s'}),
      [
        Card(
          additionalClasses: 'sticker relative overflow-hidden border-0 p-8 text-center rounded-xl',
          children: [
            CardContent(
              additionalClasses: 'space-y-6 p-0 relative z-10',
              children: [
                // Icon with sharp circular background
                div(
                  classes:
                      'w-20 h-20 rounded-full bg-white/20 flex items-center justify-center mx-auto',
                  [
                    TIcon(
                      lucideIcon: lucide.messageCircle,
                      theme: IconTheme.monochrome,
                      width: const Unit.pixels(40),
                      height: const Unit.pixels(40),
                      customClasses: 'text-white dark:text-black',
                    ),
                  ],
                ),

                // CTA Content
                div(
                  classes: 'space-y-4',
                  [
                    h3(
                      classes: 'text-2xl font-bold text-primary-foreground',
                      [text('Ready to Get Started?')],
                    ),
                    p(
                      classes: 'text-primary-foreground/90 max-w-sm mx-auto leading-relaxed',
                      [
                        text(
                            "Let's discuss your project and turn your ideas into amazing mobile experiences!"),
                      ],
                    ),
                  ],
                ),

                // Primary CTA Button
                Link(
                  to: '/contact',
                  child: TButton.ghost(
                    text: 'Get In Touch',
                    icon: lucide.send,
                    fullWidth: true,
                    customClasses: 'mt-4',
                  ),
                ),

                // Lead Magnet + Trust Indicators
                div(
                  classes: 'space-y-3',
                  [
                    // Free Consultation Lead Magnet
                    div(
                      classes:
                          'inline-flex items-center gap-2 px-4 py-2 rounded bg-white/20 text-primary-foreground/95 text-sm font-medium',
                      [
                        TIcon(
                          lucideIcon: lucide.gift,
                          theme: IconTheme.monochrome,
                          width: const Unit.pixels(14),
                          height: const Unit.pixels(14),
                          customClasses: 'text-current',
                        ),
                        text('Free Initial Consultation'),
                      ],
                    ),

                    // Response Time Indicator
                    div(
                      classes:
                          'flex items-center justify-center gap-2 text-primary-foreground/80 text-sm',
                      [
                        div(
                          classes: 'w-2 h-2 rounded-full bg-green-400 animate-pulse',
                          [],
                        ),
                        text('Usually responds within 24 hours'),
                      ],
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
}

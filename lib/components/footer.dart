import 'package:jaspr/jaspr.dart';
import 'package:portfolio_site/config/site_config.dart';

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {

    yield footer(
      classes:
          'border-t border-border/50 py-8 bg-card/50 backdrop-blur-sm transition-colors duration-300',
      [
        div(
          classes: 'container mx-auto px-4 sm:px-6 lg:px-8',
          [
            div(
              classes: 'flex flex-col md:flex-row items-center justify-between gap-4',
              [
                // Copyright section
                div(
                  classes: 'text-center md:text-left',
                  [
                    p(
                      classes: 'text-muted-foreground transition-colors duration-300',
                      [text(SiteConfig.footerText)],
                    ),
                  ],
                ),

                // Made with love section - enhanced
                div(
                  classes:
                      'flex items-center gap-2 text-muted-foreground transition-colors duration-300',
                  [
                    span([text('Made with')]),

                    // Heart icon with enhanced animation
                    span(
                      classes: 'text-red-500 animate-pulse relative',
                      attributes: {'aria-label': 'love', 'title': 'Made with love'},
                      [
                        // Using emoji heart with pulse glow effect
                        span(
                          classes: 'inline-block hover:scale-110 transition-transform duration-300',
                          [text('❤️')],
                        ),
                      ],
                    ),

                    span([text('using')]),

                    // Jaspr link with enhanced styling
                    a(
                      classes:
                          'font-medium text-primary hover:text-primary-glow transition-all duration-300 hover:scale-105 relative group',
                      href: 'https://jaspr.site/',
                      target: Target.blank,
                      attributes: {'rel': 'noopener noreferrer', 'title': 'Visit Jaspr framework'},
                      [
                        text('Jaspr'),
                        // Subtle underline effect
                        span(
                          classes:
                              'absolute -bottom-0.5 left-0 w-0 h-0.5 bg-gradient-primary group-hover:w-full transition-all duration-300',
                          [],
                        ),
                      ],
                    ),

                    span([text('&')]),

                    // Tailwind link with enhanced styling
                    a(
                      classes:
                          'font-medium text-primary hover:text-primary-glow transition-all duration-300 hover:scale-105 relative group',
                      href: 'https://tailwindcss.com',
                      target: Target.blank,
                      attributes: {'rel': 'noopener noreferrer', 'title': 'Visit Tailwind CSS'},
                      [
                        text('Tailwind'),
                        // Subtle underline effect
                        span(
                          classes:
                              'absolute -bottom-0.5 left-0 w-0 h-0.5 bg-gradient-primary group-hover:w-full transition-all duration-300',
                          [],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            // Optional: Add a subtle decorative element
            div(
              classes: 'mt-6 pt-4 border-t border-border/30',
              [
                div(
                  classes: 'flex justify-center',
                  [
                    div(
                      classes: 'w-12 h-0.5 bg-gradient-primary rounded-full opacity-50',
                      [],
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

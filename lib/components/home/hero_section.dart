import 'package:jaspr/jaspr.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart' as lucide;
import 'package:portfolio_site/components/home/client/scroll_to_next.dart';
import 'package:portfolio_site/components/ui/icon.dart';
import 'package:portfolio_site/config/site_config.dart';
// import 'client/hero_cta_buttons.dart';

class HeroSection extends StatelessComponent {
  const HeroSection({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield section(
      id: 'home',
      classes:
          'min-h-screen flex items-center justify-center relative overflow-hidden pt-20 md:pt-24',
      [
        // Background decoration with floating orbs
        _buildBackgroundDecorations(),

        // Main content container
        div(
          classes: 'container mx-auto px-4 sm:px-6 lg:px-8 relative z-10',
          [
            div(
              classes: 'grid lg:grid-cols-2 gap-8 md:gap-12 items-center',
              [
                // Content section
                _buildContentSection(),

                // Image section
                _buildImageSection(),
              ],
            ),

            // Scroll indicator - Client-rendered (hidden on mobile)
            div(
              classes: 'hidden md:block', // Hidden on mobile, visible from medium screens up
              [
                ScrollToNextSection(),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildBackgroundDecorations() {
    return div(
      classes: 'absolute inset-0 overflow-hidden',
      [
        // Top-right floating orb
        div(
          classes:
              'absolute -top-40 -right-40 w-80 h-80 bg-primary/20 rounded-full blur-3xl animate-float',
          [],
        ),
        // Bottom-left floating orb with delay
        div(
          classes:
              'absolute -bottom-40 -left-40 w-80 h-80 bg-accent/20 rounded-full blur-3xl animate-float',
          styles: Styles(raw: {'animation-delay': '-3s'}),
          [],
        ),
      ],
    );
  }

  Component _buildContentSection() {
    return div(
      classes: 'space-y-6 md:space-y-8 animate-bounce-in text-center lg:text-left',
      [
        // Main heading and intro
        div(
          classes: 'space-y-4',
          [
            // Main title
            h1(
              classes: 'text-4xl sm:text-5xl lg:text-6xl font-bold font-display leading-tight',
              [
                text("Hi, I'm "),
                span(
                  classes: 'gradient-text text-shimmer',
                  [text('Gozie')],
                ),
              ],
            ),

            // Subtitle with typing effect
            h2(
              classes: 'text-xl sm:text-2xl lg:text-3xl text-muted-foreground font-medium',
              [
                span(
                  classes: 'typing-animation',
                  [text('Mobile Developer & Flutter Expert')],
                ),
              ],
            ),

            // Description
            p(
              classes: 'text-lg text-muted-foreground max-w-xl mx-auto lg:mx-0',
              [
                text(
                    'Crafting exceptional mobile experiences with Flutter, Dart, and modern development tools. '),
                text('4 years of turning ideas into beautiful, performant mobile applications.'),
              ],
            ),
          ],
        ),

        // Stats section
        _buildStatsSection(),

        // CTA Buttons - Client-rendered
        // HeroCTAButtons(),

        // Social Links
        _buildSocialLinks(),
      ],
    );
  }

  Component _buildStatsSection() {
    return div(
      classes: 'flex flex-wrap gap-6 justify-center lg:justify-start',
      [
        // Years Mobile Dev
        div(
          classes: 'text-center',
          [
            div(
              classes: 'text-2xl md:text-3xl font-bold gradient-text',
              [text('${SiteConfig.yearsOfExperience}+')],
            ),
            div(
              classes: 'text-sm text-muted-foreground',
              [text('Years Mobile Dev')],
            ),
          ],
        ),

        // Years Flutter
        div(
          classes: 'text-center',
          [
            div(
              classes: 'text-2xl md:text-3xl font-bold gradient-text',
              [text('${int.parse(SiteConfig.yearsOfExperience) - 1}+')],
            ),
            div(
              classes: 'text-sm text-muted-foreground',
              [text('Years Flutter')],
            ),
          ],
        ),

        // Projects Built
        div(
          classes: 'text-center',
          [
            div(
              classes: 'text-2xl md:text-3xl font-bold gradient-text',
              [text(SiteConfig.projectsBuilt)],
            ),
            div(
              classes: 'text-sm text-muted-foreground',
              [text('Projects Built')],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildSocialLinks() {
    return div(
      classes: 'flex gap-4 justify-center lg:justify-start',
      [
        // GitHub
        _buildSocialLink(
          icon: lucide.github,
          href: 'https://github.com/goziedotcom',
          label: 'Visit GitHub Profile',
        ),

        // LinkedIn
        _buildSocialLink(
          icon: lucide.linkedin,
          href: 'https://linkedin.com/in/gozieihejirika',
          label: 'Visit LinkedIn Profile',
        ),

        // Twitter
        _buildSocialLink(
          icon: lucide.twitter,
          href: 'https://twitter.com/goziedotcom',
          label: 'Visit Twitter Profile',
        ),
      ],
    );
  }

  Component _buildSocialLink({
    required LucideIcon icon,
    required String href,
    required String label,
  }) {
    return a(
      classes:
          'p-3 rounded-lg text-muted-foreground hover:text-primary hover:bg-secondary/50 transition-all duration-300 hover-scale',
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
          width: const Unit.pixels(20),
          height: const Unit.pixels(20),
        ),
      ],
    );
  }

  Component _buildImageSection() {
    return div(
      classes: 'relative lg:order-first animate-bounce-in',
      styles: Styles(raw: {'animation-delay': '0.2s'}),
      [
        div(
          classes: 'relative',
          [
            // Glow effect behind image
            div(
              classes:
                  'absolute inset-0 bg-gradient-primary rounded-3xl blur-2xl opacity-30 animate-pulse-glow',
              [],
            ),

            // Profile image
            img(
              classes:
                  'relative z-10 w-full max-w-md mx-auto rounded-3xl shadow-2xl hover-scale transition-all duration-500',
              src: '/images/gozie-dev.png',
              alt: 'Gozie - Mobile Developer',
              attributes: {
                'loading': 'eager', // Since it's above the fold
              },
            ),
          ],
        ),
      ],
    );
  }
}

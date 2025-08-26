import 'package:jaspr/server.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart' as lucide;
import 'package:portfolio_site/components/about/progress_bar.dart';
import 'package:portfolio_site/components/ui/badge.dart';
import 'package:portfolio_site/components/ui/card.dart';
import 'package:portfolio_site/components/ui/icon.dart';
import 'package:portfolio_site/config/site_config.dart';
import 'package:portfolio_site/models/about_model.dart';
import 'package:portfolio_site/services/remote/remote_service.dart';

class AboutPage extends AsyncStatelessComponent {
  const AboutPage({super.key});

  @override
  Stream<Component> build(BuildContext context) async* {
    final achievements = await RemoteService().getAchievements();

    yield div(
      classes: 'pt-24 pb-16',
      [
        div(
          classes: 'container mx-auto px-4 sm:px-6 lg:px-8',
          [
            div(
              classes: 'max-w-6xl mx-auto',
              [
                // Header
                _buildHeader(),

                // Main Content Grid
                _buildMainContent(),

                // Values Section
                _buildValues(),

                // Career Timeline
                _buildTimeline(achievements),

                // Technologies
                _buildTechnologies(),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildHeader() {
    return div(
      classes: 'text-center mb-16',
      [
        h1(
          classes: 'text-4xl md:text-5xl font-bold font-display mb-4',
          [
            text('About '),
            span(
              classes: 'gradient-text',
              [text('Me')],
            ),
          ],
        ),
        p(
          classes: 'text-xl text-muted-foreground max-w-2xl mx-auto',
          [
            // Accessing subtitle from the strongly-typed header object
            text(SiteConfig.aboutPageContent.header.subtitle),
          ],
        ),
      ],
    );
  }

  Component _buildMainContent() {
    return div(
      classes: 'grid lg:grid-cols-2 gap-12 mb-16',
      [
        // Story Card
        Card(
          additionalClasses: 'hover-scale',
          children: [
            CardHeader(
              children: [
                CardTitle(
                  additionalClasses: 'text-2xl gradient-text',
                  children: [text('My Story')],
                ),
              ],
            ),
            CardContent(
              additionalClasses: 'space-y-4',
              children: [
                // Accessing paragraphs from the strongly-typed story object
                for (String paragraph in SiteConfig.aboutPageContent.story.paragraphs)
                  p(
                    classes: 'text-muted-foreground leading-relaxed',
                    [text(paragraph)],
                  ),
              ],
            ),
          ],
        ),

        // Skills Card
        Card(
          additionalClasses: 'hover-scale',
          children: [
            CardHeader(
              children: [
                CardTitle(
                  additionalClasses: 'text-2xl gradient-text',
                  children: [text('Skills & Expertise')],
                ),
              ],
            ),
            CardContent(
              additionalClasses: 'space-y-6',
              children: [
                // Iterating over strongly-typed Skill objects
                for (Skill skill in SiteConfig.aboutPageContent.skills)
                  _buildSkillItem(skill.name, skill.level),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildSkillItem(String name, int level) {
    return div(
      classes: 'space-y-2',
      [
        div(
          classes: 'flex justify-between items-center',
          [
            span(
              classes: 'font-medium',
              [text(name)],
            ),
            span(
              classes: 'text-sm text-muted-foreground',
              [text('${level}%')],
            ),
          ],
        ),
        ProgressBar(value: level, additionalClasses: 'h-2'),
      ],
    );
  }

  Component _buildValues() {
    return div(
      classes: 'mb-16',
      [
        h2(
          classes: 'text-3xl font-bold font-display text-center mb-8',
          [
            text('My '),
            span(
              classes: 'gradient-text',
              [text('Values')],
            ),
          ],
        ),
        div(
          classes: 'grid md:grid-cols-3 gap-8',
          [
            // Iterating over strongly-typed Value objects
            for (int index = 0; index < SiteConfig.aboutPageContent.values.length; index++)
              _buildValueCard(SiteConfig.aboutPageContent.values[index], index),
          ],
        ),
      ],
    );
  }

  // Changed parameter type from Map<String, dynamic> to Value
  Component _buildValueCard(Value value, int index) {
    return Card(
      hoverEffect: CardHoverEffect.slideBar,
      additionalClasses: 'hover-scale text-center animate-bounce-in',
      styles: {'animation-delay': '${index * 0.1}s'},
      children: [
        CardContent(
          additionalClasses: 'p-6',
          children: [
            div(
              classes: 'flex justify-center mb-4 mt-4',
              [
                div(
                  classes: 'p-3 rounded-lg bg-primary/10',
                  [
                    TIcon(
                      lucideIcon: value.icon, // Accessing icon directly from Value object
                      theme: IconTheme.purple,
                      width: const Unit.pixels(32),
                      height: const Unit.pixels(32),
                    ),
                  ],
                ),
              ],
            ),
            h3(
              classes: 'text-xl font-semibold mb-2',
              [text(value.title)], // Accessing title directly from Value object
            ),
            p(
              classes: 'text-muted-foreground',
              [text(value.description)], // Accessing description directly from Value object
            ),
          ],
        ),
      ],
    );
  }

  Component _buildTimeline(List<Achievement> achievements) {
    return Card(
      additionalClasses: 'hover-scale mb-16',
      children: [
        CardHeader(
          children: [
            CardTitle(
              additionalClasses: 'text-2xl gradient-text flex items-center pb-1',
              children: [
                TIcon(
                  lucideIcon: lucide.calendar,
                  theme: IconTheme.monochrome,
                  width: const Unit.pixels(24),
                  height: const Unit.pixels(24),
                  customClasses: "mr-4",
                ),
                text('Career Highlights'),
              ],
            ),
          ],
        ),
        CardContent(
          children: [
            div(
              classes: 'space-y-8',
              [
                // Iterating over strongly-typed Achievement objects
                for (Achievement achievement in achievements)
                  _buildTimelineItem(achievement),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Changed parameter type from Map<String, String> to Achievement
  Component _buildTimelineItem(Achievement achievement) {
    return div(
      classes: 'flex items-start space-x-4',
      [
        div(
          classes: 'flex-shrink-0',
          [
            Badge(
              variant: BadgeVariant.outline,
              additionalClasses: 'text-primary border-primary',
              children: [text(achievement.year)], // Accessing year directly from Achievement object
            ),
          ],
        ),
        div(
          classes: 'flex-1',
          [
            h3(
              classes: 'text-lg font-semibold mb-1',
              [text(achievement.title)], // Accessing title directly from Achievement object
            ),
            p(
              classes: 'text-muted-foreground',
              [
                text(achievement.description)
              ], // Accessing description directly from Achievement object
            ),
          ],
        ),
      ],
    );
  }

  Component _buildTechnologies() {
    return div(
      classes: 'mt-16',
      [
        h2(
          classes: 'text-3xl font-bold font-display text-center mb-8',
          [
            text('Technologies I '),
            span(
              classes: 'gradient-text',
              [text('Love')],
            ),
          ],
        ),
        div(
          classes: 'flex flex-wrap justify-center gap-3',
          [
            // Iterating over strongly-typed List<String>
            for (String tech in SiteConfig.aboutPageContent.technologies)
              Badge(
                variant: BadgeVariant.secondary,
                additionalClasses: 'text-sm py-2 px-3 hover-scale cursor-pointer',
                children: [text(tech)],
              ),
          ],
        ),
      ],
    );
  }
}

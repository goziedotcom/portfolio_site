import 'package:jaspr/jaspr.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart' as lucide;
import 'package:portfolio_site/components/ui/icon.dart';
import 'package:portfolio_site/providers/theme_providers.dart';

// Sliding switch theme toggle with circular knob
class SlidingThemeToggle extends StatelessComponent {
  final ThemeMode themeMode;
  final bool isDark;
  final VoidCallback onToggle;
  final String? customClasses;

  const SlidingThemeToggle({
    required this.themeMode,
    required this.isDark,
    required this.onToggle,
    this.customClasses,
    Key? key,
  }) : super(key: key);

  @override
  Iterable<Component> build(BuildContext context) sync* {
    // Determine if switch should be "on" (dark mode)
    bool isOn = themeMode == ThemeMode.dark || (themeMode == ThemeMode.system && isDark);

    String tooltip = themeMode == ThemeMode.system
        ? 'Using system theme (${isDark ? 'dark' : 'light'})'
        : isOn
            ? 'Switch to light mode'
            : 'Switch to dark mode';

    // Switch track classes (keep original styling)
    String trackClasses =
        'relative inline-flex h-8 w-14 items-center rounded-full transition-colors duration-300 focus:outline-none cursor-pointer';
    trackClasses += isOn ? ' bg-gray-800 dark:bg-gray-700' : ' bg-gray-200 dark:bg-gray-600';

    // Knob classes with sliding animation and thinner border (only knob bg is transparent)
    String knobClasses =
        'inline-flex h-6 w-6 items-center justify-center rounded-full transition-all duration-300 transform border';

    // Define consistent colors for border and icon
    String lightBorderColor = '#f59e0b'; // amber-500
    String lightIconColor = '#f59e0b'; // Same as border
    String darkBorderColor = '#e9d8fd'; // purple-200 (original)
    String darkIconColor = '#e9d8fd'; // Same as border

    knobClasses += isOn ? ' translate-x-7 bg-black' : ' translate-x-1 bg-white';

    // Apply border color via style since we need precise color control
    Map<String, String> knobStyles =
        isOn ? {'border-color': darkBorderColor} : {'border-color': lightBorderColor};

    String finalClasses = customClasses != null ? '$trackClasses $customClasses' : trackClasses;

    yield button(
      classes: finalClasses,
      attributes: {
        'type': 'button',
        'role': 'switch',
        'aria-checked': isOn.toString(),
        'aria-label': tooltip,
        'title': tooltip,
      },
      events: {
        'click': (event) => onToggle(),
      },
      [
        // Sliding knob with icon
        span(
          classes: knobClasses,
          styles: Styles(raw: knobStyles),
          [
            TIcon(
              lucideIcon: isOn ? lucide.moon : lucide.sun,
              theme: IconTheme.monochrome,
              width: const Unit.pixels(14),
              height: const Unit.pixels(14),
              customStyles: {
                'color': isOn ? darkIconColor : lightIconColor, // Match border color
              },
            ),
          ],
        ),
      ],
    );
  }
}

// Original button with purple hover states
class ThemeToggle extends StatelessComponent {
  final ThemeMode themeMode;
  final bool isDark;
  final VoidCallback onToggle;
  final String? customClasses;

  const ThemeToggle({
    required this.themeMode,
    required this.isDark,
    required this.onToggle,
    this.customClasses,
    Key? key,
  }) : super(key: key);

  @override
  Iterable<Component> build(BuildContext context) sync* {
    // Determine icon and tooltip based on theme mode
    Component icon;
    String tooltip;
    IconTheme iconTheme;

    switch (themeMode) {
      case ThemeMode.light:
        icon = TIcon(
          lucideIcon: lucide.sun,
          theme: IconTheme.monochrome,
          width: const Unit.pixels(16),
          height: const Unit.pixels(16),
        );
        tooltip = 'Switch to dark mode';
        iconTheme = IconTheme.monochrome;
        break;
      case ThemeMode.dark:
        icon = TIcon(
          lucideIcon: lucide.moon,
          theme: IconTheme.monochrome,
          width: const Unit.pixels(16),
          height: const Unit.pixels(16),
        );
        tooltip = 'Switch to light mode';
        iconTheme = IconTheme.monochrome;
        break;
      case ThemeMode.system:
        icon = TIcon(
          lucideIcon: isDark ? lucide.moon : lucide.sun,
          theme: IconTheme.monochrome,
          width: const Unit.pixels(16),
          height: const Unit.pixels(16),
        );
        tooltip = 'Using system theme';
        iconTheme = IconTheme.monochrome;
        break;
    }

    // Button classes with purple hover states
    String baseClasses =
        'p-2 rounded-lg bg-secondary/50 hover:bg-secondary text-secondary-foreground transition-all duration-300 border border-border/50 backdrop-blur-sm group';

    String finalClasses = customClasses != null ? '$baseClasses $customClasses' : baseClasses;

    yield button(
      classes: finalClasses,
      attributes: {
        'type': 'button',
        'title': tooltip,
        'aria-label': tooltip,
      },
      events: {
        'click': (event) => onToggle(),
      },
      [
        span(
          classes:
              'text-lg transition-all duration-200 group-hover:text-purple-500 dark:group-hover:text-purple-400 group-hover:scale-110',
          [icon],
        ),
      ],
    );
  }
}

/*
Usage examples:

// Sliding switch toggle
SlidingThemeToggle(
  themeMode: currentThemeMode,
  isDark: isDarkMode,
  onToggle: () => toggleTheme(),
)

// With custom classes for additional styling
SlidingThemeToggle(
  themeMode: currentThemeMode,
  isDark: isDarkMode,
  onToggle: () => toggleTheme(),
  customClasses: 'shadow-sm hover:shadow-md',
)

// In a navigation bar or settings panel
div(
  classes: 'flex items-center justify-between p-4',
  [
    text('Theme'),
    SlidingThemeToggle(
      themeMode: themeMode,
      isDark: isDark,
      onToggle: handleThemeToggle,
    ),
  ],
)

// Original button with purple hover
ThemeToggleButton(
  themeMode: currentThemeMode,
  isDark: currentIsDark,
  onToggle: () {
    context.read(themeProvider.notifier).toggleTheme();
  },
)
*/

import 'package:jaspr/jaspr.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart' as lucide;

enum IconTheme {
  monochrome, // white/black
  purple, // dark purple/light purple
}

typedef LucideIcon = Component Function({
  Unit? width,
  Unit? height,
  String? viewBox,
  Map<String, String>? attributes,
  String? id,
  Key? key,
  String? classes,
  Styles? styles,
  Map<String, EventCallback>? events,
});

class TIcon extends StatelessComponent {
  final LucideIcon lucideIcon;
  final IconTheme theme;
  final Unit? width;
  final Unit? height;
  final String? customClasses;
  final Map<String, String>? customStyles;
  final String? id;
  final Key? key;
  final Map<String, EventCallback>? events;

  const TIcon({
    required this.lucideIcon,
    this.theme = IconTheme.monochrome,
    this.width,
    this.height,
    this.customClasses,
    this.customStyles,
    this.id,
    this.key,
    this.events,
  });

  // Factory constructors for common icons
  factory TIcon.mail({
    IconTheme theme = IconTheme.monochrome,
    Unit? width,
    Unit? height,
    String? customClasses,
    Map<String, String>? customStyles,
    String? id,
    Key? key,
    Map<String, EventCallback>? events,
  }) {
    return TIcon(
      lucideIcon: lucide.mail,
      theme: theme,
      width: width,
      height: height,
      customClasses: customClasses,
      customStyles: customStyles,
      id: id,
      key: key,
      events: events,
    );
  }

  factory TIcon.settings({
    IconTheme theme = IconTheme.monochrome,
    Unit? width,
    Unit? height,
    String? customClasses,
    Map<String, String>? customStyles,
    String? id,
    Key? key,
    Map<String, EventCallback>? events,
  }) {
    return TIcon(
      lucideIcon: lucide.settings,
      theme: theme,
      width: width,
      height: height,
      customClasses: customClasses,
      customStyles: customStyles,
      id: id,
      key: key,
      events: events,
    );
  }

  factory TIcon.sun({
    IconTheme theme = IconTheme.monochrome,
    Unit? width,
    Unit? height,
    String? customClasses,
    Map<String, String>? customStyles,
    String? id,
    Key? key,
    Map<String, EventCallback>? events,
  }) {
    return TIcon(
      lucideIcon: lucide.sun,
      theme: theme,
      width: width,
      height: height,
      customClasses: customClasses,
      customStyles: customStyles,
      id: id,
      key: key,
      events: events,
    );
  }

  factory TIcon.moon({
    IconTheme theme = IconTheme.monochrome,
    Unit? width,
    Unit? height,
    String? customClasses,
    Map<String, String>? customStyles,
    String? id,
    Key? key,
    Map<String, EventCallback>? events,
  }) {
    return TIcon(
      lucideIcon: lucide.moon,
      theme: theme,
      width: width,
      height: height,
      customClasses: customClasses,
      customStyles: customStyles,
      id: id,
      key: key,
      events: events,
    );
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    // Base classes WITHOUT hardcoded sizing - let width/height attributes control size
    String baseClasses = '';
    Map<String, String> styleMap = {};

    // Apply theme-specific styling
    switch (theme) {
      case IconTheme.monochrome:
        // For white/black theme - use currentColor
        baseClasses += 'text-current';
        break;
      case IconTheme.purple:
        // For purple theme - set color directly
        baseClasses += 'gradient-text';
        styleMap['color'] = '#8b5cf6'; // Set to purple
        break;
    }

    // Combine custom classes
    String finalClasses = customClasses != null ? '$baseClasses $customClasses' : baseClasses;

    // Combine custom styles
    Map<String, String> finalStyleMap = {
      ...styleMap,
      ...?customStyles,
    };

    // Create Styles object only if we have styles to apply
    Styles? finalStyles = finalStyleMap.isNotEmpty ? Styles(raw: finalStyleMap) : null;

    yield lucideIcon(
      classes: finalClasses,
      width: width ?? const Unit.pixels(24),
      height: height ?? const Unit.pixels(24),
      styles: finalStyles,
      id: id,
      key: key,
      events: events,
    );
  }
}

/*
Usage examples - These will now work correctly:

// Small icon (16px)
TIcon.mail(
  width: Unit.pixels(16),
  height: Unit.pixels(16),
)

// Large icon (32px)
TIcon.settings(
  theme: IconTheme.purple,
  width: Unit.pixels(32),
  height: Unit.pixels(32),
)

// Tiny icon (12px)
TIcon.sun(
  width: Unit.pixels(12),
  height: Unit.pixels(12),
)
*/

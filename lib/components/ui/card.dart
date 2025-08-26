import 'package:jaspr/jaspr.dart';

// Enhanced Card Component with New Hover Effects
enum CardHoverEffect {
  none,     // No hover animation
  subtle,   // Subtle inner glow (default)
  glow,     // Medium glow effect
  scale,    // Scale with inner glow effect
  slideBar, // Sliding bar from center (like your screenshot)
}

class Card extends StatelessComponent {
  final List<Component> children;
  final String? additionalClasses;
  final Map<String, String>? styles;
  final Map<String, String>? attributes;
  final CardHoverEffect hoverEffect;

  const Card({
    super.key,
    required this.children,
    this.additionalClasses,
    this.styles,
    this.attributes,
    this.hoverEffect = CardHoverEffect.subtle, // Default: subtle hover
  });

  String get _hoverClass {
    switch (hoverEffect) {
      case CardHoverEffect.none:
        return '';
      case CardHoverEffect.subtle:
        return 'card-hover-subtle';
      case CardHoverEffect.glow:
        return 'card-hover-glow';
      case CardHoverEffect.scale:
        return 'card-hover-scale';
      case CardHoverEffect.slideBar:
        return 'card-hover-slide-bar';
    }
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final baseClasses = 'rounded-lg border bg-card text-card-foreground shadow-sm';
    final hoverClass = _hoverClass;
    final allClasses =
        '$baseClasses ${hoverClass.isNotEmpty ? '$hoverClass ' : ''}${additionalClasses ?? ''}';

    yield div(
      classes: allClasses,
      styles: styles != null ? Styles(raw: styles!) : null,
      attributes: attributes,
      children,
    );
  }
}

class CardHeader extends StatelessComponent {
  final List<Component> children;
  final String? additionalClasses;

  const CardHeader({
    super.key,
    required this.children,
    this.additionalClasses,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes: 'flex flex-col space-y-1.5 p-6 ${additionalClasses ?? ''}',
      children,
    );
  }
}

class CardTitle extends StatelessComponent {
  final List<Component> children;
  final String? additionalClasses;

  const CardTitle({
    super.key,
    required this.children,
    this.additionalClasses,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield h3(
      classes: 'text-2xl font-semibold leading-none tracking-tight ${additionalClasses ?? ''}',
      children,
    );
  }
}

class CardDescription extends StatelessComponent {
  final List<Component> children;
  final String? additionalClasses;

  const CardDescription({
    super.key,
    required this.children,
    this.additionalClasses,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield p(
      classes: 'text-sm text-muted-foreground ${additionalClasses ?? ''}',
      children,
    );
  }
}

class CardContent extends StatelessComponent {
  final List<Component> children;
  final String? additionalClasses;

  const CardContent({
    super.key,
    required this.children,
    this.additionalClasses,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes: 'p-6 pt-0 ${additionalClasses ?? ''}',
      children,
    );
  }
}

class CardFooter extends StatelessComponent {
  final List<Component> children;
  final String? additionalClasses;

  const CardFooter({
    super.key,
    required this.children,
    this.additionalClasses,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes: 'flex items-center p-6 pt-0 ${additionalClasses ?? ''}',
      children,
    );
  }
}

/*
Usage Examples:

// Default subtle hover effect
Card(
  hoverEffect: CardHoverEffect.subtle, // or omit for default
  children: [
    CardHeader(children: [
      CardTitle(children: [text('Project Title')]),
      CardDescription(children: [text('Project description')]),
    ]),
    CardContent(children: [
      text('Card content here'),
    ]),
  ],
)

// Sliding bar effect (like your screenshot) - MOST IMPORTANT TO TEST
Card(
  hoverEffect: CardHoverEffect.slideBar,
  children: [
    CardContent(children: [text('Project with sliding bar effect')]),
  ],
)

// Debug: Test if hover classes are being applied
Card(
  hoverEffect: CardHoverEffect.slideBar,
  additionalClasses: 'min-h-[200px] bg-red-100', // Add visible background to test
  children: [
    CardContent(children: [text('DEBUG: Hover over this card to see the sliding bar')]),
  ],
)

// No hover effect for info cards
Card(
  hoverEffect: CardHoverEffect.none,
  children: [
    CardContent(children: [text('Static info card')]),
  ],
)

// Enhanced glow effect
Card(
  hoverEffect: CardHoverEffect.glow,
  children: [
    CardContent(children: [text('Interactive card')]),
  ],
)

// Scale effect for primary actions
Card(
  hoverEffect: CardHoverEffect.scale,
  children: [
    CardContent(children: [text('Primary action card')]),
  ],
)

TROUBLESHOOTING:
1. Check browser dev tools to see if 'card-hover-slide-bar' class is applied
2. Verify the CSS file is properly loaded and compiled
3. Test with the debug card above to see if any hover effects work
4. Make sure you're using the correct styles file
*/
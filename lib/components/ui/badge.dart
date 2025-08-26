import 'package:jaspr/jaspr.dart';

enum BadgeVariant {
  primary('border-transparent bg-primary text-primary-foreground hover:bg-primary/80'),
  secondary('border-transparent bg-secondary text-secondary-foreground hover:bg-secondary/80'),
  destructive(
      'border-transparent bg-destructive text-destructive-foreground hover:bg-destructive/80'),
  outline('text-foreground border-border');

  const BadgeVariant(this.classes);
  final String classes;
}

class Badge extends StatelessComponent {
  final List<Component> children;
  final BadgeVariant variant;
  final String? additionalClasses;
  final Map<String, String>? styles;
  final Map<String, String>? attributes;
  final Map<String, EventCallback>? events;

  const Badge({
    super.key,
    required this.children,
    this.variant = BadgeVariant.primary,
    this.additionalClasses,
    this.styles,
    this.attributes,
    this.events,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final baseClasses =
        'inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2';
    final classes = '$baseClasses ${variant.classes} ${additionalClasses ?? ''}';

    yield div(
      classes: classes,
      styles: Styles(raw: styles),
      attributes: attributes,
      events: events,
      children,
    );
  }
}


// Alternative simpler Badge component for prefer less functionality
class SimpleBadge extends StatelessComponent {
  final String textString;
  final String? variant;
  final String? additionalClasses;
  final Map<String, String>? styles;
  final VoidCallback? onTap;

  const SimpleBadge({
    super.key,
    required this.textString,
    this.variant = 'secondary',
    this.additionalClasses,
    this.styles,
    this.onTap,
  });

  String get _variantClasses {
    switch (variant) {
      case 'primary':
        return 'border-transparent bg-primary text-primary-foreground hover:bg-primary/80';
      case 'secondary':
        return 'border-transparent bg-secondary text-secondary-foreground hover:bg-secondary/80';
      case 'destructive':
        return 'border-transparent bg-destructive text-destructive-foreground hover:bg-destructive/80';
      case 'outline':
        return 'text-foreground border-border';
      default:
        return 'border-transparent bg-secondary text-secondary-foreground hover:bg-secondary/80';
    }
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final baseClasses =
        'inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2';
    final classes = '$baseClasses $_variantClasses ${additionalClasses ?? ''}';

    yield div(
      classes: classes,
      styles: Styles(raw: styles),
      events: onTap != null ? {'click': (event) => onTap!()} : null,
      [text(textString)],
    );
  }
}

// Usage example with SimpleBadge (alternative approach):
/*
SimpleBadge(
  text: 'Flutter',
  variant: 'secondary',
  additionalClasses: 'hover-scale cursor-pointer',
  onTap: () => print('Flutter clicked'),
)
*/
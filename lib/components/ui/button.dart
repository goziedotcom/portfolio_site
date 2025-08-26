import 'package:jaspr/jaspr.dart';
import 'package:portfolio_site/components/ui/icon.dart';

// Button variant enums
enum ButtonVariant {
  primary,
  destructive,
  outline,
  secondary,
  ghost,
  link,
}

enum ButtonSize {
  small,
  medium,
  large,
  icon,
}

class TButton extends StatelessComponent {
  final String? text;
  final LucideIcon? icon;
  final bool iconOnly;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool disabled;
  final bool fullWidth;
  final bool autofocus;
  final ButtonType type;
  final String? customClasses;
  final Map<String, String>? customAttributes;
  final VoidCallback? onClick;
  final List<Component>? children;

  // New parameter for outline border style
  final bool subtleBorder;

  const TButton({
    this.text,
    this.icon,
    this.iconOnly = false,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.fullWidth = false,
    this.autofocus = false,
    this.type = ButtonType.button,
    this.customClasses,
    this.customAttributes,
    this.onClick,
    this.children,
    this.subtleBorder = false, // Default to noticeable border
    Key? key,
  }) : super(key: key);

  // Factory constructors for common use cases
  // Factory constructors for common use cases
  factory TButton.primary({
    String? text,
    LucideIcon? icon,
    bool iconOnly = false,
    ButtonSize size = ButtonSize.medium,
    bool disabled = false,
    bool fullWidth = false,
    bool autofocus = false,
    ButtonType type = ButtonType.button,
    String? customClasses,
    Map<String, String>? customAttributes,
    VoidCallback? onClick,
    Key? key,
  }) {
    return TButton(
      text: text,
      icon: icon,
      iconOnly: iconOnly,
      variant: ButtonVariant.primary,
      size: size,
      disabled: disabled,
      fullWidth: fullWidth,
      autofocus: autofocus,
      type: type,
      customClasses: customClasses,
      customAttributes: customAttributes,
      onClick: onClick,
      key: key,
    );
  }

  factory TButton.ghost({
    String? text,
    LucideIcon? icon,
    bool iconOnly = false,
    ButtonSize size = ButtonSize.medium,
    bool disabled = false,
    bool fullWidth = false,
    bool autofocus = false,
    ButtonType type = ButtonType.button,
    String? customClasses,
    Map<String, String>? customAttributes,
    VoidCallback? onClick,
    Key? key,
  }) {
    return TButton(
      text: text,
      icon: icon,
      iconOnly: iconOnly,
      variant: ButtonVariant.ghost,
      size: size,
      disabled: disabled,
      fullWidth: fullWidth,
      autofocus: autofocus,
      type: type,
      customClasses: customClasses,
      customAttributes: customAttributes,
      onClick: onClick,
      key: key,
    );
  }

  factory TButton.outline({
    String? text,
    LucideIcon? icon,
    bool iconOnly = false,
    ButtonSize size = ButtonSize.medium,
    bool disabled = false,
    bool fullWidth = false,
    bool autofocus = false,
    ButtonType type = ButtonType.button,
    String? customClasses,
    Map<String, String>? customAttributes,
    bool subtleBorder = true,
    VoidCallback? onClick,
    Key? key,
  }) {
    return TButton(
      text: text,
      icon: icon,
      iconOnly: iconOnly,
      variant: ButtonVariant.outline,
      size: size,
      disabled: disabled,
      fullWidth: fullWidth,
      autofocus: autofocus,
      type: type,
      customClasses: customClasses,
      customAttributes: customAttributes,
      subtleBorder: subtleBorder,
      onClick: onClick,
      key: key,
    );
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    // Base classes - Web3 styling with less rounded corners
    String baseClasses =
        'inline-flex items-center justify-center gap-2 whitespace-nowrap font-medium transition-all duration-300 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50';

    // Add Web3 rounded corners (sharper than before)
    baseClasses += ' rounded-[0.375rem]'; // Even sharper for Web3 feel

    // Variant-specific styling
    String variantClasses = _getVariantClasses();

    // Size-specific styling
    String sizeClasses = _getSizeClasses();

    // Full width if specified
    if (fullWidth) {
      baseClasses += ' w-full';
    }

    // Disabled state
    if (disabled) {
      baseClasses += ' cursor-not-allowed';
    } else {
      baseClasses += ' cursor-pointer hover-scale';
    }

    // Combine all classes
    String finalClasses = '$baseClasses $variantClasses $sizeClasses';
    if (customClasses != null) {
      finalClasses += ' $customClasses';
    }

    // Prepare attributes
    Map<String, String> finalAttributes = {
      'aria-disabled': disabled.toString(),
      ...?customAttributes,
    };

    yield button(
      classes: finalClasses,
      type: type,
      disabled: disabled,
      autofocus: autofocus,
      attributes: finalAttributes,
      onClick: disabled ? null : onClick,
      [
        // Render children or default content
        if (children != null) ...children! else ..._buildDefaultContent(_getIconSize()),
      ],
    );
  }

  String _getVariantClasses() {
    switch (variant) {
      case ButtonVariant.primary:
        return 'bg-primary text-primary-foreground hover:bg-primary/90 shadow-lg hover:shadow-xl';

      case ButtonVariant.destructive:
        return 'bg-destructive text-destructive-foreground hover:bg-destructive/90 shadow-lg hover:shadow-xl';

      case ButtonVariant.outline:
        // Use subtleBorder to determine border opacity
        if (subtleBorder) {
          // Very faint border (barely noticeable) - like code/link action buttons
          return 'border border-primary/10 dark:border-primary/10 text-foreground dark:text-foreground hover:bg-primary hover:text-primary-foreground shadow-sm hover:shadow-md hover:border-primary/30';
        } else {
          // Noticeable but still faint border - default outline style
          return 'border border-primary/30 dark:border-primary/30 text-foreground dark:text-foreground hover:bg-primary hover:text-primary-foreground shadow-sm hover:shadow-md';
        }

      case ButtonVariant.secondary:
        return 'bg-secondary text-secondary-foreground hover:bg-secondary/80 shadow-sm hover:shadow-md';

      case ButtonVariant.ghost:
        return 'bg-white/95 dark:bg-white text-primary dark:text-purple-600 hover:bg-white hover:dark:bg-white/90 shadow-lg hover:shadow-xl';

      case ButtonVariant.link:
        return 'text-primary underline-offset-4 hover:underline bg-transparent shadow-none';
    }
  }

  String _getSizeClasses() {
    if (iconOnly) {
      switch (size) {
        case ButtonSize.small:
          return 'h-8 w-8';
        case ButtonSize.medium:
          return 'h-10 w-10';
        case ButtonSize.large:
          return 'h-12 w-12';
        case ButtonSize.icon:
          return 'h-10 w-10';
      }
    }

    switch (size) {
      case ButtonSize.small:
        return 'h-9 px-3 text-sm';
      case ButtonSize.medium:
        return 'h-10 px-4 text-sm';
      case ButtonSize.large:
        return 'h-12 px-8 text-base';
      case ButtonSize.icon:
        return 'h-10 w-10';
    }
  }

  Unit _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return const Unit.pixels(16);
      case ButtonSize.medium:
        return const Unit.pixels(20);
      case ButtonSize.large:
        return const Unit.pixels(24);
      case ButtonSize.icon:
        return const Unit.pixels(20);
    }
  }

  List<Component> _buildDefaultContent(Unit iconSize) {
    List<Component> content = [];

    // Add icon if provided
    if (icon != null) {
      content.add(
        TIcon(
          lucideIcon: icon!,
          theme: IconTheme.monochrome,
          width: iconSize,
          height: iconSize,
          customClasses: 'text-current', // Inherit button text color
        ),
      );
    }

    // Add text if provided and not icon-only
    if (text != null && !iconOnly) {
      content.add(Text(text!));
    }

    return content;
  }
}

/*
Usage Examples:

// Default outline button (noticeable border)
TButton.outline(
  text: 'Learn More',
  icon: lucide.arrowRight,
  onClick: () => print('Default outline clicked'),
)

// Subtle outline button (barely noticeable border) - like code/link action buttons
TButton.outline(
  text: 'Code',
  icon: lucide.code,
  subtleBorder: true, // Very faint border
  onClick: () => print('Subtle outline clicked'),
)

// Another subtle example
TButton.outline(
  text: 'Link',
  icon: lucide.externalLink,
  subtleBorder: true,
  size: ButtonSize.small,
  onClick: () => print('Link clicked'),
)

// You can also pass additional border styles via customClasses if needed
TButton.outline(
  text: 'Custom Border',
  icon: lucide.settings,
  subtleBorder: true,
  customClasses: 'border-blue-200 hover:border-blue-400', // Override border color
  onClick: () => print('Custom border clicked'),
)

// Primary button with icon
TButton.primary(
  text: 'Get Started',
  icon: lucide.rocket,
  size: ButtonSize.large,
  onClick: () => print('Primary clicked'),
)

// Ghost button (like your current one)
TButton.ghost(
  text: 'Get In Touch',
  icon: lucide.send,
  fullWidth: true,
  onClick: () => handleContactClick(),
)
*/

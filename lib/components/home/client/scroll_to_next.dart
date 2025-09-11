import 'package:jaspr/jaspr.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart' as lucide;
import 'package:portfolio_site/components/ui/button.dart';
import 'package:portfolio_site/services/interop/scroll_interop.dart';
@Import.onWeb('package:portfolio_site/services/interop/scroll_interop.dart', show: [#customScroll])

// @client
class ScrollToNextSection extends StatelessComponent {
  const ScrollToNextSection();

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes: 'absolute bottom-8 left-1/2 transform -translate-x-1/2',
      [
        TButton.primary(
          icon: lucide.arrowDown,
          iconOnly: true,
          onClick: () {
            if (!kIsWeb) return;
            customScroll.toElement('#services', 800, -65); // -65px offset for header
          },
          customClasses: [
            'backdrop-blur-md',
            'shadow-purple hover:shadow-glow',
            'transition-smooth',
            'animate-bounce', // Infinite bounce animation
            'hover:animate-pulse-glow',
          ].join(' '),
          customAttributes: {
            'aria-label': 'Scroll down to see more content',
            'title': 'Scroll down',
          },
        ),
      ],
    );
  }
}
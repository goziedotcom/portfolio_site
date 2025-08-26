import 'dart:async';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart' as lucide;
import 'package:portfolio_site/components/ui/button.dart';
import 'package:universal_web/web.dart' as web;

@Import.onWeb('package:portfolio_site/services/interop/scroll_interop.dart', show: [#customScroll])
import 'scroll_to_top_button.imports.dart';

@client
class ScrollToTopButton extends StatefulComponent {
  final double showAtViewportFraction; // show after scrolling x fraction of viewport height
  final int scrollDurationMs;
  final String? customClasses;

  const ScrollToTopButton({
    this.showAtViewportFraction = 1.0, // Show after scrolling fraction of screen height
    this.scrollDurationMs = 800,
    this.customClasses,
    super.key,
  });

  @override
  State<ScrollToTopButton> createState() => _ScrollToTopButtonState();
}

class _ScrollToTopButtonState extends State<ScrollToTopButton> {
  bool _isVisible = false;
  StreamSubscription<web.Event>? _scrollSubscription;
  StreamSubscription<web.Event>? _resizeSubscription;
  double _threshold = 0;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _setupEventListeners();
      _calculateThreshold(); // Initial calculation
    }
  }

  @override
  void dispose() {
    _scrollSubscription?.cancel();
    _resizeSubscription?.cancel();
    super.dispose();
  }

  // ============================================================================
  // EVENT LISTENERS SETUP
  // ============================================================================

  void _setupEventListeners() {
    // Listen for scroll events
    _scrollSubscription =
        web.EventStreamProviders.scrollEvent.forTarget(web.window).listen(_handleScroll);

    // Listen for resize events to recalculate threshold
    _resizeSubscription =
        web.EventStreamProviders.resizeEvent.forTarget(web.window).listen(_handleResize);
  }

  // ============================================================================
  // EVENT HANDLERS
  // ============================================================================

  void _handleScroll(web.Event event) {
    final currentPosition = web.window.scrollY.toDouble();
    final shouldShow = currentPosition > _threshold;

    // Only setState if visibility actually changed
    if (shouldShow != _isVisible) {
      setState(() {
        _isVisible = shouldShow;
      });
    }
  }

  void _handleResize(web.Event event) {
    // Recalculate threshold when window is resized
    _calculateThreshold();
    // Also check visibility with new threshold
    _handleScroll(event);
  }

  // ============================================================================
  // HELPERS
  // ============================================================================

  void _calculateThreshold() {
    try {
      final viewportHeight = web.window.innerHeight.toDouble();
      _threshold = viewportHeight * component.showAtViewportFraction;
    } catch (e) {
      _threshold = 0; // Fallback
    }
  }

  void _scrollToTop() {
    if (kIsWeb) {
      customScroll.toTop(component.scrollDurationMs.toDouble());
    }
  }

  // ============================================================================
  // BUILD METHOD
  // ============================================================================

  @override
  Iterable<Component> build(BuildContext context) sync* {
    if (!_isVisible) return;

    yield div(
      classes: [
        'fixed bottom-6 right-6 z-50',
        'transition-all duration-300',
        _isVisible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4',
        'md:bottom-8 md:right-8',
        component.customClasses ?? '',
      ].join(' '),
      [
        TButton(
          icon: lucide.arrowUp,
          iconOnly: true,
          onClick: _scrollToTop,
          customClasses: [
            'hover:bg-primary/90', // Darker purple on hover
            'backdrop-blur-md', // Glass effect
            'shadow-purple hover:shadow-glow', // Your shadows
            'transition-smooth', // Smooth transitions
          ].join(' '),
          customAttributes: {
            'aria-label': 'Scroll to top',
            'title': 'Scroll to top',
          },
        )
      ],
    );
  }
}

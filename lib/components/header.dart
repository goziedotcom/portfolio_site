import 'dart:async';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:portfolio_site/components/ui/theme_toggle_button.dart';
import 'package:portfolio_site/config/site_config.dart';
import 'package:portfolio_site/main.dart';
import 'package:portfolio_site/providers/theme_providers.dart';
import 'package:universal_web/web.dart' as web;

@client
class Header extends StatefulComponent {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _isMenuOpen = false;
  bool _isAtTop = true;
  StreamSubscription<web.Event>? _scrollSubscription;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _setupScrollListener();
    }
  }

  @override
  void dispose() {
    _scrollSubscription?.cancel();
    super.dispose();
  }

  void _setupScrollListener() {
    _scrollSubscription = web.EventStreamProviders.scrollEvent
        .forTarget(
          web.window,
        )
        .listen(_handleScroll);
  }

  void _handleScroll(web.Event event) {
    final scrollTop = web.window.scrollY;
    final wasAtTop = _isAtTop;
    final nowAtTop = scrollTop <= 0;

    // Only setState if the state actually changed
    if (wasAtTop != nowAtTop) {
      setState(() {
        _isAtTop = nowAtTop;
      });
    }
  }

  void _toggleMenu() {
    setState(() => _isMenuOpen = !_isMenuOpen);
  }

  String get _headerClass {
    return _isAtTop ? 'at-top' : 'scrolled';
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    var activePath = context.url;

    yield ProviderScope(
      parent: container,
      child: Builder(
        builder: (context) sync* {
          // Watch theme state for the toggle button
          final themeMode = context.watch(themeProvider);
          final isDark = context.watch(isDarkProvider);
          final notifier = context.read(themeProvider.notifier);

          yield header(
            id: 'main-header', // Important: ID for JS targeting
            classes: [
              'fixed top-0 left-0 right-0 z-50 transition-all duration-300',
              _headerClass, // Dynamic classes from JavaScript
            ].join(' '),
            [
              div(
                classes: 'container mx-auto px-4 sm:px-6 lg:px-8',
                [
                  div(
                    classes: 'flex items-center justify-between h-16',
                    [
                      // Logo with enhanced styling
                      _buildLogo(),

                      // Desktop navigation
                      _buildDesktopNavigation(activePath),

                      // Right side controls
                      div(
                        classes: 'flex items-center space-x-4',
                        [
                          // Enhanced theme toggle
                          if (kIsWeb)
                            SlidingThemeToggle(
                              themeMode: themeMode,
                              isDark: isDark,
                              onToggle: notifier.toggleTheme,
                            ),

                          // Enhanced mobile menu button
                          _buildMobileMenuButton(),
                        ],
                      ),
                    ],
                  ),

                  // Enhanced mobile menu
                  _buildMobileMenu(activePath),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Component _buildLogo() {
    return Link(
      to: '/',
      child: div(
        classes: 'flex-shrink-0',
        [
          span(
            classes: 'text-2xl font-bold font-display gradient-text hover-scale',
            [text('Gozie')],
          ),
        ],
      ),
    );
  }

  Component _buildDesktopNavigation(String activePath) {
    return nav(
      classes: 'hidden md:flex items-center space-x-8',
      [
        for (var entry in SiteConfig.navLinks.entries)
          _buildDesktopNavLink(entry.key, entry.value, activePath),
      ],
    );
  }

  Component _buildDesktopNavLink(String label, String href, String activePath) {
    final isActive = activePath == href;

    return a(
      classes:
          'text-foreground/80 hover:text-primary transition-colors duration-300 font-medium relative group',
      href: isActive ? 'javascript:void(0)' : href,
      [
        text(label),
        // Animated underline
        span(
          classes:
              'absolute -bottom-1 left-0 w-0 h-0.5 bg-gradient-primary group-hover:w-full transition-all duration-300 ${isActive ? 'w-full' : ''}',
          [],
        ),
      ],
    );
  }

  Component _buildMobileMenuButton() {
    return button(
      classes:
          'md:hidden p-2 rounded-lg bg-secondary/50 hover:bg-secondary text-secondary-foreground hover-scale transition-all duration-300 border border-border/50 backdrop-blur-sm focus:outline-none focus:ring-2 focus:ring-primary/50',
      attributes: {
        'aria-label': _isMenuOpen ? 'Close menu' : 'Open menu',
        'aria-expanded': _isMenuOpen.toString(),
      },
      events: {'click': (e) => _toggleMenu()},
      [
        span(classes: 'sr-only', [text('Toggle menu')]),
        _buildHamburgerIcon(),
      ],
    );
  }

  Component _buildHamburgerIcon() {
    return div(
      classes: 'w-6 h-6 flex flex-col justify-center items-center space-y-1',
      [
        div(
          classes:
              'w-5 h-0.5 bg-current transition-all duration-300 transform ${_isMenuOpen ? 'rotate-45 translate-y-1.5' : ''}',
          [],
        ),
        div(
          classes:
              'w-5 h-0.5 bg-current transition-all duration-300 ${_isMenuOpen ? 'opacity-0' : ''}',
          [],
        ),
        div(
          classes:
              'w-5 h-0.5 bg-current transition-all duration-300 transform ${_isMenuOpen ? '-rotate-45 -translate-y-1.5' : ''}',
          [],
        ),
      ],
    );
  }

  Component _buildMobileMenu(String activePath) {
    return _isMenuOpen
        ? div(
            classes:
                'md:hidden absolute top-16 left-0 right-0 glass border-t border-border animate-fade-in-down',
            attributes: {
              'aria-hidden': (!_isMenuOpen).toString(),
            },
            [
              nav(
                classes: 'px-4 py-6 space-y-4',
                [
                  for (var entry in SiteConfig.navLinks.entries)
                    _buildMobileNavLink(entry.key, entry.value, activePath),
                ],
              ),
            ],
          )
        : div(classes: 'hidden', []);
  }

  Component _buildMobileNavLink(String label, String href, String activePath) {
    final isActive = activePath == href;

    return a(
      classes:
          'block text-foreground/80 hover:text-primary transition-colors duration-300 font-medium py-2 px-4 rounded-lg hover:bg-secondary/50 ${isActive ? 'text-primary bg-primary/10' : ''}',
      href: isActive ? 'javascript:void(0)' : href,
      events: {
        'click': (e) => setState(() => _isMenuOpen = false),
      },
      [text(label)],
    );
  }
}

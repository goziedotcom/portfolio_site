import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:portfolio_site/config/app_config.dart';
import 'package:portfolio_site/main.dart';
import 'package:portfolio_site/providers/theme_providers.dart';

@client
class Header extends StatefulComponent {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    var activePath = context.url;

    yield ProviderScope(
      parent: container,
      child: Builder(
        builder: (context) sync*{
          // Watch theme state for the toggle button
          final themeMode = context.watch(themeProvider);
          final isDark = context.watch(isDarkProvider);
          
          yield header(
            classes: 'navbar',
            [
              div(
                classes: 'nav-container',
                [
                  // Logo
                  Link(
                    to: '/',
                    child: div(
                      classes: 'logo group',
                      [text('Gozie Ihejirika')],
                    ),
                  ),

                  // Desktop navigation
                  nav(
                    classes: 'hidden md:flex',
                    [
                      ul(
                        classes: 'nav-links',
                        [
                          for (var entry in SiteConfig.navLinks.entries)
                            li([_buildNavLink(entry.key, entry.value, activePath)]),
                        ],
                      ),
                    ],
                  ),

                  // Right side controls
                  div(
                    classes: 'flex items-center gap-3 md:gap-4',
                    [
                      // Theme toggle with proper state reflection
                      _buildThemeToggle(context, themeMode, isDark),

                      // Mobile menu button
                      _buildMobileMenuButton(),
                    ],
                  ),
                ],
              ),

              // Mobile menu
              _buildMobileMenu(activePath),
            ],
          );
        },
      ),
    );
  }

  Component _buildThemeToggle(BuildContext context, ThemeMode themeMode, bool isDark) {
    // Determine the icon and tooltip based on current theme
    String icon;
    String tooltip;
    
    switch (themeMode) {
      case ThemeMode.light:
        icon = '☀️';
        tooltip = 'Switch to dark mode';
        break;
      case ThemeMode.dark:
        icon = '🌙';
        tooltip = 'Switch to light mode';
        break;
      case ThemeMode.system:
        icon = isDark ? '🌙' : '☀️';
        tooltip = 'Using system theme';
        break;
    }

    return button(
      classes: 'theme-toggle', // Use the correct CSS class
      attributes: {
        'title': tooltip,
        'aria-label': tooltip,
      },
      events: {
        'click': (event) {
          context.read(themeProvider.notifier).toggleTheme();
        }
      },
      [
        span(
          classes: 'text-lg md:text-xl transition-transform duration-200 hover:scale-110',
          [text(icon)],
        ),
      ],
    );
  }

  Component _buildNavLink(String label, String href, String activePath) {
    final isActive = activePath == href;

    return a(
      classes: 'nav-link ${isActive ? 'active' : ''}',
      href: href,
      [text(label)],
    );
  }

  Component _buildMobileMenuButton() {
    return button(
      classes:
          'md:hidden p-2 rounded-lg text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800 theme-transition focus:outline-none focus:ring-2 focus:ring-purple-500/50 transition-all duration-200',
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
    return div(
      classes:
          'md:hidden transition-all duration-300 ease-in-out ${_isMenuOpen ? 'max-h-96 opacity-100' : 'max-h-0 opacity-0 overflow-hidden'}',
      attributes: {
        'aria-hidden': (!_isMenuOpen).toString(),
      },
      [
        div(
          classes:
              'px-4 pt-2 pb-4 space-y-1 bg-white/95 dark:bg-gray-900/95 backdrop-blur-sm border-t border-gray-200 dark:border-gray-700 theme-transition',
          [
            for (var entry in SiteConfig.navLinks.entries)
              _buildMobileNavLink(entry.key, entry.value, activePath),
          ],
        ),
      ],
    );
  }

  Component _buildMobileNavLink(String label, String href, String activePath) {
    final isActive = activePath == href;

    return a(
      classes:
          'block px-4 py-3 text-base font-medium rounded-lg transition-all duration-200 ${isActive ? 'text-purple-500 bg-purple-50 dark:bg-purple-500/10 border-l-4 border-purple-500' : 'text-gray-700 dark:text-gray-300 hover:text-purple-500 hover:bg-purple-50 dark:hover:bg-purple-500/10 theme-transition active:bg-purple-100 dark:active:bg-purple-500/20'}',
      href: href,
      events: {
        'click': (e) => setState(() => _isMenuOpen = false),
      },
      [text(label)],
    );
  }
}

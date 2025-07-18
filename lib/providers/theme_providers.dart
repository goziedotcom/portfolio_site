import 'package:jaspr/jaspr.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:universal_web/web.dart';

enum ThemeMode {
  light,
  dark,
  system,
}

class ThemeNotifier extends StateNotifier<ThemeMode> {
  // Store the media query listener for cleanup
  dynamic _mediaQueryListener;
  bool _isInitialized = false;

  ThemeNotifier() : super(ThemeMode.system) {
    // Only initialize on client-side
    // if (kIsWeb) {
    //   _initializeClientSide();
    // }
  }

  void _initializeClientSide() {
    if (_isInitialized) return;
    _isInitialized = true;

    // Load saved theme or default to system
    final savedTheme = window.localStorage.getItem('theme');
    if (savedTheme != null && savedTheme.isNotEmpty) {
      final loadedTheme = ThemeMode.values.firstWhere(
        (mode) => mode.name == savedTheme,
        orElse: () => ThemeMode.system,
      );
      state = loadedTheme;
    }

    _updateThemeClass();

    if (state == ThemeMode.system) {
      _setupMediaQueryListener();
    }
  }

  void _setupMediaQueryListener() {
    if (!kIsWeb || !_isInitialized) return;

    final darkModeQuery = window.matchMedia('(prefers-color-scheme: dark)');

    // Create a callback function
    void handleMediaQueryChange(dynamic event) {
      if (mounted && state == ThemeMode.system) {
        _updateThemeClass();
      }
    }

    // Store the listener for cleanup
    _mediaQueryListener = handleMediaQueryChange;

    // Add the event listener
    darkModeQuery.addEventListener('change', _mediaQueryListener);
  }

  void _removeMediaQueryListener() {
    if (!kIsWeb || _mediaQueryListener == null) return;

    final darkModeQuery = window.matchMedia('(prefers-color-scheme: dark)');
    darkModeQuery.removeEventListener('change', _mediaQueryListener);
    _mediaQueryListener = null;
  }

  void _saveTheme(ThemeMode mode) {
    if (!kIsWeb || !_isInitialized) return;
    window.localStorage.setItem('theme', mode.name);
  }

  bool get isDark {
    if (!kIsWeb || !_isInitialized) {
      // Default to light on server or before initialization
      return false;
    }

    if (state == ThemeMode.system) {
      final darkModeQuery = window.matchMedia('(prefers-color-scheme: dark)');
      return darkModeQuery.matches;
    }
    return state == ThemeMode.dark;
  }

  void _updateThemeClass() {
    if (!kIsWeb || !_isInitialized) return;

    final documentElement = document.documentElement;
    if (documentElement != null) {
      final classList = documentElement.classList;
      if (isDark) {
        classList.add('dark');
      } else {
        classList.remove('dark');
      }
    }
  }

  void setTheme(ThemeMode mode) {
    // Remove existing listener if switching away from system mode
    if (state == ThemeMode.system && mode != ThemeMode.system) {
      _removeMediaQueryListener();
    }

    state = mode;
    _saveTheme(mode);
    _updateThemeClass();

    // Set up listener if switching to system mode
    if (mode == ThemeMode.system && kIsWeb && _isInitialized) {
      _setupMediaQueryListener();
    }
  }

  void toggleTheme() {
    final wasInDarkMode = isDark;

    if (state == ThemeMode.system) {
      // If in system mode, switch to the opposite of current appearance
      state = wasInDarkMode ? ThemeMode.light : ThemeMode.dark;
    } else {
      // If in explicit mode, toggle between light and dark
      state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    }

    _saveTheme(state);
    _updateThemeClass();

    // Remove system listener since we're no longer in system mode
    if (kIsWeb) {
      _removeMediaQueryListener();
    }
  }

  @override
  void dispose() {
    _removeMediaQueryListener();
    super.dispose();
  }
}

// Provider for the theme mode state
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

final isDarkProvider = Provider<bool>((ref) {
  if (!kIsWeb) {
    // Always return false on server to ensure consistent SSR
    return false;
  }

  final themeNotifier = ref.watch(themeProvider.notifier);
  ref.watch(themeProvider); // Watch the state to trigger rebuilds
  return themeNotifier.isDark;
});

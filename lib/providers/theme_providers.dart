import 'dart:async';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;
import 'package:jaspr_riverpod/jaspr_riverpod.dart';

enum ThemeMode {
  light,
  dark,
  system,
}

class ThemeNotifier extends StateNotifier<ThemeMode> {
  StreamSubscription<web.MediaQueryListEvent>? _mediaQuerySubscription;

  ThemeNotifier() : super(_getInitialTheme()) {
    _updateThemeClass();
    if (state == ThemeMode.system) {
      _setupSystemListener();
    }
  }

  @override
  void dispose() {
    _mediaQuerySubscription?.cancel();
    super.dispose();
  }

  // ============================================================================
  // INITIALIZATION - READ DOM STATE
  // ============================================================================

  static ThemeMode _getInitialTheme() {
  if (!kIsWeb) return ThemeMode.system;
  // Check if inline script added 'dark' class
  final isDarkApplied = web.document.documentElement?.classList.contains('dark') ?? true;
  
  // Read the saved preference
  final saved = web.window.localStorage['theme'];
  
  // Return the theme that matches current DOM state
  if (saved == 'ThemeMode.dark') return ThemeMode.dark;
  if (saved == 'ThemeMode.light') return ThemeMode.light;
  
  // If system theme, check what's actually applied
  return isDarkApplied ? ThemeMode.dark : ThemeMode.system;
}

  // ============================================================================
  // THEME LOGIC
  // ============================================================================

  bool get isDark {
    if (!kIsWeb) return false;
    
    switch (state) {
      case ThemeMode.dark:
        return true;
      case ThemeMode.light:
        return false;
      case ThemeMode.system:
        try {
          return web.window.matchMedia('(prefers-color-scheme: dark)').matches;
        } catch (e) {
          return false;
        }
    }
  }

  void _updateThemeClass() {
    if (!kIsWeb) return;
    
    try {
      final html = web.document.documentElement;
      if (html != null) {
        if (isDark) {
          html.classList.add('dark');
        } else {
          html.classList.remove('dark');
        }
      }
    } catch (e) {
      // Fail silently
    }
  }

  void _saveTheme() {
    if (!kIsWeb) return;
    
    try {
      web.window.localStorage['theme'] = state.toString();
    } catch (e) {
      // Fail silently
    }
  }

  // ============================================================================
  // SYSTEM THEME LISTENER
  // ============================================================================

  void _setupSystemListener() {
    if (!kIsWeb) return;
    
    try {
      final mediaQuery = web.window.matchMedia('(prefers-color-scheme: dark)');
      _mediaQuerySubscription = web.EventStreamProvider<web.MediaQueryListEvent>('change')
          .forTarget(mediaQuery)
          .listen((_) {
        if (state == ThemeMode.system) {
          _updateThemeClass();
          // Force state update to trigger rebuilds
          state = ThemeMode.system;
        }
      });
    } catch (e) {
      // Fail silently
    }
  }

  void _cleanupSystemListener() {
    _mediaQuerySubscription?.cancel();
    _mediaQuerySubscription = null;
  }

  // ============================================================================
  // PUBLIC API
  // ============================================================================

  void setTheme(ThemeMode mode) {
    if (state == ThemeMode.system && mode != ThemeMode.system) {
      _cleanupSystemListener();
    }
    
    state = mode;
    _saveTheme();
    _updateThemeClass();
    
    if (mode == ThemeMode.system) {
      _setupSystemListener();
    }
  }

  void toggleTheme() {
    if (state == ThemeMode.system) {
      // Switch from system to explicit mode
      setTheme(isDark ? ThemeMode.light : ThemeMode.dark);
    } else {
      // Toggle between light and dark
      setTheme(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
    }
  }
}

// ============================================================================
// PROVIDERS
// ============================================================================

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

final isDarkProvider = Provider<bool>((ref) {
  final notifier = ref.watch(themeProvider.notifier);
  ref.watch(themeProvider); // Watch state changes
  return notifier.isDark;
});
// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/jaspr.dart';
import 'package:portfolio_site/components/contact/contact_form.dart' as prefix0;
import 'package:portfolio_site/components/home/client/scroll_to_next.dart'
    as prefix1;
import 'package:portfolio_site/components/projects/projects_view.dart'
    as prefix2;
import 'package:portfolio_site/components/header.dart' as prefix3;
import 'package:portfolio_site/components/scroll_to_top_button.dart' as prefix4;

/// Default [JasprOptions] for use with your jaspr project.
///
/// Use this to initialize jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'jaspr_options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultJasprOptions,
///   );
///
///   runApp(...);
/// }
/// ```
JasprOptions get defaultJasprOptions => JasprOptions(
  clients: {
    prefix0.ContactFormCard: ClientTarget<prefix0.ContactFormCard>(
      'components/contact/contact_form',
    ),

    prefix3.Header: ClientTarget<prefix3.Header>('components/header'),

    prefix1.ScrollToNextSection: ClientTarget<prefix1.ScrollToNextSection>(
      'components/home/client/scroll_to_next',
    ),

    prefix2.ProjectsView: ClientTarget<prefix2.ProjectsView>(
      'components/projects/projects_view',
      params: _prefix2ProjectsView,
    ),

    prefix4.ScrollToTopButton: ClientTarget<prefix4.ScrollToTopButton>(
      'components/scroll_to_top_button',
      params: _prefix4ScrollToTopButton,
    ),
  },
  styles: () => [],
);

Map<String, dynamic> _prefix2ProjectsView(prefix2.ProjectsView c) => {
  'projects': c.projects.map((i) => i.toJson()).toList(),
};
Map<String, dynamic> _prefix4ScrollToTopButton(prefix4.ScrollToTopButton c) => {
  'showAtViewportFraction': c.showAtViewportFraction,
  'scrollDurationMs': c.scrollDurationMs,
  'customClasses': c.customClasses,
};

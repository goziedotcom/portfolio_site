// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/jaspr.dart';
import 'package:portfolio_site/components/header.dart' as prefix0;
import 'package:portfolio_site/pages/contact.dart' as prefix1;
import 'package:portfolio_site/pages/home.dart' as prefix2;

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
    prefix0.Header: ClientTarget<prefix0.Header>('components/header'),

    prefix1.ContactPage: ClientTarget<prefix1.ContactPage>('pages/contact'),

    prefix2.Home: ClientTarget<prefix2.Home>('pages/home'),
  },
  styles: () => [],
);

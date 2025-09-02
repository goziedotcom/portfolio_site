// The entrypoint for the **client** environment.
//
// This file is compiled to javascript and executed in the browser.

// Client-specific jaspr import.
import 'package:jaspr/browser.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:portfolio_site/app.dart';

void main() {
  // Attaches the [App] component to the <body> of the page.
  runApp(ProviderScope(child: App()));
}

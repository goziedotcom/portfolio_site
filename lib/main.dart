// The entrypoint for the **server** environment.
//
// The [main] method will only be executed on the server during pre-rendering.
// To run code on the client, use the @client annotation.

// Server-specific jaspr import.
import 'package:jaspr/server.dart';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import 'package:portfolio_site/config/site_config.dart';

// Imports the [App] component.
import 'app.dart';

// This file is generated automatically by Jaspr, do not remove or edit.
import 'jaspr_options.dart';

void main() {
  // Initializes the server environment with the generated default options.
  Jaspr.initializeApp(
    options: defaultJasprOptions,
  );

  // Starts the app.
  //
  // [Document] renders the root document structure (<html>, <head> and <body>)
  // with the provided parameters and components.
  runApp(Document(
    title: SiteConfig.siteName,
    // Meta tags
    meta: SiteConfig.getMetaData,
    head: [
      ...SiteConfig.faviconLinks, // Favicon links

      // JS and CSS files
      script(src: "js/init.js", async: false, []),
      script(src: 'js/custom_scroll.js', []),
      link(href: 'styles.css', rel: 'stylesheet'),
      link(href: SiteConfig.siteUrl, rel: 'canonical'), // Canonical Site URL
    ],
    body: ProviderScope(
      parent: container,
      child: const App(),
    ),
  ));
}

final container = ProviderContainer();

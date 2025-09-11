import 'package:jaspr/jaspr.dart';

class LazyComponent extends StatefulComponent {
  final Future<Component> Function() loader;
  final Component? placeholder;
  final bool fullScreen;

  const LazyComponent({
    required this.loader,
    this.placeholder,
    this.fullScreen = true,
    super.key,
  });

  @override
  State<LazyComponent> createState() => _LazyComponentState();
}

class _LazyComponentState extends State<LazyComponent> {
  late Future<Component> _future;

  @override
  void initState() {
    super.initState();
    _future = component.loader();
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield StreamBuilder<Component>(
      stream: _future.asStream(),
      builder: (context, snapshot) sync* {
        if (snapshot.hasData) {
          yield snapshot.data!;
        } else {
          yield component.placeholder ?? _buildDefaultLoader();
        }
      },
    );
  }

  Component _buildDefaultLoader() {
    // Use full screen classes if fullScreen is true
    final containerClasses = component.fullScreen
        ? 'min-h-screen w-full flex flex-col justify-center items-center bg-background'
        : 'flex flex-col justify-center items-center min-h-[50vh] p-8';

    return div(
      classes: containerClasses,
      [
        // Main loader container with glass morphism effect
        div(
          classes: '''
            relative p-8 rounded-2xl
            bg-card border border-border
            backdrop-blur-sm shadow-lg
            animate-fade-in
          ''',
          [
            // Outer rotating ring with gradient
            div(
              classes: '''
                relative w-16 h-16 rounded-full
                animate-spin
              ''',
              [
                // Gradient ring
                div(
                  classes: '''
                    w-full h-full rounded-full
                    border-4 border-transparent
                    bg-gradient-conic from-primary via-accent to-primary-glow
                    animate-spin
                  ''',
                  styles: Styles(raw: {
                    'background':
                        'conic-gradient(from 0deg, hsl(var(--primary)), hsl(var(--accent)), hsl(var(--primary-glow)), hsl(var(--primary)))',
                    'mask': 'radial-gradient(circle at center, transparent 6px, black 8px)',
                    '-webkit-mask': 'radial-gradient(circle at center, transparent 6px, black 8px)',
                  }),
                  [],
                ),
                // Inner circle
                div(
                  classes: '''
                    absolute inset-2 rounded-full
                    bg-card border-2 border-border
                  ''',
                  [],
                ),
              ],
            ),

            // Center pulsing dot
            div(
              classes: '''
                absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2
                w-3 h-3 rounded-full
                bg-primary animate-pulse
                shadow-sm
              ''',
              styles: Styles(raw: {
                'box-shadow': '0 0 12px hsl(var(--primary) / 0.6)',
              }),
              [],
            ),

            // Floating particles effect
            ...List.generate(
                3,
                (index) => div(
                      classes: '''
                absolute w-1 h-1 rounded-full
                bg-accent animate-float
              ''',
                      styles: Styles(raw: {
                        'left': '${20 + (index * 20)}%',
                        'top': '${15 + (index * 10)}%',
                        'animation-delay': '${index * 0.5}s',
                        'box-shadow': '0 0 4px hsl(var(--accent) / 0.8)',
                      }),
                      [],
                    )),
          ],
        ),

        // Loading text with typing effect
        div(
          classes: '''
            mt-6 text-lg font-semibold
            text-foreground/80
            animate-pulse
          ''',
          [text('Loading')],
        ),

        // Subtitle with fade animation
        div(
          classes: '''
            mt-2 text-sm
            text-muted-foreground
            animate-fade-in-delay
          ''',
          [text('Preparing content...')],
        ),

        // Progress dots
        div(
          classes: 'flex space-x-2 mt-4',
          [
            ...List.generate(
                3,
                (index) => div(
                      classes: '''
                w-2 h-2 rounded-full
                bg-primary/40 animate-bounce
              ''',
                      styles: Styles(raw: {
                        'animation-delay': '${index * 0.2}s',
                      }),
                      [],
                    )),
          ],
        ),
      ],
    );
  }
}

// Alternative: Create a custom placeholder for full-screen loading
Component buildFullScreenLoader() {
  return div(
    classes: 'min-h-screen w-full flex flex-col justify-center items-center bg-background',
    [
      // Main loader container with glass morphism effect
      div(
        classes: '''
          relative p-8 rounded-2xl
          bg-card border border-border
          backdrop-blur-sm shadow-lg
          animate-fade-in
        ''',
        [
          // Outer rotating ring with gradient
          div(
            classes: '''
              relative w-16 h-16 rounded-full
              animate-spin
            ''',
            [
              // Gradient ring
              div(
                classes: '''
                  w-full h-full rounded-full
                  border-4 border-transparent
                  bg-gradient-conic from-primary via-accent to-primary-glow
                  animate-spin
                ''',
                styles: Styles(raw: {
                  'background':
                      'conic-gradient(from 0deg, hsl(var(--primary)), hsl(var(--accent)), hsl(var(--primary-glow)), hsl(var(--primary)))',
                  'mask': 'radial-gradient(circle at center, transparent 6px, black 8px)',
                  '-webkit-mask': 'radial-gradient(circle at center, transparent 6px, black 8px)',
                }),
                [],
              ),
              // Inner circle
              div(
                classes: '''
                  absolute inset-2 rounded-full
                  bg-card border-2 border-border
                ''',
                [],
              ),
            ],
          ),

          // Center pulsing dot
          div(
            classes: '''
              absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2
              w-3 h-3 rounded-full
              bg-primary animate-pulse
              shadow-sm
            ''',
            styles: Styles(raw: {
              'box-shadow': '0 0 12px hsl(var(--primary) / 0.6)',
            }),
            [],
          ),

          // Floating particles effect
          ...List.generate(
              3,
              (index) => div(
                    classes: '''
              absolute w-1 h-1 rounded-full
              bg-accent animate-float
            ''',
                    styles: Styles(raw: {
                      'left': '${20 + (index * 20)}%',
                      'top': '${15 + (index * 10)}%',
                      'animation-delay': '${index * 0.5}s',
                      'box-shadow': '0 0 4px hsl(var(--accent) / 0.8)',
                    }),
                    [],
                  )),
        ],
      ),

      // Loading text with typing effect
      div(
        classes: '''
          mt-6 text-lg font-semibold
          text-foreground/80
          animate-pulse
        ''',
        [text('Loading')],
      ),

      // Subtitle with fade animation
      div(
        classes: '''
          mt-2 text-sm
          text-muted-foreground
          animate-fade-in-delay
        ''',
        [text('Preparing content...')],
      ),

      // Progress dots
      div(
        classes: 'flex space-x-2 mt-4',
        [
          ...List.generate(
              3,
              (index) => div(
                    classes: '''
              w-2 h-2 rounded-full
              bg-primary/40 animate-bounce
            ''',
                    styles: Styles(raw: {
                      'animation-delay': '${index * 0.2}s',
                    }),
                    [],
                  )),
        ],
      ),
    ],
  );
}

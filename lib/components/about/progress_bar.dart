import 'package:jaspr/jaspr.dart';

// Progress component for skills
class ProgressBar extends StatelessComponent {
  final int value;
  final String? additionalClasses;

  const ProgressBar({
    super.key,
    required this.value,
    this.additionalClasses,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes: 'w-full bg-secondary rounded-full h-2 ${additionalClasses ?? ''}',
      [
        div(
          classes: 'h-2 rounded-full transition-all duration-500 ease-out',
          styles: Styles(
            raw: {
              'width': '${value}%',
              'background': 'var(--gradient-primary)',
            },
          ),
          [],
        ),
      ],
    );
  }
}

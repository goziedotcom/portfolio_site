import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart' as lucide;
import 'package:portfolio_site/components/ui/button.dart';

class HeroCTAButtons extends StatelessComponent {
  const HeroCTAButtons();

  @override
  Component build(BuildContext context) {
    return div(classes: 'flex flex-wrap gap-4', [
      // Primary CTA - Download CV
      TButton(text: 'Download CV', icon: lucide.Download.new, onClick: () {}),
      TButton.outline(
        text: 'View Projects',
        subtleBorder: false,
        onClick: () {},
      ),
    ]);
  }
}

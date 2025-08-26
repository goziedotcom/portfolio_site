import 'package:jaspr/jaspr.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart' show listFilter;
import 'package:portfolio_site/components/projects/other_project.dart';
import 'package:portfolio_site/components/ui/button.dart';
import 'package:portfolio_site/components/ui/icon.dart';
import 'package:portfolio_site/models/project_model.dart';

@client
class ProjectsView extends StatefulComponent {
  const ProjectsView({required this.projects, super.key});
  final List<Project> projects;

  @override
  State<ProjectsView> createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
  String _selectedCategory = 'All';

  List<Project> get _filteredProjects =>
      component.projects.getProjectsByCategory(_selectedCategory);

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes: 'py-8', // Reduced padding since parent handles spacing
      [
        div(
          classes: 'container mx-auto px-4 sm:px-6 lg:px-8 max-w-7xl',
          [
            // Filter Section
            _buildFilterSection(component.projects.availableCategories),

            // Projects Grid
            _buildProjectsGrid(),
          ],
        ),
      ],
    );
  }

  Component _buildFilterSection(List<String> categories) {
    return div(
      classes: 'mb-8',
      [
        div(
          classes: 'flex items-center space-x-4 mb-6',
          [
            TIcon(
              lucideIcon: listFilter,
              theme: IconTheme.monochrome,
            ),
            span(
              classes: 'font-medium',
              [text('Filter by category:')],
            ),
          ],
        ),
        div(
          classes: 'flex flex-wrap gap-3',
          [
            for (String category in categories) _buildFilterButton(category),
          ],
        ),
      ],
    );
  }

  Component _buildFilterButton(String category) {
    final isSelected = _selectedCategory == category;

    if (isSelected) {
      // Selected state - uses primary variant with gradient background
      return TButton.primary(
        text: category,
        size: ButtonSize.small,
        customClasses: 'px-4 py-2',
      );
    } else {
      // Unselected state - uses outline variant
      return TButton.outline(
        text: category,
        size: ButtonSize.small,
        customClasses: 'px-4 py-2',
        onClick: () => _selectCategory(category),
      );
    }
  }

  Component _buildProjectsGrid() {
    return div(
      classes: 'grid md:grid-cols-2 lg:grid-cols-3 gap-8',
      [
        for (final project in _filteredProjects)
          OtherProjectCard(
            project: project,
            index: _filteredProjects.indexOf(project),
          ),
      ],
    );
  }
}

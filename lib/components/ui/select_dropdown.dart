import 'dart:async';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_lucide/generated_icons/chevron_down.dart';
import 'package:portfolio_site/components/ui/icon.dart';
import 'package:universal_web/web.dart' as web;

// ============================================================================
// ROBUST SELECT COMPONENT
// ============================================================================

class TSelectField<T> extends StatefulComponent {
  final String id;
  final String labelText;
  final T? initialValue;
  final String? name;
  final List<SelectOption<T>> options;
  final Function(T?)? onChanged;
  final bool isRequired;
  final bool disabled;
  final String? placeholder;
  final String? errorMessage;

  const TSelectField({
    required this.id,
    required this.labelText,
    this.initialValue,
    required this.options,
    this.onChanged,
    this.isRequired = true,
    this.disabled = false,
    this.name,
    this.placeholder,
    this.errorMessage,
    super.key,
  });

  @override
  State<TSelectField<T>> createState() => _TSelectFieldComponentState<T>();
}

class _TSelectFieldComponentState<T> extends State<TSelectField<T>> {
  bool _isDropdownOpen = false;
  T? _currentValue; // Internal state for the selected value
  StreamSubscription<web.MouseEvent>? _clickSubscription;
  StreamSubscription<web.Event>? _resetSubscription;

  @override
  void initState() {
    super.initState();
    _currentValue = component.initialValue; // Initialize with provided initial value
    // Only set up listeners on the client side
    if (kIsWeb) {
      _setupFormResetListener();
    }
  }

  @override
  void dispose() {
    _cleanupListeners();
    super.dispose();
  }

  // ============================================================================
  // EVENT LISTENERS
  // ============================================================================

  void _setupFormResetListener() {
    if (!kIsWeb) return; // Guard against server-side execution

    _resetSubscription = web.EventStreamProvider<web.Event>('formReset')
        .forTarget(web.window)
        .listen((_) => _resetDropdown());
  }

  void _setupClickOutsideListener() {
    if (!kIsWeb) return; // Guard against server-side execution

    _clickSubscription =
        web.EventStreamProviders.clickEvent.forTarget(web.document).listen(_handleOutsideClick);
  }

  void _cleanupListeners() {
    _clickSubscription?.cancel();
    _resetSubscription?.cancel();
  }

  // ============================================================================
  // EVENT HANDLERS
  // ============================================================================

  void _handleOutsideClick(web.MouseEvent event) {
    final target = event.target as web.Element?;
    final container = web.document.getElementById('${component.id}-container');

    if (container != null && target != null && !container.contains(target)) {
      _closeDropdown();
    }
  }

  void _resetDropdown() {
    setState(() {
      _currentValue = null;
    });

    component.onChanged?.call(null); // Notify parent of reset
    if (_isDropdownOpen) _closeDropdown();
  }

  void _toggleDropdown() {
    if (component.disabled) return;

    setState(() => _isDropdownOpen = !_isDropdownOpen);

    if (_isDropdownOpen) {
      _setupClickOutsideListener();
    } else {
      _clickSubscription?.cancel();
    }
  }

  void _closeDropdown() {
    setState(() => _isDropdownOpen = false);
    _clickSubscription?.cancel();
  }

  void _selectOption(T value) {
    setState(() {
      _currentValue = value; // Update internal state immediately
    });
    component.onChanged?.call(value); // Notify parent of change
    _closeDropdown();
  }

  // ============================================================================
  // HELPERS
  // ============================================================================

  String get _displayLabel {
    if (_currentValue == null) return component.placeholder ?? '';

    return component.options
        .firstWhere(
          (opt) => opt.value == _currentValue,
          orElse: () => SelectOption<T>(value: _currentValue!, label: _currentValue.toString()),
        )
        .label;
  }

  String get _triggerClasses => [
        'custom-select-trigger',
        if (component.disabled) 'disabled opacity-50 cursor-not-allowed',
      ].join(' ');

  Map<String, String> get _triggerAttributes => {
        'role': 'button',
        'tabindex': component.disabled ? '-1' : '0',
        'aria-haspopup': 'listbox',
        'aria-expanded': _isDropdownOpen.toString(),
        if (component.isRequired) 'aria-required': 'true',
        if (component.errorMessage != null) 'aria-describedby': '${component.id}-error',
      };

  // ============================================================================
  // BUILD METHODS
  // ============================================================================

  Component _buildHiddenInput() {
    if (component.name == null) return div([]);

    return input(
      type: InputType.hidden,
      name: component.name!,
      value: _currentValue?.toString() ?? '',
      id: '${component.id}-hidden',
      [],
    );
  }

  Component _buildLabel() {
    return label(
      attributes: {'for': component.id},
      classes: 'block text-sm font-medium text-foreground',
      [text('${component.labelText}${component.isRequired ? ' *' : ''}')],
    );
  }

  Component _buildTrigger() {
    return div(
      id: component.id,
      classes: _triggerClasses,
      attributes: _triggerAttributes,
      events: events(onClick: _toggleDropdown),
      [
        span(
          classes: _currentValue == null && component.placeholder != null ? 'placeholder-text' : '',
          [text(_displayLabel)],
        ),
        div(
          classes: 'select-arrow',
          [
            TIcon(
              lucideIcon: chevronDown,
              theme: IconTheme.monochrome,
              width: const Unit.pixels(16),
              height: const Unit.pixels(16),
            )
          ],
        ),
      ],
    );
  }

  Component _buildDropdownList() {
    if (!_isDropdownOpen) return div([]);

    return ul(
      classes: 'custom-select-list',
      attributes: {'role': 'listbox', 'tabindex': '-1'},
      [
        // Placeholder option
        if (component.placeholder != null && _currentValue == null) _buildPlaceholderOption(),

        // Regular options
        ...component.options.map(_buildOption),
      ],
    );
  }

  Component _buildPlaceholderOption() {
    return li(
      classes: 'custom-select-option disabled-option selected',
      attributes: {
        'role': 'option',
        'aria-selected': 'true',
        'aria-disabled': 'true',
      },
      [text(component.placeholder!)],
    );
  }

  Component _buildOption(SelectOption<T> option) {
    final isSelected = option.value == _currentValue;

    return li(
      classes: [
        'custom-select-option',
        if (isSelected) 'selected',
        if (option.disabled) 'disabled-option',
      ].join(' '),
      attributes: {
        'role': 'option',
        'aria-selected': isSelected.toString(),
        if (option.disabled) 'aria-disabled': 'true',
        'tabindex': option.disabled ? '-1' : '0',
      },
      events: option.disabled ? null : events(onClick: () => _selectOption(option.value)),
      [text(option.label)],
    );
  }

  Component _buildErrorMessage() {
    if (component.errorMessage == null) return div([]);

    return div(
      id: '${component.id}-error',
      classes: 'text-sm text-destructive',
      [text(component.errorMessage!)],
    );
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes: 'space-y-2',
      [
        _buildHiddenInput(),
        _buildLabel(),
        div(
          id: '${component.id}-container',
          classes: 'relative',
          [
            _buildTrigger(),
            _buildDropdownList(),
          ],
        ),
        _buildErrorMessage(),
      ],
    );
  }
}

// ============================================================================
// HELPER CLASSES
// ============================================================================

class SelectOption<T> {
  final T value;
  final String label;
  final bool disabled;

  const SelectOption({
    required this.value,
    required this.label,
    this.disabled = false,
  });
}

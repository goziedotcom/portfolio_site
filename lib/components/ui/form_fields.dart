// ============================================================================
// ROBUST JASPR FORM FIELD COMPONENTS
// ============================================================================

import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

Component TFormField({
  required String id,
  required String labelText,
  required String placeholder,
  String type = 'text',
  String? value,
  Function(String?)? onChanged,
  bool isRequired = false,
  bool disabled = false,
  String? autocomplete,
  int? maxLength,
  int? minLength,
  String? pattern,
  String? errorMessage,
}) {
  return div(
    classes: 'space-y-2',
    [
      // Label
      label(
        attributes: {'for': id},
        classes: 'block text-sm font-medium text-foreground',
        [text('$labelText${isRequired ? ' *' : ''}')],
      ),

      // Input field
      input(
        id: id,
        name: id,
        type: InputType.values.firstWhere(
          (t) => t.name == type,
          orElse: () => InputType.text,
        ),
        classes:
            'w-full px-4 py-3 rounded-lg border border-border bg-input text-foreground placeholder:text-muted-foreground transition-all duration-300 focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent',
        // value: value,
        disabled: disabled,
        attributes: {
          'placeholder': placeholder,
          if (isRequired) 'required': 'required',
          if (autocomplete != null) 'autocomplete': autocomplete,
          if (maxLength != null) 'maxlength': '$maxLength',
          if (minLength != null) 'minlength': '$minLength',
          if (pattern != null) 'pattern': pattern,
          if (errorMessage != null) 'aria-describedby': '${id}-error',
        },
        events: events(
          onInput: (String? inputValue) {
            onChanged?.call(inputValue);
          },
        ),
        [],
      ),

      // Error message (if provided)
      if (errorMessage != null)
        div(
          id: '${id}-error',
          classes: 'text-sm text-destructive',
          [text(errorMessage)],
        ),
    ],
  );
}

// ============================================================================
// ROBUST TEXTAREA COMPONENT
// ============================================================================

class TTextAreaField extends StatefulComponent {
  final String id;
  final String labelText;
  final String placeholder;
  final String initialValue;
  final Function(String?)? onChanged;
  final String? name;
  final bool isRequired;
  final bool disabled;
  final int rows;
  final int? maxLength;
  final int? maxWords;
  final int? minLength;
  final String? errorMessage;

  const TTextAreaField({
    required this.id,
    required this.labelText,
    required this.placeholder,
    this.initialValue = '',
    this.onChanged,
    this.name,
    this.isRequired = false,
    this.disabled = false,
    this.rows = 4,
    this.maxLength,
    this.maxWords,
    this.minLength,
    this.errorMessage,
    super.key,
  });

  @override
  State<TTextAreaField> createState() => _TTextAreaFieldState();
}

class _TTextAreaFieldState extends State<TTextAreaField> {
  String _currentValue = '';
  StreamSubscription<web.Event>? _resetSubscription;

  @override
  void initState() {
    super.initState();
    _currentValue = component.initialValue;
    // Only set up listeners on the client side
    if (kIsWeb) {
      _setupFormResetListener();
    }
  }

  @override
  void dispose() {
    _resetSubscription?.cancel();
    super.dispose();
  }

  // ============================================================================
  // EVENT LISTENERS
  // ============================================================================

  void _setupFormResetListener() {
    if (!kIsWeb) return;

    _resetSubscription = web.EventStreamProvider<web.Event>('formReset')
        .forTarget(web.window)
        .listen((_) => _resetTextArea());
  }

  // ============================================================================
  // EVENT HANDLERS
  // ============================================================================

  void _resetTextArea() {
    setState(() {
      _currentValue = '';
    });
    component.onChanged?.call('');
  }

  void _handleInput(String newValue) {
    // If maxWords is set, check word count before updating
    if (component.maxWords != null) {
      final wordCount = newValue.trim().isEmpty ? 0 : newValue.trim().split(RegExp(r'\s+')).length;

      // If over word limit and user added a space (completed a word), reject
      if (wordCount > component.maxWords! && newValue.endsWith(' ')) {
        return; // Don't allow completing new words beyond limit
      }

      // If way over limit (like pasting), truncate to word boundary
      if (wordCount > component.maxWords! + 1) {
        final words = newValue.trim().split(RegExp(r'\s+'));
        final allowedWords = words.take(component.maxWords!).join(' ');
        newValue = allowedWords;
      }
    }

    setState(() {
      _currentValue = newValue;
    });
    component.onChanged?.call(newValue);
  }

  // ============================================================================
  // HELPERS
  // ============================================================================

  int get _wordCount {
    if (_currentValue.trim().isEmpty) return 0;
    return _currentValue.trim().split(RegExp(r'\s+')).length;
  }

  String get _countDisplay {
    final parts = <String>[];

    if (component.maxLength != null) {
      parts.add('${_currentValue.length}/${component.maxLength} characters');
    }

    if (component.maxWords != null) {
      parts.add('$_wordCount/${component.maxWords} words');
    }

    return parts.join(' • ');
  }

  bool get _isOverLimit {
    if (component.maxLength != null && _currentValue.length > component.maxLength!) {
      return true;
    }
    if (component.maxWords != null && _wordCount > component.maxWords!) {
      return true;
    }
    return false;
  }

  // ============================================================================
  // BUILD METHODS
  // ============================================================================

  Component _buildLabel() {
    return label(
      attributes: {'for': component.id},
      classes: 'block text-sm font-medium text-foreground',
      [text('${component.labelText}${component.isRequired ? ' *' : ''}')],
    );
  }

  Component _buildTextArea() {
    return textarea(
      id: component.id,
      name: component.name ?? component.id,
      classes:
          'w-full px-4 py-3 rounded-lg border border-border bg-input text-foreground placeholder:text-muted-foreground transition-all duration-300 focus:outline-none focus:ring-2 focus:ring-ring focus:border-transparent resize-y',
      placeholder: component.placeholder,
      required: component.isRequired,
      disabled: component.disabled,
      rows: component.rows,
      minLength: component.minLength,
      attributes: {
        if (component.maxLength != null) 'maxlength': '${component.maxLength}',
        if (component.errorMessage != null) 'aria-describedby': '${component.id}-error',
      },
      events: events(
        onInput: _handleInput,
      ),
      [],
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

  Component _buildCountDisplay() {
    if (component.maxLength == null && component.maxWords == null) {
      return div([]);
    }

    return div(
      classes: [
        'text-xs text-right transition-colors',
        if (_isOverLimit) 'text-destructive' else 'text-muted-foreground',
      ].join(' '),
      [text(_countDisplay)],
    );
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes: 'space-y-2',
      [
        _buildLabel(),
        _buildTextArea(),
        _buildErrorMessage(),
        _buildCountDisplay(),
      ],
    );
  }
}

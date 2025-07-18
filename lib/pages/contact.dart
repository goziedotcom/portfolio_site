import 'package:jaspr/jaspr.dart';
// ============================================================================
// CONTACT MODELS
// ============================================================================

class ContactMethod {
  final String icon;
  final String title;
  final String description;
  final String action;
  final String actionText;
  final ContactType type;

  const ContactMethod({
    required this.icon,
    required this.title,
    required this.description,
    required this.action,
    required this.actionText,
    required this.type,
  });
}

enum ContactType {
  email,
  social,
  professional,
  messaging,
}

class ContactFormData {
  final String name;
  final String email;
  final String subject;
  final String message;
  final ContactReason reason;

  const ContactFormData({
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    required this.reason,
  });
}

enum ContactReason {
  projectInquiry,
  collaboration,
  consultation,
  hiring,
  question,
  other,
}

// ============================================================================
// CONTACT DATA
// ============================================================================

class ContactData {
  static final List<ContactMethod> methods = [
    ContactMethod(
      icon: '📧',
      title: 'Email',
      description: 'Send me an email for project inquiries, collaborations, or general questions.',
      action: 'mailto:hello@gozieihejirika.com',
      actionText: 'hello@gozieihejirika.com',
      type: ContactType.email,
    ),
    ContactMethod(
      icon: '💼',
      title: 'LinkedIn',
      description: 'Connect with me on LinkedIn for professional networking and opportunities.',
      action: 'https://linkedin.com/in/gozieihejirika',
      actionText: 'Connect on LinkedIn',
      type: ContactType.professional,
    ),
    ContactMethod(
      icon: '🐙',
      title: 'GitHub',
      description: 'Check out my code, contribute to projects, or start a discussion.',
      action: 'https://github.com/gozieihejirika',
      actionText: 'View GitHub Profile',
      type: ContactType.professional,
    ),
    ContactMethod(
      icon: '🐦',
      title: 'Twitter/X',
      description: 'Follow me for tech insights, project updates, and web development tips.',
      action: 'https://twitter.com/gozieihejirika',
      actionText: '@gozieihejirika',
      type: ContactType.social,
    ),
    ContactMethod(
      icon: '💬',
      title: 'Discord',
      description: 'Join tech discussions and get quick responses to your questions.',
      action: 'https://discord.com/users/gozie#1234',
      actionText: 'gozie#1234',
      type: ContactType.messaging,
    ),
    ContactMethod(
      icon: '📱',
      title: 'WhatsApp',
      description: 'For urgent project discussions or quick consultations.',
      action: 'https://wa.me/2348123456789',
      actionText: 'Message on WhatsApp',
      type: ContactType.messaging,
    ),
  ];

  static const String locationInfo = 'Nigeria';
  static const String availability = 'Available for freelance projects and collaborations';
  static const String timeZone = 'West Africa Time (UTC+1)';
}

// ============================================================================
// CONTACT PAGE
// ============================================================================

@client
class ContactPage extends StatefulComponent {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String _name = '';
  String _email = '';
  String _subject = '';
  String _message = '';
  ContactReason _reason = ContactReason.projectInquiry;
  bool _isSubmitting = false;
  bool _isSubmitted = false;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes: 'min-h-screen bg-bg-primary theme-transition',
      [
        // Hero Section
        section(
          classes: 'section-container',
          [
            div(
              classes: 'text-center mb-16',
              [
                h1(
                  classes: 'section-title',
                  [text('Get In Touch')],
                ),
                p(
                  classes:
                      'text-xl text-gray-600 dark:text-gray-400 max-w-3xl mx-auto leading-relaxed',
                  [
                    text(
                        'Ready to bring your project to life? Whether you\'re a client with an exciting idea or a fellow developer looking to collaborate, I\'d love to hear from you.')
                  ],
                ),
                div(
                  classes:
                      'mt-8 flex flex-wrap justify-center gap-4 text-sm text-gray-500 dark:text-gray-400',
                  [
                    span(classes: 'flex items-center gap-2', [
                      text('📍'),
                      text(ContactData.locationInfo),
                    ]),
                    span(classes: 'flex items-center gap-2', [
                      text('⏰'),
                      text(ContactData.timeZone),
                    ]),
                    span(classes: 'flex items-center gap-2', [
                      text('✅'),
                      text(ContactData.availability),
                    ]),
                  ],
                ),
              ],
            ),
          ],
        ),

        // Main Content
        section(
          classes: 'pb-20',
          [
            div(
              classes: 'max-w-6xl mx-auto px-8',
              [
                div(
                  classes: 'grid grid-cols-1 lg:grid-cols-2 gap-12',
                  [
                    // Contact Methods
                    _buildContactMethods(),

                    // Contact Form
                    _buildContactForm(),
                  ],
                ),
              ],
            ),
          ],
        ),

        // Quick Contact CTA
        _buildQuickContactCTA(),
      ],
    );
  }

  Component _buildContactMethods() {
    return div(
      classes: 'space-y-8',
      [
        div([
          h2(
            classes: 'text-3xl font-bold mb-6 gradient-text',
            [text('Let\'s Connect')],
          ),
          p(
            classes: 'text-gray-600 dark:text-gray-400 mb-8',
            [
              text(
                  'Choose your preferred way to reach out. I respond to all messages within 24 hours.')
            ],
          ),
        ]),

        // Contact Methods Grid
        div(
          classes: 'space-y-4',
          [
            for (final method in ContactData.methods) _buildContactMethodCard(method),
          ],
        ),

        // Availability Notice
        div(
          classes:
              'mt-8 p-6 bg-purple-50 dark:bg-purple-900/20 rounded-2xl border border-purple-200 dark:border-purple-800',
          [
            h3(
              classes: 'text-lg font-semibold text-purple-900 dark:text-purple-100 mb-2',
              [text('🚀 Currently Available')],
            ),
            p(
              classes: 'text-purple-700 dark:text-purple-300 text-sm',
              [
                text(
                    'I\'m actively taking on new projects and collaborations. Response time is typically within 4-6 hours during business hours.')
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildContactMethodCard(ContactMethod method) {
    return a(
      href: method.action,
      target: method.type == ContactType.email ? null : Target.blank,
      classes:
          'block p-6 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-gray-700 hover:border-purple-300 dark:hover:border-purple-600 transition-all duration-300 hover:-translate-y-1 hover:shadow-lg',
      [
        div(
          classes: 'flex items-start gap-4',
          [
            span(
              classes: 'text-2xl flex-shrink-0',
              [text(method.icon)],
            ),
            div(
              classes: 'flex-1',
              [
                h3(
                  classes: 'font-semibold text-gray-900 dark:text-white mb-1',
                  [text(method.title)],
                ),
                p(
                  classes: 'text-gray-600 dark:text-gray-400 text-sm mb-2',
                  [text(method.description)],
                ),
                span(
                  classes: 'text-purple-500 font-medium text-sm',
                  [text(method.actionText)],
                ),
              ],
            ),
            span(
              classes: 'text-gray-400 dark:text-gray-600 text-xl',
              [text('→')],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildContactForm() {
    if (_isSubmitted) {
      return _buildSuccessMessage();
    }

    return div(
      classes:
          'bg-white dark:bg-gray-800 p-8 rounded-2xl border border-gray-200 dark:border-gray-700 shadow-lg',
      [
        h2(
          classes: 'text-2xl font-bold mb-6 text-gray-900 dark:text-white',
          [text('Send a Message')],
        ),
        form(
          events: {
            'submit': (e) {
              e.preventDefault();
              _handleFormSubmit();
            },
          },
          [
            // Name and Email Row
            div(
              classes: 'grid grid-cols-1 md:grid-cols-2 gap-4 mb-4',
              [
                _buildFormField(
                  labelText: 'Name',
                  placeholder: 'Your full name',
                  value: _name,
                  onChanged: (value) => setState(() => _name = value),
                  required: true,
                ),
                _buildFormField(
                  labelText: 'Email',
                  placeholder: 'your.email@example.com',
                  type: InputType.email,
                  value: _email,
                  onChanged: (value) => setState(() => _email = value),
                  required: true,
                ),
              ],
            ),

            // Contact Reason
            div(
              classes: 'mb-4',
              [
                label(
                  classes: 'block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2',
                  [text('What\'s this about?')],
                ),
                select(
                  classes:
                      'w-full px-4 py-3 bg-gray-50 dark:bg-gray-700 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent theme-transition',
                  events: events(onChange: (String value) {
                    setState(
                      () => _reason = ContactReason.values.firstWhere((r) => r.name == value),
                    ); // TODO: Handle reason change
                  }),
                  // events: {
                  //   'change': (e) {
                  //     final target = e.target;
                  //     final index = target.selectedIndex;
                  //     setState(() => _reason = ContactReason.values[index]);
                  //   },
                  // },
                  [
                    for (final reason in ContactReason.values)
                      option(
                        value: reason.name,
                        selected: reason == _reason,
                        [text(_formatContactReason(reason))],
                      ),
                  ],
                ),
              ],
            ),

            // Subject
            _buildFormField(
              labelText: 'Subject',
              placeholder: 'Brief description of your project or question',
              value: _subject,
              onChanged: (value) => setState(() => _subject = value),
              required: true,
            ),

            // Message
            div(
              classes: 'mb-6',
              [
                label(
                  classes: 'block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2',
                  [text('Message *')],
                ),
                textarea(
                  classes:
                      'w-full px-4 py-3 bg-gray-50 dark:bg-gray-700 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent theme-transition resize-none',
                  placeholder:
                      'Tell me about your project, timeline, budget, or any questions you have...',
                  rows: 6,
                  // value: _message,
                  events: events(onChange: (String value) {
                    setState(() => _message = value); // TODO: Handle message change
                  }),
                  // events: {
                  //   'input': (e) {
                  //     final target = e.target as TextAreaElement;
                  //     setState(() => _message = target.value);
                  //   },
                  // },
                  [],
                ),
              ],
            ),

            // Submit Button
            button(
              type: ButtonType.submit,
              classes: 'w-full cta-button ${_isSubmitting ? 'opacity-75 cursor-not-allowed' : ''}',
              disabled: _isSubmitting,
              [
                text(_isSubmitting ? 'Sending...' : 'Send Message'),
                if (!_isSubmitting) span(classes: 'ml-2', [text('🚀')]),
              ],
            ),

            // Form Note
            p(
              classes: 'mt-4 text-sm text-gray-500 dark:text-gray-400 text-center',
              [text('I\'ll get back to you within 24 hours. Usually much sooner!')],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildFormField({
    required String labelText,
    required String placeholder,
    InputType type = InputType.text,
    required String value,
    required Function(String) onChanged,
    bool required = false,
  }) {
    return div(
      classes: 'mb-4',
      [
        label(
          classes: 'block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2',
          [text('$labelText${required ? ' *' : ''}')],
        ),
        input(
          type: type,
          classes:
              'w-full px-4 py-3 bg-gray-50 dark:bg-gray-700 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent theme-transition',
          // placeholder: placeholder,
          value: value,
          // required: required,
          events: events(
            onInput: (bool? value) {
              print('Checked: $value'); // TODO: Handle input change
            },
          ),
          // events: {
          //   'input': (e) {
          //     final target = e.target as InputElement;
          //     onChanged(target.value);
          //   },
          // },
          [
            textarea(
              classes:
                  'w-full px-4 py-3 bg-gray-50 dark:bg-gray-700 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent theme-transition',
              placeholder: placeholder,
              rows: 1,
              events: events(onChange: (String value) {
                print('Content: $value');
              }),
              [],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildSuccessMessage() {
    return div(
      classes:
          'bg-green-50 dark:bg-green-900/20 p-8 rounded-2xl border border-green-200 dark:border-green-800 text-center',
      [
        div(
          classes: 'text-6xl mb-4',
          [text('✅')],
        ),
        h2(
          classes: 'text-2xl font-bold text-green-900 dark:text-green-100 mb-4',
          [text('Message Sent Successfully!')],
        ),
        p(
          classes: 'text-green-700 dark:text-green-300 mb-6',
          [
            text(
                'Thank you for reaching out! I\'ve received your message and will get back to you within 24 hours.')
          ],
        ),
        button(
          classes:
              'px-6 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition-colors duration-200',
          events: {
            'click': (e) => setState(() => _isSubmitted = false),
          },
          [text('Send Another Message')],
        ),
      ],
    );
  }

  Component _buildQuickContactCTA() {
    return section(
      classes: 'py-16 bg-gradient-to-r from-purple-500 to-purple-400',
      [
        div(
          classes: 'max-w-4xl mx-auto px-8 text-center',
          [
            h2(
              classes: 'text-3xl font-bold text-white mb-4',
              [text('Need Quick Help?')],
            ),
            p(
              classes: 'text-purple-100 text-lg mb-8 max-w-2xl mx-auto',
              [
                text(
                    'For urgent questions or quick consultations, feel free to reach out directly via email or WhatsApp.')
              ],
            ),
            div(
              classes: 'flex flex-wrap justify-center gap-4',
              [
                a(
                  href: 'mailto:hello@gozieihejirika.com',
                  classes:
                      'inline-flex items-center gap-2 bg-white text-purple-600 px-6 py-3 rounded-full font-semibold hover:bg-purple-50 transition-colors duration-200',
                  [
                    text('📧'),
                    text('Quick Email'),
                  ],
                ),
                a(
                  href: 'https://wa.me/2348123456789',
                  target: Target.blank,
                  classes:
                      'inline-flex items-center gap-2 bg-white/20 text-white px-6 py-3 rounded-full font-semibold hover:bg-white/30 transition-colors duration-200',
                  [
                    text('💬'),
                    text('WhatsApp'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  String _formatContactReason(ContactReason reason) {
    switch (reason) {
      case ContactReason.projectInquiry:
        return 'Project Inquiry';
      case ContactReason.collaboration:
        return 'Collaboration Opportunity';
      case ContactReason.consultation:
        return 'Technical Consultation';
      case ContactReason.hiring:
        return 'Hiring/Job Opportunity';
      case ContactReason.question:
        return 'General Question';
      case ContactReason.other:
        return 'Other';
    }
  }

  void _handleFormSubmit() {
    setState(() => _isSubmitting = true);

    // Simulate form submission delay
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _isSubmitted = true;
          // Reset form
          _name = '';
          _email = '';
          _subject = '';
          _message = '';
          _reason = ContactReason.projectInquiry;
        });
      }
    });
  }
}

import 'dart:async';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart' as lucide;
import 'package:portfolio_site/components/ui/button.dart';
import 'package:portfolio_site/components/ui/card.dart';
import 'package:portfolio_site/components/ui/form_fields.dart';
import 'package:portfolio_site/components/ui/select_dropdown.dart';
import 'package:portfolio_site/models/contact_model.dart';
import 'package:universal_web/web.dart' as web;

// @client
class ContactFormCard extends StatefulComponent {
  const ContactFormCard();

  @override
  State createState() => ContactFormCardState();
}

class ContactFormCardState extends State<ContactFormCard> {
  StreamSubscription<web.Event>? _formSubscription;
  StreamSubscription<web.Event>? _formErrorSubscription;

  // Form state
  bool _isSubmitting = false;

  @override
  initState() {
    super.initState();
    _setupFormResetListener();
  }

  void _setupFormResetListener() {
    if (!kIsWeb) return; // Guard against server-side execution

    _formSubscription = web.EventStreamProvider<web.Event>('formReset')
        .forTarget(web.window)
        .listen((_) => resetForm());

    _formErrorSubscription = web.EventStreamProvider<web.Event>('formError')
        .forTarget(web.window)
        .listen((_) => resetForm());
  }

  void resetForm() {
    setState(() => _isSubmitting = false);
  }

  @override
  void dispose() {
    _formSubscription?.cancel();
    _formErrorSubscription?.cancel();
    super.dispose();
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Document.head(
      children: [
        link(
          href: 'https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css',
          rel: 'stylesheet',
        ),
        script(src: 'https://cdn.jsdelivr.net/npm/toastify-js', []),
      ],
    );

    yield Card(
      hoverEffect: CardHoverEffect.none,
      children: [
        CardHeader(
          children: [
            CardTitle(
              additionalClasses: 'text-2xl gradient-text pb-1',
              children: [text('Send a Message')],
            ),
          ],
        ),
        CardContent(
          children: [
            form(
              id: "my-form",
              action: "https://formspree.io/f/xnnzdlby",
              method: FormMethod.post,
              events: {
                "submit": (e) {
                  setState(() {
                    _isSubmitting = true;
                  });
                }
              },
              [
                div(
                  classes: 'space-y-6',
                  [
                    // Name and Email row
                    div(
                      classes: 'grid md:grid-cols-2 gap-4',
                      [
                        // Text Input with validation
                        TFormField(
                          id: 'name',
                          labelText: 'Full Name',
                          placeholder: 'Your name',
                          isRequired: true,
                          minLength: 5,
                          maxLength: 50,
                        ),

                        // Email Input
                        TFormField(
                          id: 'email',
                          labelText: 'Email Address',
                          placeholder: 'your@email.com',
                          type: 'email',
                          isRequired: true,
                          autocomplete: 'email',
                          pattern: r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
                        )
                      ],
                    ),

                    // Select dropdown
                    TSelectField<MessageType>(
                      id: 'messageType',
                      labelText: 'What is this about?',
                      name: 'messageType',
                      options: MessageType.values
                          .map((type) => SelectOption(value: type, label: type.label))
                          .toList(),
                      // onChanged: (value) => setState(() => _messageType = value),
                      placeholder: 'Select message type',
                    ),

                    // Message subject input
                    TFormField(
                      id: 'subject',
                      labelText: 'Subject',
                      placeholder: 'Brief subject line',
                      // value: _subject,
                      onChanged: (value) => (),
                      isRequired: false,
                      minLength: 5,
                      maxLength: 100,
                    ),

                    // Textarea with character count
                    TTextAreaField(
                      id: 'message',
                      labelText: 'Message',
                      placeholder:
                          'Tell me about your project, offer, budget, or any questions you have...',
                      isRequired: true,
                      rows: 6,
                      minLength: 10,
                      maxLength: 1000,
                    ),

                    // Submit Button
                    TButton(
                      text: _isSubmitting ? 'Sending...' : 'Send Message',
                      icon: _isSubmitting ? null : lucide.send,
                      fullWidth: true,
                      disabled: _isSubmitting,
                      customClasses: _isSubmitting ? 'opacity-75 cursor-not-allowed' : null,
                      type: ButtonType.submit,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

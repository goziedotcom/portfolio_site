// ============================================================================
// CONTACT MODELS
// ============================================================================

import 'package:portfolio_site/components/ui/icon.dart';

class ContactInfo {
  final LucideIcon lucideIcon;
  final String title;
  final String description;

  const ContactInfo({
    required this.lucideIcon,
    required this.title,
    required this.description,
  });
}

enum MessageType {
  project('Project Inquiry'),
  collaboration('Collaboration Opportunity'),
  consultation('Technical Consultation'),
  hiring('Hiring/Job Opportunity'),
  tutoring('Tutoring/Mentorship'),
  general('General Question'),
  other('Other');

  const MessageType(this.label);
  final String label;

  @override
  String toString() => label;
}

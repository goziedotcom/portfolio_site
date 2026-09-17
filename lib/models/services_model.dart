import 'package:portfolio_site/components/ui/icon.dart';

class ServiceModel {
  final LucideIcon icon;
  final String title;
  final String description;
  final List<String> features;

  const ServiceModel({
    required this.icon,
    required this.title,
    required this.description,
    required this.features,
  });
}
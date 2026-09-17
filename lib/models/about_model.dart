import 'package:portfolio_site/components/ui/icon.dart';

class Skill {
  final String name;
  final int level;

  const Skill({
    required this.name,
    required this.level,
  });
}

class Achievement {
  final String year;
  final String title;
  final String description;

  const Achievement({
    required this.year,
    required this.title,
    required this.description,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      year: json['year'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
}

extension SortAchievement on List<Achievement> {
  // Sort achievements by year in descending order
  List<Achievement> sortByYear() {
    return this..sort((a, b) => b.year.compareTo(a.year));
  }
}

class Value {
  final LucideIcon icon;
  final String title;
  final String description;

  const Value({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class HeaderContent {
  final String title;
  final String subtitle;

  const HeaderContent({
    required this.title,
    required this.subtitle,
  });
}

class StoryContent {
  final String title;
  final List<String> paragraphs;

  const StoryContent({
    required this.title,
    required this.paragraphs,
  });
}

class AboutContentData {
  final HeaderContent header;
  final StoryContent story;
  final List<Skill> skills;
  final List<Value> values;
  final List<String> technologies;

  const AboutContentData({
    required this.header,
    required this.story,
    required this.skills,
    required this.values,
    required this.technologies,
  });
}
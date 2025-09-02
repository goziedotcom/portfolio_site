import 'package:jaspr/jaspr.dart';
import 'package:jaspr_lucide/jaspr_lucide.dart' as lucide;
import 'package:portfolio_site/models/about_model.dart';
import 'package:portfolio_site/models/contact_model.dart';
import 'package:portfolio_site/models/services_model.dart';
import 'package:portfolio_site/models/technology_model.dart';

class SiteConfig {
  // Personal Information
  static const String fullName = 'Chiagoziem Ihejirika';
  static const String email = 'hello@gozieihejirika.com';

  // Professional Summary
  static const String shortBio =
      'Mobile developer specializing in Flutter with a passion for creating captivating mobile app experiences.';

  // SEO Keywords
  static const String keywords =
      'mobile developer, mobile engineer, flutter developer, iOS developer, android developer, jaspr, dart, mobile apps';

  // Social Media
  static const String twitterHandle = '@goziedotcom'; // Actual Twitter handle

  // Website Information
  static const String siteUrl = 'https://www.gozieihejirika.com'; // Actual domain
  static const String siteName = 'Gozie Ihejirika | Mobile Developer';

  // Brand Colors
  static const String primaryColor = '#7C3AED'; // Used for theme-color

  // Images
  static const String ogImage = '/.jpg'; // Social media preview image (1200x630px)

  static const String yearsOfExperience = "4";

  static const String projectsBuilt = "10+";

  // Meta data map for Document meta property
  static Map<String, String> get getMetaData => {
        'description': shortBio,
        'author': fullName,
        'robots': 'index, follow',
        'keywords': keywords,
        'theme-color': primaryColor,

        // Open Graph meta tags
        'og:type': 'website',
        'og:title': siteName,
        'og:description': shortBio,
        'og:image': '$siteUrl$ogImage',
        'og:url': siteUrl,
        'og:site_name': siteName,

        // Twitter Card meta tags
        'twitter:card': 'summary_large_image',
        'twitter:site': twitterHandle,
        'twitter:creator': twitterHandle,
        'twitter:title': siteName,
        'twitter:description': shortBio,
        'twitter:image': '$siteUrl$ogImage',
      };

  // Favicon links for head property
  static List<Component> get faviconLinks => [
        link(href: '/favicon.ico', rel: 'icon', type: 'image/x-icon'),
        link(
            href: '/favicon-32x32.png',
            rel: 'icon',
            type: 'image/png',
            attributes: {'sizes': '32x32'}),
        link(
            href: '/favicon-16x16.png',
            rel: 'icon',
            type: 'image/png',
            attributes: {'sizes': '16x16'}),
        link(
            href: '/apple-touch-icon.png',
            rel: 'apple-touch-icon',
            attributes: {'sizes': '180x180'}),
        link(
            href: '/android-chrome-192x192.png',
            rel: 'icon',
            type: 'image/png',
            attributes: {'sizes': '192x192'}),
        link(
            href: '/android-chrome-512x512.png',
            rel: 'icon',
            type: 'image/png',
            attributes: {'sizes': '512x512'}),
        link(href: '/site.webmanifest', rel: 'manifest'),
      ];

  static const Map<String, String> navLinks = {
    'Home': '/',
    'About': '/about',
    'Projects': '/projects',
    'Articles': '/articles',
    'Contact': '/contact',
  };
  static String footerText = '© ${DateTime.now().year} Gozie Ihejirika. All rights reserved.';

  static const List<Skill> skillsData = [
    Skill(name: "Flutter & Dart", level: 95),
    Skill(name: "Mobile Architecture", level: 90),
    Skill(name: "Firebase & Backend", level: 85),
    Skill(name: "State Management", level: 92),
    Skill(name: "Native iOS/Android", level: 75),
    Skill(name: "UI Development", level: 95),
  ];

  static const List<Value> valuesData = [
    Value(
      icon: lucide.target,
      title: "Performance First",
      description:
          "I build Flutter apps that are fast, responsive, and provide smooth 60fps experiences across all devices.",
    ),
    Value(
      icon: lucide.heart,
      title: "User-Centric Design",
      description:
          "Every mobile interface I create focuses on intuitive navigation and delightful user interactions.",
    ),
    Value(
      icon: lucide.award,
      title: "Cross-Platform Excellence",
      description:
          "I specialize in Flutter's 'write once, run anywhere' philosophy while maintaining native quality.",
    ),
  ];

  static const AboutContentData aboutPageContent = AboutContentData(
    header: HeaderContent(
      title: "About Me",
      subtitle:
          "Passionate mobile developer with $yearsOfExperience+ years of experience creating Flutter applications that users love.",
    ),
    story: StoryContent(
      title: "My Story",
      paragraphs: [
        "I started my development journey with Kotlin and Android about $yearsOfExperience years ago, building native Android apps and learning the ropes of mobile development. But everything changed when I discovered Flutter a year later – I was blown away by how I could create beautiful apps for both platforms with a single codebase, and Dart's clean syntax just clicked with me.",
        "Since diving into Flutter, I've helped startups and businesses bring their mobile app ideas to life. I'm passionate about clean code, smooth animations, and creating apps that feel truly native on both iOS and Android – not just 'good enough' cross-platform apps.",
        "When I'm not deep in Flutter code, you'll find me exploring the latest mobile design patterns, contributing to Flutter packages, or helping other developers make the transition to mobile development. I believe great code should be maintainable and love sharing what I've learned with the Flutter community.",
      ],
    ),
    skills: skillsData,
    values: valuesData,
    technologies: [
      "Flutter",
      "Dart",
      "Jaspr",
      "Riverpod",
      "Provider",
      "Firebase",
      "Serverpod",
      "Supabase",
      "VS Code",
      "Xcode",
      "Git",
    ],
  );

  // Contact info data
  static const List<ContactInfo> contactInfo = [
    ContactInfo(
      lucideIcon: lucide.mail,
      title: 'Email',
      description: 'hello@gozieihejirika.com',
    ),
    ContactInfo(
      lucideIcon: lucide.mapPin,
      title: 'Location',
      description: 'Remote • Available Worldwide',
    ),
    ContactInfo(
      lucideIcon: lucide.clock,
      title: 'Response Time',
      description: 'Usually within 24 hours',
    ),
  ];

  static const List<String> benefits = [
    '$yearsOfExperience+ years of mobile development exprtise',
    'Focus on performance and user experience',
    'Clean, maintainable, and scalable code',
    'Transparent communication throughout the project',
  ];

  static const List<ServiceModel> services = [
  ServiceModel(
    icon: lucide.smartphone,
    title: 'Mobile App Development',
    description:
        'End-to-end Flutter apps for iOS and Android with beautiful UIs, smooth performance, and seamless backend integration.',
    features: [
      'Cross-platform development',
      'Native performance',
      'Backend & API integration',
      'Real-time data sync'
    ],
  ),
  ServiceModel(
    icon: lucide.searchCheck,
    title: 'Free App Audit',
    description:
        'Comprehensive analysis of your existing app\'s performance, security, and user experience with actionable recommendations.',
    features: [
      'Performance analysis',
      'Security assessment',
      'UX evaluation',
      'Improvement roadmap'
    ],
  ),
  ServiceModel(
    icon: lucide.graduationCap,
    title: 'Python Programming Instruction',
    description:
        'Comprehensive Python training from fundamentals to advanced concepts, tailored for beginners and professionals.',
    features: [
      'Beginner to advanced curriculum',
      'Data science & web development',
      'Hands-on projects',
      'Personalized learning path'
    ],
  ),
  ServiceModel(
    icon: lucide.code,
    title: 'JavaScript Tutoring',
    description:
        'Expert JavaScript instruction covering modern ES6+, frameworks, and full-stack development principles.',
    features: [
      'Modern JavaScript (ES6+)',
      'Frontend frameworks',
      'Node.js & backend development',
      'Interactive coding sessions'
    ],
  ),
  ServiceModel(
    icon: lucide.messageCircle,
    title: 'Mobile App Consultation',
    description:
        'Expert guidance and strategic planning for your mobile app project from concept to launch.',
    features: [
      'Project feasibility analysis',
      'Technology recommendations',
      'Development roadmap',
      'Cost estimation'
    ],
  ),
  ServiceModel(
    icon: lucide.globe,
    title: 'Web Development',
    description:
        'Modern web applications using Flutter Web and Jaspr for consistent experiences across platforms.',
    features: ['Responsive design', 'PWA capabilities', 'SEO optimization'],
  ),
];

    // Technologies data organized by categories
  static const List<TechnologyCategory> technologiesData = [
    TechnologyCategory(
      name: 'Mobile Development',
      technologies: ['Flutter', 'Dart', 'iOS', 'Android', 'React Native'],
    ),
    TechnologyCategory(
      name: 'Backend & Cloud',
      technologies: ['Firebase', 'Serverpod', 'Node.js', 'PostgreSQL', 'MongoDB'],
    ),
    TechnologyCategory(
      name: 'Web Development',
      technologies: ['Jaspr', 'Tailwind CSS', 'HTML5', 'CSS3', 'JavaScript'],
    ),
    TechnologyCategory(
      name: 'Tools & Platforms',
      technologies: ['Git', 'Docker', 'VS Code', 'Figma', 'Postman'],
    ),
    TechnologyCategory(
      name: 'State Management',
      technologies: ['Riverpod', 'Provider', 'Bloc', 'GetX', 'MobX'],
    ),
    TechnologyCategory(
      name: 'Testing & Quality',
      technologies: [
        'Unit Testing',
        'Widget Testing',
        'Integration Testing',
        'CI/CD',
        'Code Review'
      ],
    ),
  ];
}

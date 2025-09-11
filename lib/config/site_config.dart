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

  static const String clientsServed = "10+";

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
    Skill(name: "React & TypeScript", level: 85),
    Skill(name: "Mobile Architecture", level: 90),
    Skill(name: "Frontend Development", level: 85),
    Skill(name: "State Management", level: 90),
    Skill(name: "Backend Integration", level: 87),
  ];

  static const List<Value> valuesData = [
    Value(
      icon: lucide.target,
      title: "Performance First",
      description:
          "I build high-performance applications that deliver smooth, responsive experiences across mobile and web platforms.",
    ),
    Value(
      icon: lucide.heart,
      title: "User-Centric Design",
      description:
          "Every interface I create prioritizes intuitive navigation and delightful user experiences, whether on mobile or web.",
    ),
    Value(
      icon: lucide.users,
      title: "Knowledge Sharing",
      description:
          "I believe in empowering others through mentorship, code reviews, and sharing insights that help teams build better products.",
    ),
  ];

  static const AboutContentData aboutPageContent = AboutContentData(
    header: HeaderContent(
      title: "About Me",
      subtitle:
          "Passionate frontend developer with $yearsOfExperience+ years of experience building mobile and web applications that users love.",
    ),
    story: StoryContent(
      title: "My Story",
      paragraphs: [
        "I started my development journey with Kotlin and Android about $yearsOfExperience years ago, building native Android apps and learning the fundamentals of mobile development. But everything changed when I discovered Flutter – I was amazed by how I could create beautiful apps for multiple platforms with a single codebase, and Dart's clean syntax just resonated with me.",
        "Since then, I've expanded my expertise across the development spectrum. While Flutter remains my go-to for mobile apps, I've also built responsive web applications using React, Next.js, and TypeScript. I help startups and businesses bring their ideas to life across mobile and web platforms, always focusing on performance, eye-catching user interfaces, and user experiences that feel native to each platform.",
        "Beyond coding, I'm keen on knowledge sharing. Whether I'm conducting code reviews, onboarding new developers, or leading technical workshops, I find fulfillment in helping others grow their skills. When I'm not building applications or tutoring, you'll find me exploring the latest development patterns, contributing to open-source projects, and staying current with both mobile and web technologies.",
      ],
    ),
    skills: skillsData,
    values: valuesData,
    technologies: [
      "Flutter",
      "Jaspr",
      "React",
      "Tailwind CSS",
      "Python",
      "Riverpod",
      "Provider",
      "Firebase",
      "Serverpod",
      "Supabase",
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
          'Modern web applications using Jaspr and React for consistent experiences across platforms.',
      features: [
        'Responsive web design',
        'PWA capabilities',
        'SEO optimization',
        'Backend integration'
      ],
    ),
    ServiceModel(
      icon: lucide.settings,
      title: 'App Maintenance & Support',
      description:
          'Ongoing support and maintenance to keep your app updated, secure, and performing at its best.',
      features: [
        'Regular updates',
        'Bug fixes',
        'Performance optimization',
        'Feature enhancements'
      ],
    ),
    ServiceModel(
      icon: lucide.code,
      title: 'Mobile Development Training',
      description:
          'In-depth Dart/Flutter training covering everything from basics to advanced topics, designed for aspiring mobile developers.',
      features: [
        'Dart programming fundamentals',
        'Comprehensive Flutter curriculum',
        'State management techniques',
        'Backend integration',
        'Real-world projects',
      ],
    ),
    // ServiceModel(
    //   icon: lucide.graduationCap,
    //   title: 'Python Programming Instruction',
    //   description:
    //       'Comprehensive Python programming courses for beginners and intermediates, focusing on practical applications and real-world projects.',
    //   features: [
    //     'Fundamentals of Python & OOP',
    //     'Hands-on, project-based learning',
    //     'Scripting and automation basics',
    //     'Introduction to data analysis',
    //     'Foundational concepts in cybersecurity',
    //     'Simple game development with Python',
    //   ],
    // ),
  ];

  // Technologies data organized by categories
  static const List<TechnologyCategory> technologiesData = [
    TechnologyCategory(
      name: 'Mobile Development',
      technologies: ['Flutter', 'Dart', 'iOS', 'Android'],
    ),
    TechnologyCategory(
      name: 'Backend & Cloud',
      technologies: ['Firebase', 'Serverpod', 'Supabase', 'GitHub Actions'],
    ),
    TechnologyCategory(
      name: 'Web Development',
      technologies: ['Jaspr', 'React', 'TypeScript', 'Next.js', 'Tailwind CSS'],
    ),
    TechnologyCategory(
      name: 'Tools & Platforms',
      technologies: ['Git', 'Postman', 'Shorebird'],
    ),
    TechnologyCategory(
      name: 'State Management',
      technologies: ['Riverpod', 'Provider'],
    ),
    TechnologyCategory(
      name: 'Testing & Quality',
      technologies: ['Unit & Widget Testing', 'Integration Testing', 'CI/CD'],
    ),
  ];
}

class AppData {
  final String appTitle;
  final AppBarData appBar;
  final List<Category> categories;
  final MainContent mainContent;

  AppData({
    required this.appTitle,
    required this.appBar,
    required this.categories,
    required this.mainContent,
  });

  factory AppData.fromJson(Map<String, dynamic> json) {
    return AppData(
      appTitle: json['appTitle'] ?? '',
      appBar: AppBarData.fromJson(json['appBar']),
      categories: (json['categories'] as List)
          .map((e) => Category.fromJson(e))
          .toList(),
      mainContent: MainContent.fromJson(json['mainContent']),
    );
  }
}

class AppBarData {
  final String title;
  final bool showLive;
  final bool showUpcoming;
  final bool titleCenter;

  AppBarData({
    required this.title,
    required this.showLive,
    required this.showUpcoming,
    required this.titleCenter,
  });

  factory AppBarData.fromJson(Map<String, dynamic> json) {
    return AppBarData(
      title: json['title'] ?? '',
      showLive: json['showLive'] ?? false,
      showUpcoming: json['showUpcoming'] ?? false,
      titleCenter: json['titleCenter'] ?? false,
    );
  }
}

class Category {
  final String icon;
  final String text;

  Category({required this.icon, required this.text});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(icon: json['icon'] ?? '', text: json['text'] ?? '');
  }
}

class MainContent {
  final InfoBox infoBox;
  final AboutUs aboutUs;
  final Footer footer;

  MainContent({
    required this.infoBox,
    required this.aboutUs,
    required this.footer,
  });

  factory MainContent.fromJson(Map<String, dynamic> json) {
    return MainContent(
      infoBox: InfoBox.fromJson(json['infoBox']),
      aboutUs: AboutUs.fromJson(json['aboutUs']),
      footer: Footer.fromJson(json['footer']),
    );
  }
}

class InfoBox {
  final String icon;
  final String text;

  InfoBox({required this.icon, required this.text});

  factory InfoBox.fromJson(Map<String, dynamic> json) {
    return InfoBox(icon: json['icon'] ?? '', text: json['text'] ?? '');
  }
}

class AboutUs {
  final String title;
  final String description;

  AboutUs({required this.title, required this.description});

  factory AboutUs.fromJson(Map<String, dynamic> json) {
    return AboutUs(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class Footer {
  final String text;
  final String highlight;
  final String suffix;

  Footer({required this.text, required this.highlight, required this.suffix});

  factory Footer.fromJson(Map<String, dynamic> json) {
    return Footer(
      text: json['text'] ?? '',
      highlight: json['highlight'] ?? '',
      suffix: json['suffix'] ?? '',
    );
  }
}

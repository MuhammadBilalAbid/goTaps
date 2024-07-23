class Platform {
  final int id;
  final String title;
  final String icon;
  final String input;
  final String? baseURL;
  final String pro;
  final String category_id;
  final String status;
  final String? placeholder_en;
  final String? placeholder_tr;
  final String? description_en;
  final String? description_tr;
  final String created_at;
  final String updated_at;
  final String category;
  final String category_tr;
  final String? path;
  final int saved;
  late final int direct;

  Platform({
    required this.id,
    required this.title,
    required this.icon,
    required this.input,
    this.baseURL,
    required this.pro,
    required this.category_id,
    required this.status,
    this.placeholder_en,
    this.placeholder_tr,
    this.description_en,
    this.description_tr,
    required this.created_at,
    required this.updated_at,
    required this.category,
    required this.category_tr,
    this.path,
    required this.saved,
    required this.direct,
  });

  factory Platform.fromJson(Map<String, dynamic> json) {
    return Platform(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
      input: json['input'],
      baseURL: json['baseURL'],
      pro: json['pro'],
      category_id: json['category_id'],
      status: json['status'],
      placeholder_en: json['placeholder_en'],
      placeholder_tr: json['placeholder_tr'],
      description_en: json['description_en'],
      description_tr: json['description_tr'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      category: json['category'],
      category_tr: json['category_tr'],
      path: json['path'],
      saved: json['saved'],
      direct: json['direct'],
    );
  }
}

class Category {
  final int id;
  final String name;
  final String title_en;
  final String title_tr;
  final int totalPlatforms;
  final List<Platform> platforms;

  Category({
    required this.id,
    required this.name,
    required this.title_en,
    required this.title_tr,
    required this.totalPlatforms,
    required this.platforms,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    var platformList = json['platforms'] as List;
    List<Platform> platforms =
        platformList.map((platform) => Platform.fromJson(platform)).toList();

    return Category(
      id: json['id'],
      name: json['name'],
      title_en: json['title_en'],
      title_tr: json['title_tr'],
      totalPlatforms: json['totalPlatforms'],
      platforms: platforms,
    );
  }
}

class ResponseData {
  final List<Category> categories;

  ResponseData({
    required this.categories,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    var categoryList = json['categories'] as List;
    List<Category> categories =
        categoryList.map((category) => Category.fromJson(category)).toList();

    return ResponseData(
      categories: categories,
    );
  }
}

class Advertiser {
  final String imageUrl;
  final String name;
  final String website;

  Advertiser({
    required this.imageUrl,
    required this.name,
    required this.website,
  });

  factory Advertiser.fromJson(Map<String, dynamic> json) {
    return Advertiser(
      imageUrl: json['image_url'] ?? '',
      name: json['name'] ?? '',
      website: json['website'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_url': imageUrl,
      'name': name,
      'website': website,
    };
  }
}

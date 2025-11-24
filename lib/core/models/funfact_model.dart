class FunfactModel {
  final String id;
  final String title;
  final String category; // 'funfact', 'quran_fact', 'hadith', 'islam_fact'
  final String content;
  final String? source;
  final String? reference;
  final String? imageUrl;
  final String? date; // Format: 'YYYY-MM-DD' untuk daily funfact

  FunfactModel({
    required this.id,
    required this.title,
    required this.category,
    required this.content,
    this.source,
    this.reference,
    this.imageUrl,
    this.date,
  });

  factory FunfactModel.fromJson(Map<String, dynamic> json) {
    return FunfactModel(
      id: json['id']?.toString() ?? json['date']?.toString() ?? '',
      title: json['title'] as String,
      category: json['category'] as String,
      content: json['content'] as String,
      source: json['source'] as String?,
      reference: json['reference'] as String?,
      imageUrl: json['image_url'] as String?,
      date: json['date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'content': content,
      'source': source,
      'reference': reference,
      'image_url': imageUrl,
      'date': date,
    };
  }
}

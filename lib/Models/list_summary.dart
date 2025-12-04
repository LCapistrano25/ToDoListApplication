class ListSummary {
  final int id;
  final String title;
  final String listType;

  ListSummary({required this.id, required this.title, required this.listType});

  factory ListSummary.fromJson(Map<String, dynamic> json) {
    return ListSummary(
      id: json['id'] as int,
      title: json['title'] as String,
      listType: json['list_type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'list_type': listType,
    };
  }
}

class PageListItem {
  final int id;
  final String title;
  final String type;
  final int? quantity;
  final String? value;

  PageListItem({
    required this.id,
    required this.title,
    required this.type,
    this.quantity,
    this.value,
  });

  factory PageListItem.fromJson(Map<String, dynamic> json) {
    return PageListItem(
      id: json['id'] as int,
      title: json['title'] as String,
      type: json['type'] as String,
      quantity: json['quantity'] as int?,
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'quantity': quantity,
      'value': value,
    };
  }
}

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
    final dynamic q = json['quantity'];
    final int? quantity = q == null
        ? null
        : (q is num
            ? q.toInt()
            : (q is String ? int.tryParse(q) : null));

    final dynamic v = json['value'];
    final String? value = v == null
        ? null
        : (v is String
            ? v
            : (v is num ? v.toStringAsFixed(2) : v.toString()));

    return PageListItem(
      id: json['id'] as int,
      title: json['title'] as String,
      type: json['type'] as String,
      quantity: quantity,
      value: value,
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

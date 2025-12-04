class ListType {
  final int id;
  final String type;
  final bool isCurrency;

  ListType({required this.id, required this.type, this.isCurrency = false});

  factory ListType.fromJson(Map<String, dynamic> json) {
    return ListType(
      id: json['id'] as int,
      type: json['type'] as String,
      isCurrency: (json['isCurrency'] as bool?) ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'isCurrency': isCurrency,
    };
  }
}

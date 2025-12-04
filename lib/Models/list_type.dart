class ListType {
  final String type;
  final bool isCurrency;

  ListType({required this.type, this.isCurrency = false});

  factory ListType.fromJson(Map<String, dynamic> json) {
    return ListType(
      type: json['type'] as String,
      isCurrency: json['isCurrency'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'isCurrency': isCurrency,
    };
  }
}

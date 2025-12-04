class ListType {
  final String type;

  ListType({required this.type});

  factory ListType.fromJson(Map<String, dynamic> json) {
    return ListType(
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
    };
  }
}

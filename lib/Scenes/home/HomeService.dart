class HomeService {
  final List<Map<String, dynamic>> _items = [
    {'id': 1, 'title': 'Mercado', 'list_type': 'Lista de Compras'},
    {'id': 2, 'title': 'Tarefas', 'list_type': 'Lista de Tarefas'},
    {'id': 3, 'title': 'Construção', 'list_type': 'Lista de Construção'},
  ];

  final List<Map<String, dynamic>> _types = const [
    {'type': 'Mercado'},
    {'type': 'Tarefas'},
    {'type': 'Construção'},
  ];

  Future<List<Map<String, dynamic>>> fetchItemList() async {
    await Future.delayed(const Duration(seconds: 1));
    return List<Map<String, dynamic>>.from(_items);
  }

  Future<void> createItem({required String title, required String type}) async {
    await Future.delayed(const Duration(seconds: 1));
    final nextId = (_items.isEmpty
        ? 1
        : (_items.map((e) => e['id'] as int? ?? 0).reduce((a, b) => a > b ? a : b) + 1));
    _items.add({'id': nextId, 'title': title, 'list_type': type});
  }

  Future<List<Map<String, dynamic>>> fetchTypeList() async {
    await Future.delayed(const Duration(seconds: 1));
    return List<Map<String, dynamic>>.from(_types);
  }
}

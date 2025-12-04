class HomeService {
  final List<Map<String, dynamic>> _items = [
    {'title': 'Mercado', 'list_type': 'Lista de Compras'},
    {'title': 'Tarefas', 'list_type': 'Lista de Tarefas'},
    {'title': 'Construção', 'list_type': 'Lista de Construção'},
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
    _items.add({'title': title, 'list_type': type});
  }

  Future<List<Map<String, dynamic>>> fetchTypeList() async {
    await Future.delayed(const Duration(seconds: 1));
    return List<Map<String, dynamic>>.from(_types);
  }
}

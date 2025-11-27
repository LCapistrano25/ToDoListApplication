class Homeservice {
  Future<List<Map<String, dynamic>>> fetchItemList() async {
    await Future.delayed(const Duration(seconds: 3));
    return [
      {'title': 'Mercado', 'list_type': 'Lista de Compras'},
      {'title': 'Tarefas', 'list_type': 'Lista de Tarefas'}
    ];
  }

}
class PageListService {
  final Map<String, List<Map<String, dynamic>>> _lists = {};

  String _key(String listTitle, String listType) => '$listTitle|$listType';

  List<Map<String, dynamic>> _ensureList(String listTitle, String listType) {
    final k = _key(listTitle, listType);
    return _lists.putIfAbsent(k, () => [
      {'title': 'Fazer Trabalho de matemática', 'type': listType, 'quantity': 2, 'value': 'R\$ 15,90'},
      {'title': 'Item 2', 'type': listType, 'quantity': 1, 'value': 'R\$ 8,00'},
      {'title': 'Item 3', 'type': listType, 'quantity': 5, 'value': 'R\$ 40,00'},
    ]);
  }

  Future<List<Map<String, dynamic>>> fetchListItems({required String listTitle, required String listType}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final list = _ensureList(listTitle, listType);
    return List<Map<String, dynamic>>.from(list);
  }

  Future<void> addItem({
    required String listTitle,
    required String listType,
    required String title,
    int? quantity,
    String? value,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final list = _ensureList(listTitle, listType);
    list.add({'title': title, 'type': listType, 'quantity': quantity, 'value': value});
  }

  Future<void> deleteItem({
    required String listTitle,
    required String listType,
    required int index,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final list = _ensureList(listTitle, listType);
    if (index >= 0 && index < list.length) {
      list.removeAt(index);
    }
  }

  Future<void> updateItem({
    required String listTitle,
    required String listType,
    required int index,
    required String title,
    int? quantity,
    String? value,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final list = _ensureList(listTitle, listType);
    if (index >= 0 && index < list.length) {
      list[index] = {
        'title': title,
        'type': listType,
        'quantity': quantity,
        'value': value,
      };
    }
  }
}

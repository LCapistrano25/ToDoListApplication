class PageListService {
  final Map<int, List<Map<String, dynamic>>> _listItems = {};
  final Map<int, int> _nextItemId = {};

  List<Map<String, dynamic>> _ensureList(int idList, String listType) {
    return _listItems.putIfAbsent(idList, () {
      final initial = idList == 1
          ? [
              {'id': 1, 'title': 'Fazer Trabalho de matemática', 'type': listType, 'quantity': 2, 'value': 'R\$ 15,90'},
              {'id': 2, 'title': 'Item 2', 'type': listType, 'quantity': 1, 'value': 'R\$ 8,00'},
              {'id': 3, 'title': 'Item 3', 'type': listType, 'quantity': 5, 'value': 'R\$ 40,00'},
            ]
          : <Map<String, dynamic>>[];
      _nextItemId[idList] = (initial.isEmpty ? 0 : initial.map((e) => e['id'] as int).reduce((a, b) => a > b ? a : b)) + 1;
      return initial;
    });
  }

  Future<List<Map<String, dynamic>>> fetchListItems({required int IdList, required String listType}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final list = _ensureList(IdList, listType);
    return List<Map<String, dynamic>>.from(list);
  }

  Future<void> addItem({
    required int IdList,
    required String listType,
    required String title,
    int? quantity,
    String? value,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final list = _ensureList(IdList, listType);
    final nextId = (_nextItemId[IdList] ?? 1);
    list.add({'id': nextId, 'title': title, 'type': listType, 'quantity': quantity, 'value': value});
    _nextItemId[IdList] = nextId + 1;
  }

  Future<void> deleteItem({
    required int IdList,
    required String listType,
    required int itemId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final list = _ensureList(IdList, listType);
    final idx = list.indexWhere((e) => (e['id'] as int) == itemId);
    if (idx >= 0) {
      list.removeAt(idx);
    }
  }

  Future<void> updateItem({
    required int IdList,
    required String listType,
    required int itemId,
    required String title,
    int? quantity,
    String? value,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final list = _ensureList(IdList, listType);
    final idx = list.indexWhere((e) => (e['id'] as int) == itemId);
    if (idx >= 0) {
      list[idx] = {
        'id': itemId,
        'title': title,
        'type': listType,
        'quantity': quantity,
        'value': value,
      };
    }
  }
}

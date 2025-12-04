import 'package:arc_to_do_list/models/list_summary.dart';
import 'package:arc_to_do_list/models/list_type.dart';

class HomeService {
  final List<Map<String, dynamic>> _items = [
    {'id': 1, 'title': 'Mercado', 'type_id': 1},
    {'id': 2, 'title': 'Tarefas', 'type_id': 2},
    {'id': 3, 'title': 'Construção', 'type_id': 3},
  ];

  final List<Map<String, dynamic>> _types = const [
    {'id': 1, 'type': 'Lista de Compras', 'isCurrency': true},
    {'id': 2, 'type': 'Lista de Tarefas', 'isCurrency': false},
    {'id': 3, 'type': 'Lista de Construção', 'isCurrency': true},
  ];

  Future<List<ListSummary>> fetchItemList() async {
    await Future.delayed(const Duration(seconds: 1));
    final typeById = {for (final t in _types) t['id'] as int: t['type'] as String};
    return _items.map((e) {
      final typeId = e['type_id'] as int;
      final typeName = typeById[typeId] ?? 'Tipo desconhecido';
      return ListSummary.fromJson({'id': e['id'], 'title': e['title'], 'list_type': typeName});
    }).toList();
  }

  Future<void> createItem({required String title, required String type}) async {
    await Future.delayed(const Duration(seconds: 1));
    final nextId = (_items.isEmpty
        ? 1
        : (_items.map((e) => e['id'] as int? ?? 0).reduce((a, b) => a > b ? a : b) + 1));
    final match = _types.firstWhere(
      (t) => t['type'] == type,
      orElse: () => {'id': 0, 'type': type, 'isCurrency': false},
    );
    _items.add({'id': nextId, 'title': title, 'type_id': match['id']});
  }

  Future<void> deleteItem({required int id}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _items.removeWhere((e) => e['id'] == id);
  }

  Future<List<ListType>> fetchTypeList() async {
    await Future.delayed(const Duration(seconds: 1));
    return _types.map((e) => ListType.fromJson(e)).toList();
  }
}

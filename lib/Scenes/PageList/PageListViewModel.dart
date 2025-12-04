import 'package:flutter/foundation.dart';
import 'package:arc_to_do_list/resources/shared/AppCoordinator.dart';
import 'package:arc_to_do_list/Scenes/PageList/PageListService.dart';

class PageListViewModel {
  final PageListService service;
  final AppCoordinator coordinator;
  final String title;
  final String type;
  final int IdList;

  final ValueNotifier<LoadStatus> status = ValueNotifier(LoadStatus.idle);
  final ValueNotifier<List<Map<String, dynamic>>> items = ValueNotifier([]);

  PageListViewModel({
    required this.service,
    required this.coordinator,
    required this.title,
    required this.type,
    required this.IdList,
  });

  Future<void> loadItems() async {
    status.value = LoadStatus.loading;
    try {
      final data = await service.fetchListItems(IdList: IdList, listType: type);
      items.value = data;
      if (data.isEmpty) {
        status.value = LoadStatus.empty;
      } else {
        status.value = LoadStatus.success;
      }
    } catch (_) {
      status.value = LoadStatus.error;
    }
  }

  Future<void> addItem({required String itemTitle, int? quantity, String? value}) async {
    try {
      await service.addItem(IdList: IdList, listType: type, title: itemTitle, quantity: quantity, value: value);
      await loadItems();
    } catch (_) {
      status.value = LoadStatus.error;
    }
  }

  Future<void> deleteItem({required int itemId}) async {
    try {
      await service.deleteItem(IdList: IdList, listType: type, itemId: itemId);
      await loadItems();
    } catch (_) {
      status.value = LoadStatus.error;
    }
  }

  Future<void> updateItem({required int itemId, required String itemTitle, int? quantity, String? value}) async {
    try {
      await service.updateItem(IdList: IdList, listType: type, itemId: itemId, title: itemTitle, quantity: quantity, value: value);
      await loadItems();
    } catch (_) {
      status.value = LoadStatus.error;
    }
  }
}

enum LoadStatus { idle, loading, success, empty, error }

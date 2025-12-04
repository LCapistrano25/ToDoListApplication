import 'package:arc_to_do_list/Scenes/home/HomeService.dart';
import 'package:arc_to_do_list/resources/shared/AppCoordinator.dart';
import 'package:flutter/foundation.dart';
import 'package:arc_to_do_list/models/list_summary.dart';
import 'package:arc_to_do_list/models/list_type.dart';

class HomeViewModel {
  final HomeService service;
  final AppCoordinator coordinator;

  final String name;
  final String address;

  final ValueNotifier<LoadStatus> status = ValueNotifier(LoadStatus.idle);
  final ValueNotifier<List<ListSummary>> items = ValueNotifier([]);

  HomeViewModel({
    required this.service,
    required this.coordinator,
    required this.name,
    required this.address,
  });

  final ValueNotifier<List<ListType>> typeList = ValueNotifier([]);

  Future<void> loadItems() async {
    status.value = LoadStatus.loading;
    try {
      final data = await service.fetchItemList();
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

  Future<void> loadTypeList() async {
    try {
      final data = await service.fetchTypeList();
      typeList.value = data;
    } catch (_) {
      status.value = LoadStatus.error;
    }
  }

  Future<void> createItem({required String title, required String type}) async {
    try {
      await service.createItem(title: title, type: type);
      loadItems();
    } catch (_) {
      status.value = LoadStatus.error;
    }
  } 
}

enum LoadStatus { idle, loading, success, empty, error }

import 'package:arc_to_do_list/Scenes/home/HomeService.dart';
import 'package:arc_to_do_list/resources/shared/AppCoordinator.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel {
  final HomeService service;
  final AppCoordinator coordinator;

  final String name;
  final String address;

  final ValueNotifier<LoadStatus> status = ValueNotifier(LoadStatus.idle);
  final ValueNotifier<List<Map<String, dynamic>>> items = ValueNotifier([]);

  HomeViewModel({
    required this.service,
    required this.coordinator,
    required this.name,
    required this.address,
  });

  Future<void> loadItems() async {
    status.value = LoadStatus.loading;
    try {
      final data = await service.fetchItemList();
      items.value = data;
      status.value = LoadStatus.success;
    } catch (_) {
      status.value = LoadStatus.error;
    }
  }
}

enum LoadStatus { idle, loading, success, error }

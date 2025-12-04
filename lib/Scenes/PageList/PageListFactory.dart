import 'package:flutter/material.dart';
import 'package:arc_to_do_list/resources/shared/AppCoordinator.dart';
import 'package:arc_to_do_list/Scenes/PageList/PageListView.dart';
import 'package:arc_to_do_list/Scenes/PageList/PageListViewModel.dart';
import 'package:arc_to_do_list/Scenes/PageList/PageListService.dart';

class PageListFactory {
  static Widget make({
    required AppCoordinator coordinator,
    required String title,
    required String type,
    required int IdList,
  }) {
    return PageListView(
      viewModel: PageListViewModel(
        service: PageListService(),
        coordinator: coordinator,
        title: title,
        type: type,
        IdList: IdList,
      ),
    );
  }
}

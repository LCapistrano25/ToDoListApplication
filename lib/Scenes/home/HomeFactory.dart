import 'package:arc_to_do_list/Scenes/home/HomeView.dart';
import 'package:arc_to_do_list/Scenes/home/HomeViewModel.dart';
import 'package:arc_to_do_list/Scenes/home/HomeService.dart';
import 'package:flutter/material.dart';

import '../../resources/shared/AppCoordinator.dart';

class HomeFactory {
  static Widget make({required String name, required String address, required AppCoordinator coordinator }) {
      return HomeView(
        viewModel: HomeViewModel(
          service: HomeService(),
          coordinator: coordinator,
          name: name,
          address: address,
        ),
      );
  }
}

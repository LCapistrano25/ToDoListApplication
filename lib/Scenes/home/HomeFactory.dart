import 'package:arc_to_do_list/Scenes/Home/HomeService.dart';
import 'package:arc_to_do_list/Scenes/Home/HomeView.dart';
import 'package:arc_to_do_list/Scenes/Home/HomeViewModel.dart';
import 'package:flutter/material.dart';

import '../../resources/shared/AppCoordinator.dart';

class HomeFactory {
  static Widget make({required String name, required String address, required AppCoordinator coordinator }) {
      return HomeView(
        viewModel: HomeViewModel(
          service: Homeservice(),
          coordinator: coordinator,
          name: name,
          address: address,
        ),
      );
  }
}
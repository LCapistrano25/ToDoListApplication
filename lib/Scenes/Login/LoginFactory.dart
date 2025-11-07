import 'package:arc_to_do_list/Scenes/Login/LoginService.dart';
import 'package:arc_to_do_list/Scenes/Login/LoginView.dart';
import 'package:arc_to_do_list/Scenes/Login/LoginViewModel.dart';
import 'package:arc_to_do_list/resources/shared/AppCoordinator.dart';
import 'package:flutter/material.dart';

class LoginFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final service = LoginService();
    final viewModel = LoginViewModel(service: service, coordinator: coordinator);
    return LoginView(viewModel: viewModel);
  }
}
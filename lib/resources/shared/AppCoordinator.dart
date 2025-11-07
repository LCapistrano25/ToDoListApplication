
import 'package:arc_to_do_list/Scenes/Login/LoginFactory.dart';
import 'package:flutter/material.dart';

class AppCoordinator {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Widget startApp() {
    return goLogin();
  }

  Widget goLogin() {
    return LoginFactory.make(coordinator: this);
  }
}

import 'package:arc_to_do_list/Scenes/Login/LoginFactory.dart';
import 'package:arc_to_do_list/Scenes/home/HomeFactory.dart';
import 'package:flutter/material.dart';

class AppCoordinator {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Widget startApp() {
    return goLogin();
  }

  Widget goLogin() {
    return LoginFactory.make(coordinator: this);
  }

  void goToHome({required String name, required String address}) {
    final home = HomeFactory.make(coordinator: this, name: name, address: address);
    navigatorKey.currentState?.pushReplacement(MaterialPageRoute(builder: (_) => home ));
  }
}
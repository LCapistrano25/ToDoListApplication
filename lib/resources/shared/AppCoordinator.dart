
import 'package:arc_to_do_list/Scenes/Login/LoginFactory.dart';
import 'package:arc_to_do_list/Scenes/Home/HomeFactory.dart';
import 'package:arc_to_do_list/Scenes/PageList/PageListFactory.dart';
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

  void goToLogin() {
    final login = LoginFactory.make(coordinator: this);
    navigatorKey.currentState?.pushReplacement(MaterialPageRoute(builder: (_) => login));
  }

  void goToPageList({required String title, required String type, required int IdList}) {
    final page = PageListFactory.make(coordinator: this, title: title, type: type, IdList: IdList);
    navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => page));
  }
}

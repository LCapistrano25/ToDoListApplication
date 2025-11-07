import 'package:arc_to_do_list/resources/shared/AppCoordinator.dart';
import 'package:flutter/material.dart';

void main() {
  final coordinator = AppCoordinator();
  runApp(Application(coordinator: coordinator));
}

class Application extends StatelessWidget {
  final AppCoordinator coordinator;

  const Application({super.key, required this.coordinator});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To Do List",
      navigatorKey: coordinator.navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
      ),
      home: coordinator.startApp(),
    );
  }
}
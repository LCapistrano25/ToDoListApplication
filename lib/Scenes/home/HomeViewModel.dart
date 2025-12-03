import 'package:arc_to_do_list/Scenes/home/HomeService.dart';
import 'package:arc_to_do_list/resources/shared/AppCoordinator.dart';

class HomeViewModel {
  final HomeService service;
  final AppCoordinator coordinator;

  final String name;
  final String address;

  const HomeViewModel({
    required this.service,
    required this.coordinator,
    required this.name,
    required this.address,
  });
}

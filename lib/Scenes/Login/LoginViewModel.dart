import 'package:arc_to_do_list/Scenes/Login/LoginService.dart';
import 'package:arc_to_do_list/resources/shared/AppCoordinator.dart';

class LoginViewModel{
  final LoginService service;
  final AppCoordinator coordinator;

  const LoginViewModel({required this.service, required this.coordinator});
}
import 'package:arc_to_do_list/DesignSytem/Components/Buttons/action_button.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Buttons/action_button_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Inputs/action_input.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Inputs/action_input_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/colors.dart';
import 'package:arc_to_do_list/Scenes/Login/LoginViewModel.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget{
  final LoginViewModel viewModel;
  const LoginView({super.key, required this.viewModel});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> implements ActionButtonDelegate {
  late ActionInput username;
  late ActionInput password;

  @override
  void initState() {
    super.initState();
    username = buildActionInputUsername();
    password = buildActionInputPassword();
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0), // laterais
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Olá, Seja Bem Vindo!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: 24), // espaço vertical
              username,
              const SizedBox(height: 16),
              password,
              const SizedBox(height: 16),

              buildActionButton(delegate: this),
            ],
          ),
        ),
      );
    }

  @override
  void onClick(ActionButtonViewModel viewModel) {
    String user = '';
    String pass = '';

    widget.viewModel.performLogin(
      user,
      pass,
      onSuccess: (name, address) {
        widget.viewModel.presentHome(name, address);
      },
    );
  }
}

ActionInput buildActionInputUsername() {
  final viewModel = ActionInputViewModel(
    style: ActionInputStyle.primary,
    hintText: 'Usuário',
    maxLength: 20
  );

  return ActionInput.instantiate(viewModel: viewModel);
}

ActionInput buildActionInputPassword() {
  final viewModel = ActionInputViewModel(
    style: ActionInputStyle.primary,
    hintText: 'Senha',
    maxLength: 15,
    obscureText: true
  );

  return ActionInput.instantiate(viewModel: viewModel);
}

ActionButton buildActionButton({required ActionButtonDelegate delegate}) {
  final viewModel = ActionButtonViewModel(
      size: ActionButtonSize.large,
      style: ActionButtonStyle.secondary,
      text: 'Login',
      textColor: textPrimary
  );

  return ActionButton.instantiate(
    viewModel: viewModel,
    delegate: delegate,
  );
}

import 'package:arc_to_do_list/DesignSytem/Components/Buttons/action_button.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Buttons/action_button_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Inputs/action_input.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Inputs/action_input_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/colors.dart';
import 'package:arc_to_do_list/Scenes/Login/LoginViewModel.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  final LoginViewModel viewModel;

  const LoginView({super.key, required this.viewModel});

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
              buildActionInputUsername(),

              const SizedBox(height: 16),
              buildActionInputPassword(),

              const SizedBox(height: 16),

              buildActionButton(),
            ],
          ),
        ),
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

class MaxLengthEnforcement {
}

ActionButton buildActionButton() {
  final viewModel = ActionButtonViewModel(
      size: ActionButtonSize.large,
      style: ActionButtonStyle.secondary,
      text: 'Login',
      textColor: textPrimary
  );

  return ActionButton.instantiate(
    viewModel: viewModel
  );
}

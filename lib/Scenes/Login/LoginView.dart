import 'package:arc_to_do_list/DesignSytem/Components/Buttons/action_button.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Buttons/action_button_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Inputs/action_input.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Inputs/action_input_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/colors.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Loads/action_load.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Loads/action_load_view_model.dart';
import 'package:arc_to_do_list/Scenes/Login/LoginViewModel.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginView({super.key, required this.viewModel});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    implements ActionButtonDelegate {

  late final ActionInputViewModel usernameVM;
  late final ActionInputViewModel passwordVM;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // ViewModels vindos de funções externas
    usernameVM = buildUsernameViewModel();
    passwordVM = buildPasswordViewModel();
  }

  ActionInput get username => ActionInput.instantiate(viewModel: usernameVM);
  ActionInput get password => ActionInput.instantiate(viewModel: passwordVM);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Olá, Seja Bem Vindo!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 24),

            username,
            const SizedBox(height: 16),

            password,
            const SizedBox(height: 16),

            buildLoginButton(delegate: this, enabled: !_isLoading),
          ],
        ),
      ),
    );
  }

  @override
  void onClick(ActionButtonViewModel vm) {
    if (_isLoading) return;
    final user = usernameVM.controller?.text ?? '';
    final pass = passwordVM.controller?.text ?? '';

    setState(() { _isLoading = true; });
    _showLoading();

    widget.viewModel.performLogin(
      user,
      pass,
      onSuccess: (name, address) {
        Navigator.of(context).pop();
        setState(() { _isLoading = false; });
        widget.viewModel.presentHome(name, address);
      },
    );
  }

  void _showLoading() {
    final vm = ActionLoadViewModel(4, 48, ActionLoadType.secondary);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: ActionLoad.initialize(viewModel: vm),
      ),
    );
  }
}

ActionInputViewModel buildUsernameViewModel() {
  return ActionInputViewModel(
    style: ActionInputStyle.primary,
    hintText: 'Usuário',
    controller: TextEditingController(),
    maxLength: 20,
  );
}

ActionInputViewModel buildPasswordViewModel() {
  return ActionInputViewModel(
    style: ActionInputStyle.primary,
    hintText: 'Senha',
    obscureText: true,
    controller: TextEditingController(),
    maxLength: 15,
  );
}

ActionButton buildLoginButton({required ActionButtonDelegate delegate, bool enabled = true}) {
  final vm = ActionButtonViewModel(
    size: ActionButtonSize.large,
    style: ActionButtonStyle.primary,
    text: 'Login',
    textColor: textPrimary,
    enabled: enabled,
  );

  return ActionButton.instantiate(
    viewModel: vm,
    delegate: delegate,
  );
}

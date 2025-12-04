import 'package:arc_to_do_list/DesignSytem/Components/Buttons/ElevateButton/action_button.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Buttons/ElevateButton/action_button_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Inputs/action_input.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Inputs/action_input_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/colors.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Loads/action_load.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Loads/action_load_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/styles.dart';
import 'package:arc_to_do_list/Scenes/Login/LoginViewModel.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class LoginView extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginView({super.key, required this.viewModel});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    implements ActionButtonDelegate {

  late ActionInputViewModel usernameVM;
  late ActionInputViewModel passwordVM;
  bool _isLoading = false;
  bool _canSubmit = false;
  late final TextEditingController _userController;
  late final TextEditingController _passController;
  bool _obscurePassword = true;

  void _syncValidity() {
    final user = _userController.text.trim();
    final pass = _passController.text.trim();
    final next = user.isNotEmpty && pass.isNotEmpty;
    if (next != _canSubmit) {
      setState(() { _canSubmit = next; });
    }
  }

  @override
  void initState() {
    super.initState();

    _userController = TextEditingController();
    _passController = TextEditingController();

    usernameVM = buildUsernameViewModel(
      onChanged: (_) => _syncValidity(),
      controller: _userController,
    );
    passwordVM = buildPasswordViewModel(
      onChanged: (_) => _syncValidity(),
      controller: _passController,
      obscure: _obscurePassword,
      onToggle: _togglePasswordVisibility,
    );

    // Valida estado inicial
    _syncValidity();
  }

  ActionInput get username => ActionInput.instantiate(viewModel: usernameVM);
  ActionInput get password => ActionInput.instantiate(viewModel: passwordVM);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/fundo_login.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.file(
                File('assets/images/fundo_login.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              width: 378,
              child: Container
              (
                padding: const EdgeInsets.symmetric(horizontal: 31, vertical: 49),
                decoration: BoxDecoration(
                  color: neutralLightGray,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Olá!',
                            style: poppinsRegular40.copyWith(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                              height: 1.10,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Seja Bem vindo!',
                            style: poppinsRegular32.copyWith(
                              color: alternativeColor,
                              fontWeight: FontWeight.w500,
                              height: 1.20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: 326,
                      child: username,
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: 326,
                      child: password,
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: 326,
                      height: 48,
                      child: buildLoginButton(
                        delegate: this,
                        enabled: !_isLoading && _canSubmit,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  void onActionButtonClick(ActionButtonViewModel vm) {
    if (_isLoading) return;
    final user = _userController.text;
    final pass = _passController.text;

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
    final vm = ActionLoadViewModel(4, 48, ActionLoadType.primary);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: ActionLoad.initialize(viewModel: vm),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
      passwordVM = buildPasswordViewModel(
        onChanged: (_) => _syncValidity(),
        controller: _passController,
        obscure: _obscurePassword,
        onToggle: _togglePasswordVisibility,
      );
    });
  }
}

ActionInputViewModel buildUsernameViewModel({ValueChanged<String>? onChanged, TextEditingController? controller}) {
  return ActionInputViewModel(
    style: ActionInputStyle.primary,
    labelText: 'Usuário',
    controller: controller ?? TextEditingController(),
    maxLength: 20,
    iconColor: textSecondary,
    onChanged: onChanged,
    borderColor: textSecondary,
  );
}

ActionInputViewModel buildPasswordViewModel({ValueChanged<String>? onChanged, TextEditingController? controller, bool obscure = true, VoidCallback? onToggle}) {
  return ActionInputViewModel(
    style: ActionInputStyle.primary,
    labelText: 'Senha',
    obscureText: obscure,
    controller: controller ?? TextEditingController(),
    maxLength: 15,
    suffixIcon: obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
    iconColor: textSecondary,
    onChanged: onChanged,
    onSuffixIconTap: onToggle,
    borderColor: textSecondary,
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

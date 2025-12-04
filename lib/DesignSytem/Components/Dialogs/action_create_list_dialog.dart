import 'package:arc_to_do_list/DesignSytem/Components/Buttons/ElevateButton/action_button.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Buttons/ElevateButton/action_button_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/DropDown/action_dropdown.dart';
import 'package:arc_to_do_list/DesignSytem/Components/DropDown/action_dropdown_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Inputs/action_input.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Inputs/action_input_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/colors.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Dialogs/action_create_list_dialog_view_model.dart';
import 'package:flutter/material.dart';

abstract class ActionCreateListDialogDelegate {
  void onCreate(String name, String type);
  void onCancel();
}

class ActionCreateListDialog extends StatefulWidget {
  final ActionCreateListDialogViewModel viewModel;
  final ActionCreateListDialogDelegate? delegate;
  final void Function(String name, String type)? onCreate;
  final VoidCallback? onCancel;

  const ActionCreateListDialog._({
    super.key,
    required this.viewModel,
    this.delegate,
    this.onCreate,
    this.onCancel,
  });

  static ActionCreateListDialog instantiate({
    required ActionCreateListDialogViewModel viewModel,
    ActionCreateListDialogDelegate? delegate,
    void Function(String name, String type)? onCreate,
    VoidCallback? onCancel,
  }) {
    return ActionCreateListDialog._(
      viewModel: viewModel,
      delegate: delegate,
      onCreate: onCreate,
      onCancel: onCancel,
    );
  }

  @override
  State<ActionCreateListDialog> createState() => _ActionCreateListDialogState();
}

class _ActionCreateListDialogState extends State<ActionCreateListDialog>
    implements ActionButtonDelegate, ActionInputDelegate {
  final TextEditingController _nameController = TextEditingController();
  String? _selectedType;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = widget.viewModel;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: brandWhite,
      child: SizedBox(
        width: 400,
        height: 290,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 29,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Text(
                        vm.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 1.20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ActionInput.instantiate(
                viewModel: ActionInputViewModel(
                  style: ActionInputStyle.primary,
                  labelText: vm.nameLabel,
                  controller: _nameController,
                  borderColor: vm.borderColor ?? alternativeColor,
                  borderSize: vm.borderSize ?? 0.5,
                ),
                delegate: this,
              ),
              const SizedBox(height: 20),
              ActionDropdown.instantiate(
                viewModel: ActionDropdownViewModel<String>(
                  style: ActionDropdownStyle.primary,
                  borderColor: vm.borderColor ?? alternativeColor,
                  borderSize: vm.borderSize ?? 0.5,
                  labelText: vm.typeLabel,
                  items: vm.typeItems,
                  value: _selectedType,
                  onChanged: (v) {
                    setState(() {
                      _selectedType = v;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ActionButton.instantiate(
                    viewModel: ActionButtonViewModel(
                      size: ActionButtonSize.medium,
                      style: ActionButtonStyle.empty,
                      text: 'Cancelar',
                      textColor: textMain,
                      borderColor: lightOutline,
                    ),
                    delegate: this,
                  ),
                  const SizedBox(width: 12),
                  ActionButton.instantiate(
                    viewModel: ActionButtonViewModel(
                      size: ActionButtonSize.medium,
                      style: ActionButtonStyle.primary,
                      text: 'Criar',
                      textColor: textMain,
                    ),
                    delegate: this,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onActionButtonClick(ActionButtonViewModel viewModel) {
    if (viewModel.text == 'Cancelar') {
      widget.delegate?.onCancel();
      widget.onCancel?.call();
      Navigator.of(context).pop();
      return;
    }

    if (viewModel.text == 'Criar') {
      final name = _nameController.text.trim();
      final type = _selectedType ?? '';
      if (name.isEmpty || type.isEmpty) {
        return;
      }
      widget.delegate?.onCreate(name, type);
      widget.onCreate?.call(name, type);
      Navigator.of(context).pop();
      return;
    }
  }

  @override
  void onClick(ActionInputViewModel viewModel) {}
}


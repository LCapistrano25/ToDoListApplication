import 'package:arc_to_do_list/DesignSytem/Components/Buttons/ElevateButton/action_button.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Buttons/ElevateButton/action_button_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Dialogs/PopUpDelete/action_confirm_delete_dialog_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/colors.dart';
import 'package:flutter/material.dart';

abstract class ActionConfirmDeleteDialogDelegate {
  void onConfirm();
  void onCancel();
}

class ActionConfirmDeleteDialog extends StatefulWidget {
  final ActionConfirmDeleteDialogViewModel viewModel;
  final ActionConfirmDeleteDialogDelegate? delegate;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const ActionConfirmDeleteDialog._({
    super.key,
    required this.viewModel,
    this.delegate,
    this.onConfirm,
    this.onCancel,
  });

  static ActionConfirmDeleteDialog instantiate({
    required ActionConfirmDeleteDialogViewModel viewModel,
    ActionConfirmDeleteDialogDelegate? delegate,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return ActionConfirmDeleteDialog._(
      viewModel: viewModel,
      delegate: delegate,
      onConfirm: onConfirm,
      onCancel: onCancel,
    );
  }

  @override
  State<ActionConfirmDeleteDialog> createState() => _ActionConfirmDeleteDialogState();
}

class _ActionConfirmDeleteDialogState extends State<ActionConfirmDeleteDialog> implements ActionButtonDelegate {
  @override
  Widget build(BuildContext context) {
    final vm = widget.viewModel;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: brandWhite,
      child: SizedBox(
        width: 400,
        height: 200,
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
                child: Align(
                  alignment: Alignment.centerLeft,
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
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  vm.message,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 1.40,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ActionButton.instantiate(
                    viewModel: ActionButtonViewModel(
                      size: ActionButtonSize.medium,
                      style: ActionButtonStyle.empty,
                      text: vm.cancelText,
                      textColor: textMain,
                      borderColor: lightOutline,
                    ),
                    delegate: this,
                  ),
                  const SizedBox(width: 12),
                  ActionButton.instantiate(
                    viewModel: ActionButtonViewModel(
                      size: ActionButtonSize.medium,
                      style: ActionButtonStyle.destructive,
                      text: vm.confirmText,
                      textColor: Colors.white,
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
    if (viewModel.style == ActionButtonStyle.empty) {
      widget.delegate?.onCancel();
      widget.onCancel?.call();
      Navigator.of(context).pop();
      return;
    }

    if (viewModel.style == ActionButtonStyle.destructive) {
      widget.delegate?.onConfirm();
      widget.onConfirm?.call();
      Navigator.of(context).pop();
      return;
    }
  }
}

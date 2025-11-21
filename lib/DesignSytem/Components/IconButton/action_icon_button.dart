import 'package:flutter/material.dart';
import 'action_icon_button_view_model.dart';

abstract class ActionIconButtonDelegate {
  void onClick(ActionIconButtonViewModel viewModel);
}

class ActionIconButton extends StatelessWidget {
  final ActionIconButtonViewModel viewModel;
  final ActionIconButtonDelegate? delegate;

  const ActionIconButton._({
    required this.viewModel,
    this.delegate,
  });

  static ActionIconButton initialize({
    required ActionIconButtonViewModel viewModel,
    ActionIconButtonDelegate? delegate,
  }) {
    return ActionIconButton._(
      viewModel: viewModel,
      delegate: delegate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(viewModel.icon, size: viewModel.size),
      color: viewModel.color,
      onPressed: () {
        delegate?.onClick(viewModel);
      },
    );
  }
}

import 'package:arc_to_do_list/DesignSytem/Components/Icons/action_icon_view_model.dart';
import 'package:flutter/material.dart';

class ActionIcon extends StatelessWidget {
  final ActionIconViewModel viewModel;

  const ActionIcon._({
    required this.viewModel,
  });

  static ActionIcon instantiate({
    required ActionIconViewModel viewModel,
  }) {
    return ActionIcon._(
      viewModel: viewModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
        viewModel.icon,
        size: viewModel.size ?? 20,
        color: viewModel.color ?? Colors.black,
    );
  }
}

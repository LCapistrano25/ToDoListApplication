import 'package:arc_to_do_list/DesignSytem/Components/Loads/action_load_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/colors.dart';
import 'package:flutter/material.dart';

class ActionLoad extends StatelessWidget {
  final ActionLoadViewModel viewModel;

  const ActionLoad._({
    required this.viewModel}
  );

  static ActionLoad initialize({
    required ActionLoadViewModel viewModel,
  }) {
    return ActionLoad._(viewModel: viewModel);
  }

  Color getColor() {
    switch (viewModel.type) {
      case ActionLoadType.primary:
        return primaryColor;
      case ActionLoadType.secondary:
        return secondaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: viewModel.size,
      height: viewModel.size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(getColor()),
        strokeWidth: viewModel.strokeWidth,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
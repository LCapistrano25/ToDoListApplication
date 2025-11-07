import 'package:arc_to_do_list/DesignSytem/Components/DropDownItem/action_dropdown_item_view_model.dart';
import 'package:flutter/material.dart';

class ActionDropdownMenuItem<T> extends StatelessWidget {
  final ActionDropdownMenuItemViewModel<T> viewModel;

  const ActionDropdownMenuItem._({
    super.key,
    required this.viewModel,
  });

  static DropdownMenuItem<T> instantiate<T>({
    required ActionDropdownMenuItemViewModel<T> viewModel,
  }) {
    return DropdownMenuItem<T>(
      value: viewModel.value,
      child: ActionDropdownMenuItem._(viewModel: viewModel),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inheritedTextColor = DefaultTextStyle.of(context).style.color;

    return Row(
      children: [
        if (viewModel.icon != null)
          Icon(
            viewModel.icon,
            color: viewModel.iconColor ?? Theme.of(context).iconTheme.color,
          ),
        if (viewModel.icon != null) const SizedBox(width: 8),
       Text(
          viewModel.label,
          style: viewModel.textColor != null
              ? TextStyle(color: inheritedTextColor) // aplica apenas se for custom
              : null, // deixa sem estilo -> herda o style do DropdownButtonFormField
        ),
      ],
    );
  }
}

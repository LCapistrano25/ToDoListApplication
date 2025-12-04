import 'package:arc_to_do_list/DesignSytem/Components/Dialogs/action_create_list_dialog.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Dialogs/action_create_list_dialog_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/colors.dart';
import 'package:flutter/material.dart';

Future<void> popUpList({
  required BuildContext context,
  required Function(String, String) onCreate,
  required Function() onCancel,
  required List<String> typeItems,
}) {
  final mappedItems = typeItems.isEmpty
      ? null
      : typeItems
          .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
          .toList();

  final viewModel = ActionCreateListDialogViewModel(
    borderColor: alternativeColor,
    borderSize: 0.5,
    typeItems: mappedItems,
  );
  
  return showDialog<void>(
    context: context,
    builder: (_) => ActionCreateListDialog.instantiate(
      viewModel: viewModel,
      onCreate: onCreate,
      onCancel: onCancel,
    ),
  );
}

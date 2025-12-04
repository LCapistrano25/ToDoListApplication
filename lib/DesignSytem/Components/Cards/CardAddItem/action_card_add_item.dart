import 'package:arc_to_do_list/DesignSytem/Components/Buttons/ElevateButton/action_button.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Buttons/ElevateButton/action_button_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Cards/CardAddItem/action_card_add_item_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/DropDown/action_dropdown.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Inputs/action_input.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/colors.dart';
import 'package:flutter/material.dart';

class ActionCardAddItem extends StatelessWidget {
  final ActionCardAddItemViewModel viewModel;

  const ActionCardAddItem({
    super.key,
    required this.viewModel,
  });

  /// Factory padrão para criação do Card (seguindo o padrão dos outros componentes)
  static Widget instantiate({
    required ActionCardAddItemViewModel viewModel,
    ActionCardAddItemStyle? style,
    VoidCallback? onAddPressed,
  }) {
    return ActionCardAddItem(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    final isSecondary = viewModel.style == ActionCardAddItemStyle.secondary;

    return Container(
      width: 416,
      padding: const EdgeInsets.all(31),
      decoration: BoxDecoration(
        color: isSecondary ? alternativeColor : brandWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Adicionar item',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 1.20,
            ),
          ),
          const SizedBox(height: 17),
          SizedBox(
            width: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ActionInput.instantiate(viewModel: viewModel.nameInput),
                const SizedBox(height: 15),
                ActionInput.instantiate(viewModel: viewModel.quantityInput),
                const SizedBox(height: 15),
                ActionDropdown.instantiate(viewModel: viewModel.typeDropdown),
                const SizedBox(height: 15),
                ActionInput.instantiate(viewModel: viewModel.valueInput),
              ],
            ),
          ),
          const SizedBox(height: 17),
          SizedBox(
            width: 350,
            child: Center(
              child: ActionButton.instantiate(
                viewModel: viewModel.addButton,
                delegate: _ActionCardAddItemDelegate(
                  onPressed: viewModel.onAddPressed,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCardAddItemDelegate implements ActionButtonDelegate {
  final VoidCallback? onPressed;

  const _ActionCardAddItemDelegate({this.onPressed});

  @override
  void onActionButtonClick(ActionButtonViewModel viewModel) {
    onPressed?.call();
  }
}

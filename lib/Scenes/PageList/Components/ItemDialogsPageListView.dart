import 'package:flutter/material.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Inputs/action_input_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/DropDown/action_dropdown_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Buttons/ElevateButton/action_button_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/colors.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Cards/CardAddItem/action_card_add_item.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Cards/CardAddItem/action_card_add_item_view_model.dart';
import 'package:arc_to_do_list/Scenes/PageList/PageListViewModel.dart';

void showAddItemDialog(BuildContext context, PageListViewModel viewModel) {
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final valueController = TextEditingController();
  final nameVM = ActionInputViewModel(
    style: ActionInputStyle.primary,
    labelText: 'Nome item',
    controller: nameController,
    borderColor: textDisabled,
    borderSize: 1.0,
  );
  final quantityVM = ActionInputViewModel(
    style: ActionInputStyle.primary,
    labelText: 'Quantidade',
    controller: quantityController,
    keyboardType: TextInputType.number,
    formatter: ActionTypeInputFormatter.digitsOnly,
    borderColor: textDisabled,
    borderSize: 1.0,
  );
  final typeVM = ActionDropdownViewModel<String>(
    style: ActionDropdownStyle.primary,
    borderColor: textDisabled,
    borderSize: 1.0,
    labelText: 'Tipo de Item',
    items: [DropdownMenuItem<String>(value: viewModel.type, child: Text(viewModel.type))],
    value: viewModel.type,
    onChanged: (_) {},
  );
  final valueVM = ActionInputViewModel(
    style: ActionInputStyle.primary,
    labelText: 'Valor',
    controller: valueController,
    keyboardType: TextInputType.number,
    formatter: ActionTypeInputFormatter.decimal2Fixed,
    borderColor: textDisabled,
    borderSize: 1.0,
  );
  final addBtnVM = ActionButtonViewModel(
    size: ActionButtonSize.medium,
    style: ActionButtonStyle.primary,
    text: 'Adicionar',
    textColor: brandWhite,
  );
  final cardVM = ActionCardAddItemViewModel(
    style: ActionCardAddItemStyle.primary,
    nameInput: nameVM,
    quantityInput: quantityVM,
    typeDropdown: typeVM,
    valueInput: valueVM,
    addButton: addBtnVM,
    onAddPressed: () {
      final title = nameController.text.trim();
      final quantityText = quantityController.text.trim();
      final value = valueController.text.trim();
      if (title.isEmpty) return;
      final qty = quantityText.isEmpty ? null : int.tryParse(quantityText);
      viewModel.addItem(itemTitle: title, quantity: qty, value: value.isEmpty ? null : value);
      Navigator.of(context).pop();
    },
  );
  showDialog(
    context: context,
    builder: (_) => Dialog(
      backgroundColor: brandWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ActionCardAddItem.instantiate(viewModel: cardVM),
      ),
    ),
  );
}

void showEditItemDialog(
  BuildContext context,
  PageListViewModel viewModel, {
  required int index,
  required String currentTitle,
  int? currentQuantity,
  String? currentValue,
}) {
  final nameController = TextEditingController(text: currentTitle);
  final quantityController = TextEditingController(text: currentQuantity?.toString() ?? '');
  final valueController = TextEditingController(text: currentValue ?? '');
  final nameVM = ActionInputViewModel(
    style: ActionInputStyle.primary,
    labelText: 'Nome item',
    controller: nameController,
    borderColor: textDisabled,
    borderSize: 1.0,
  );
  final quantityVM = ActionInputViewModel(
    style: ActionInputStyle.primary,
    labelText: 'Quantidade',
    controller: quantityController,
    keyboardType: TextInputType.number,
    formatter: ActionTypeInputFormatter.digitsOnly,
    borderColor: textDisabled,
    borderSize: 1.0,
  );
  final typeVM = ActionDropdownViewModel<String>(
    style: ActionDropdownStyle.primary,
    borderColor: textDisabled,
    borderSize: 1.0,
    labelText: 'Tipo de Item',
    items: [DropdownMenuItem<String>(value: viewModel.type, child: Text(viewModel.type))],
    value: viewModel.type,
    onChanged: (_) {},
  );
  final valueVM = ActionInputViewModel(
    style: ActionInputStyle.primary,
    labelText: 'Valor',
    controller: valueController,
    keyboardType: TextInputType.number,
    formatter: ActionTypeInputFormatter.decimal2Fixed,
    borderColor: textDisabled,
    borderSize: 1.0,
  );
  final saveBtnVM = ActionButtonViewModel(
    size: ActionButtonSize.medium,
    style: ActionButtonStyle.primary,
    text: 'Salvar',
    textColor: brandWhite,
  );
  final cardVM = ActionCardAddItemViewModel(
    style: ActionCardAddItemStyle.primary,
    nameInput: nameVM,
    quantityInput: quantityVM,
    typeDropdown: typeVM,
    valueInput: valueVM,
    addButton: saveBtnVM,
    onAddPressed: () {
      final title = nameController.text.trim();
      final quantityText = quantityController.text.trim();
      final value = valueController.text.trim();
      if (title.isEmpty) return;
      final qty = quantityText.isEmpty ? null : int.tryParse(quantityText);
      viewModel.updateItem(index: index, itemTitle: title, quantity: qty, value: value.isEmpty ? null : value);
      Navigator.of(context).pop();
    },
  );
  showDialog(
    context: context,
    builder: (_) => Dialog(
      backgroundColor: brandWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ActionCardAddItem.instantiate(viewModel: cardVM),
      ),
    ),
  );
}


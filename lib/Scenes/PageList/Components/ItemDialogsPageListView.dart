import 'package:flutter/material.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Inputs/action_input_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Inputs/currency_brl_input_formatter.dart';
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
  final descriptionController = TextEditingController();
  final nameVM = ActionInputViewModel(
    style: ActionInputStyle.primary,
    labelText: 'Nome item',
    controller: nameController,
    borderColor: textDisabled,
    borderSize: 0.5,
  );
  final quantityVM = ActionInputViewModel(
    style: ActionInputStyle.primary,
    labelText: 'Quantidade',
    controller: quantityController,
    keyboardType: TextInputType.number,
    formatter: ActionTypeInputFormatter.digitsOnly,
    borderColor: textDisabled,
    borderSize: 0.5,
  );
  final typeVM = ActionDropdownViewModel<String>(
    style: ActionDropdownStyle.primary,
    borderColor: textDisabled,
    borderSize: 0.5,
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
    formatter: ActionTypeInputFormatter.currencyBRL,
    borderColor: textDisabled,
    borderSize: 0.5,
  );
  final descriptionVM = ActionInputViewModel(
    style: ActionInputStyle.primary,
    labelText: 'Descrição',
    controller: descriptionController,
    borderColor: textDisabled,
    borderSize: 0.5,
  );
  final addBtnVM = ActionButtonViewModel(
    size: ActionButtonSize.medium,
    style: ActionButtonStyle.primary,
    text: 'Adicionar',
    textColor: brandWhite,
  );
  final bool isCurrency = viewModel.isCurrency;
  final cardVM = ActionCardAddItemViewModel(
    style: ActionCardAddItemStyle.primary,
    nameInput: nameVM,
    quantityInput: quantityVM,
    typeDropdown: typeVM,
    valueInput: valueVM,
    descriptionInput: isCurrency ? null : descriptionVM,
    isCurrency: isCurrency,
    addButton: addBtnVM,
    onAddPressed: () {
      final title = nameController.text.trim();
      if (title.isEmpty) return;
      if (isCurrency) {
        final quantityText = quantityController.text.trim();
        final value = valueController.text.trim();
        final normalized = value.isEmpty ? null : CurrencyBRLInputFormatter.normalizeToDecimal(value);
        final qty = quantityText.isEmpty ? null : int.tryParse(quantityText);
        viewModel.addItem(itemTitle: title, quantity: qty, value: normalized);
      } else {
        final description = descriptionController.text.trim();
        viewModel.addItem(itemTitle: title, quantity: null, value: description.isEmpty ? null : description);
      }
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
  required int itemId,
  required String currentTitle,
  int? currentQuantity,
  String? currentValue,
}) {

  final nameController = TextEditingController(text: currentTitle);
  final quantityController = TextEditingController(text: currentQuantity?.toString() ?? '');
  final valueController = TextEditingController(text: currentValue ?? '');
  final descriptionController = TextEditingController(text: currentValue ?? '');
  final nameVM = ActionInputViewModel(
    style: ActionInputStyle.primary,
    labelText: 'Nome item',
    controller: nameController,
    borderColor: textDisabled,
    borderSize: 0.5,
  );
  final quantityVM = ActionInputViewModel(
    style: ActionInputStyle.primary,
    labelText: 'Quantidade',
    controller: quantityController,
    keyboardType: TextInputType.number,
    formatter: ActionTypeInputFormatter.digitsOnly,
    borderColor: textDisabled,
    borderSize: 0.5,
  );
  final typeVM = ActionDropdownViewModel<String>(
    style: ActionDropdownStyle.primary,
    borderColor: textDisabled,
    borderSize: 0.5,
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
    formatter: ActionTypeInputFormatter.currencyBRL,
    borderColor: textDisabled,
    borderSize: 0.5,
  );
  final descriptionVM = ActionInputViewModel(
    style: ActionInputStyle.primary,
    labelText: 'Descrição',
    controller: descriptionController,
    borderColor: textDisabled,
    borderSize: 0.5,
  );
  final saveBtnVM = ActionButtonViewModel(
    size: ActionButtonSize.medium,
    style: ActionButtonStyle.primary,
    text: 'Salvar',
    textColor: brandWhite,
  );
  final bool isCurrency = viewModel.isCurrency;
  final cardVM = ActionCardAddItemViewModel(
    style: ActionCardAddItemStyle.primary,
    title: 'Editar item',
    nameInput: nameVM,
    quantityInput: quantityVM,
    typeDropdown: typeVM,
    valueInput: valueVM,
    descriptionInput: isCurrency ? null : descriptionVM,
    isCurrency: isCurrency,
    addButton: saveBtnVM,
    onAddPressed: () {
      final title = nameController.text.trim();
      if (title.isEmpty) return;
      if (isCurrency) {
        final quantityText = quantityController.text.trim();
        final value = valueController.text.trim();
        final normalized = value.isEmpty ? null : CurrencyBRLInputFormatter.normalizeToDecimal(value);
        final qty = quantityText.isEmpty ? null : int.tryParse(quantityText);
        viewModel.updateItem(itemId: itemId, itemTitle: title, quantity: qty, value: normalized);
      } else {
        final description = descriptionController.text.trim();
        viewModel.updateItem(itemId: itemId, itemTitle: title, quantity: null, value: description.isEmpty ? null : description);
      }
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


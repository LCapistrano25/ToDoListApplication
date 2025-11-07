import 'package:arc_to_do_list/DesignSytem/Components/Buttons/action_button_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/DropDown/action_dropdown_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Inputs/action_input_view_model.dart';
import 'package:flutter/material.dart';

enum CardAddItemStyle { primary, secondary }

class CardAddItemViewModel {
  final CardAddItemStyle style;
  final ActionInputViewModel nameInput;
  final ActionDropdownViewModel<String> typeDropdown;
  final ActionInputViewModel valueInput;
  final ActionButtonViewModel addButton;
  final VoidCallback? onAddPressed;

  CardAddItemViewModel({
    required this.style,
    required this.nameInput,
    required this.typeDropdown,
    required this.valueInput,
    required this.addButton,
    this.onAddPressed,
  });
}

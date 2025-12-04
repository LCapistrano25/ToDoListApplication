import 'package:arc_to_do_list/DesignSytem/Components/Buttons/ElevateButton/action_button_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/DropDown/action_dropdown_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Inputs/action_input_view_model.dart';
import 'package:flutter/material.dart';

enum ActionCardAddItemStyle { primary, secondary }

class ActionCardAddItemViewModel {
  final ActionCardAddItemStyle style;
  final ActionInputViewModel nameInput;
  final ActionInputViewModel quantityInput;
  final ActionDropdownViewModel<String> typeDropdown;
  final ActionInputViewModel valueInput;
  final ActionButtonViewModel addButton;
  final VoidCallback? onAddPressed;

  ActionCardAddItemViewModel({
    required this.style,
    required this.nameInput,
    required this.quantityInput,
    required this.typeDropdown,
    required this.valueInput,
    required this.addButton,
    this.onAddPressed,
  });
}

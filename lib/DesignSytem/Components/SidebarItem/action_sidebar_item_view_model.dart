import 'package:arc_to_do_list/DesignSytem/Components/Sidebar/action_sidebar.dart';
import 'package:flutter/material.dart';

enum ActionSidebarItemStyle {
  primary,
  secundary
}

class ActionSidebarItemViewModel {
  final ActionSidebarItemStyle style;
  final String label;
  final IconData icon;
  final int index;
  final ActionSidebarDelegate? delegate;
  final bool isSelected;

  const ActionSidebarItemViewModel({
    required this.style,
    required this.label,
    required this.icon,
    required this.index,
    this.delegate,
    this.isSelected = false,
  });

  ActionSidebarItemViewModel copyWith({
    ActionSidebarItemStyle? style,
    String? label,
    IconData? icon,
    int? index,
    ActionSidebarDelegate? delegate,
    bool? isSelected,
  }) {
    return ActionSidebarItemViewModel(
      style: style ?? this.style,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      index: index ?? this.index,
      delegate: delegate ?? this.delegate,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}


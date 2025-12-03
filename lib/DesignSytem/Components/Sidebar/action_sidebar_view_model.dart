import 'package:arc_to_do_list/DesignSytem/Components/SidebarItem/action_sidebar_item_view_model.dart';
import 'package:flutter/material.dart';

enum ActionSidebarStyle {
  primary,
  secundary
}

class ActionSidebarViewModel {
  final ActionSidebarStyle style;
  final List<ActionSidebarItemViewModel> items;
  final Widget? title;
  final int selectedIndex;

  ActionSidebarViewModel({
    required this.style,
    required this.items,
    this.title,
    required this.selectedIndex,
  });
}

import 'package:arc_to_do_list/DesignSytem/Components/SidebarItem/action_sidebar_item_view_model.dart';

enum ActionSidebarStyle {
  primary,
  secundary
}

class ActionSidebarViewModel {
  final ActionSidebarStyle style;
  final List<ActionSidebarItemViewModel> items;
  final dynamic title;
  final int selectedIndex;

  ActionSidebarViewModel({
    required this.style,
    required this.items,
    required this.title,
    required this.selectedIndex,
  });
}

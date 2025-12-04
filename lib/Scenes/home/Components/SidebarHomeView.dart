
import 'package:arc_to_do_list/DesignSytem/Components/Sidebar/action_sidebar.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Sidebar/action_sidebar_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/SidebarItem/action_sidebar_item_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/icons.dart';

ActionSidebar sidebar(ActionSidebarDelegate delegate, int selectedIndex) {  
  ActionSidebarStyle style = ActionSidebarStyle.primary;
  ActionSidebarItemStyle styleItem = ActionSidebarItemStyle.primary;

  if (style == ActionSidebarStyle.primary) {
    styleItem = ActionSidebarItemStyle.primary;
  } else if (style == ActionSidebarStyle.secundary) {
    styleItem = ActionSidebarItemStyle.secundary;
  } 

  final ActionSidebarViewModel viewModel = ActionSidebarViewModel(
    style: style,
    selectedIndex: selectedIndex,
    items: [
      ActionSidebarItemViewModel(
        style: styleItem,
        icon: AppIcons.idea,
        label: 'Notas',
        index: 0,
        delegate: delegate,
        isSelected: selectedIndex == 0,
      ),
      ActionSidebarItemViewModel(
        style: styleItem,
        icon: AppIcons.add,
        label: 'Criar Lista',
        index: 1,
        delegate: delegate,
        isSelected: selectedIndex == 1,
      ),
      ActionSidebarItemViewModel(
        style: styleItem,
        icon: AppIcons.archive,
        label: 'Arquivo',
        index: 2,
        delegate: delegate,
        isSelected: selectedIndex == 2,
      ),
      ActionSidebarItemViewModel(
        style: styleItem,
        icon: AppIcons.logout,
        label: 'Sair',
        index: 3,
        delegate: delegate,
        isSelected: selectedIndex == 3,
      ),
    ],
  );
  return ActionSidebar.instantiate(viewModel: viewModel, delegate: delegate);
}
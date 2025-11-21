import 'package:arc_to_do_list/DesignSytem/Components/IconButton/action_icon_button.dart';
import 'package:arc_to_do_list/DesignSytem/Components/IconButton/action_icon_button_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Sidebar/action_sidebar.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Sidebar/action_sidebar_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/SidebarItem/action_sidebar_item_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/colors.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/icons.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/styles.dart';
import 'package:arc_to_do_list/Scenes/home/HomeViewModel.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel viewModel;

  const HomeView({super.key, required this.viewModel});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> implements ActionIconButtonDelegate {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: menuIconButton(this),
        centerTitle: true, // Adicionado para centralizar o título
        title: Text("To Do List", style: poppinsRegular20),
      ),
      drawer: sidebar(),  
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  void onClick(ActionIconButtonViewModel viewModel) {
    Scaffold.of(context).openDrawer();
  }
}

ActionIconButton menuIconButton(ActionIconButtonDelegate delegate) {
  final ActionIconButtonViewModel viewModel = ActionIconButtonViewModel(
    icon: AppIcons.menu,
    color: black
  );
  return ActionIconButton.initialize(viewModel: viewModel, delegate: delegate);
}

ActionSidebar sidebar() {
  final ActionSidebarViewModel viewModel = ActionSidebarViewModel(
    title: 'To Do List',
    style: ActionSidebarStyle.primary,
    items: [
      ActionSidebarItemViewModel(
        style: ActionSidebarItemStyle.primary,
        icon: AppIcons.menu,
        label: 'Home',
      ),
      ActionSidebarItemViewModel(
        style: ActionSidebarItemStyle.primary,
        icon: AppIcons.settings,
        label: 'Settings',
      ),
    ],
  );
  return ActionSidebar.instantiate(viewModel: viewModel);
}
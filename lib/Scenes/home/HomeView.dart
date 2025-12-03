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

class _HomeViewState extends State<HomeView> 
implements ActionIconButtonDelegate, ActionSidebarDelegate {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: menuIconButton(this),
        centerTitle: true, // Adicionado para centralizar o título
        title: Text("To Do List", style: poppinsRegular20),
      ),
      drawer: sidebar(this, _selectedIndex),  
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
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void onItemSelected(ActionSidebarItemViewModel item) {
    setState(() {
      _selectedIndex = item.index;
    });
    Navigator.pop(context);
  }
}

ActionIconButton menuIconButton(ActionIconButtonDelegate delegate) {
  final ActionIconButtonViewModel viewModel = ActionIconButtonViewModel(
    icon: AppIcons.menu,
    color: black
  );
  return ActionIconButton.initialize(viewModel: viewModel, delegate: delegate);
}

ActionSidebar sidebar(ActionSidebarDelegate delegate, int selectedIndex) {  
  final ActionSidebarViewModel viewModel = ActionSidebarViewModel(
    title: RichText(
      text: TextSpan(
        text: 'To Do List',
        style: poppinsRegular20.copyWith(color: black),
      ),
    ),
    style: ActionSidebarStyle.primary,
    selectedIndex: selectedIndex,
    items: [
      ActionSidebarItemViewModel(
        style: ActionSidebarItemStyle.primary,
        icon: AppIcons.menu,
        label: 'Home',
        index: 0,
        delegate: delegate,
        isSelected: selectedIndex == 0,
      ),
      ActionSidebarItemViewModel(
        style: ActionSidebarItemStyle.primary,
        icon: AppIcons.settings,
        label: 'Settings',
        index: 1,
        delegate: delegate,
        isSelected: selectedIndex == 1,
      ),
    ],
  );
  return ActionSidebar.instantiate(viewModel: viewModel, delegate: delegate);
}

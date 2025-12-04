import 'package:arc_to_do_list/DesignSytem/Components/Buttons/action_button.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Buttons/action_button_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/CardItemList/action_card_item_list.dart';
import 'package:arc_to_do_list/DesignSytem/Components/CardItemList/action_card_item_list_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/IconButton/action_icon_button.dart';
import 'package:arc_to_do_list/DesignSytem/Components/IconButton/action_icon_button_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Buttons/action_button.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Buttons/action_button_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Loads/action_load.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Loads/action_load_view_model.dart';
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
implements ActionIconButtonDelegate, ActionSidebarDelegate, ActionButtonDelegate {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadItems();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: menuIconButton(this),
        actions: [
          refreshIconButton(this),
        ],
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
            Expanded(
              child: ValueListenableBuilder<LoadStatus>(
                valueListenable: widget.viewModel.status,
                builder: (context, status, _) {
                  if (status == LoadStatus.loading) {
                    return Center(child: showLoading());
                  }
                  if (status == LoadStatus.error) {
                    return const Center(child: Text('Erro ao carregar'));
                  }
                  if (status == LoadStatus.empty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: Text(
                          'Minha lista de tarefas é igual a Wi-Fi de vizinho: sempre aparece cheia, mas quase nunca funciona.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textSecondary,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 1.40,
                          ),
                        ),
                      ),
                    );
                  }
                  return ValueListenableBuilder<List<Map<String, dynamic>>>(
                    valueListenable: widget.viewModel.items,
                    builder: (context, items, __) {
                      if (items.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              'Minha lista de tarefas é igual a Wi-Fi de vizinho: sempre aparece cheia, mas quase nunca funciona.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF7E8392),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                            ),
                          ),
                        );
                      }
                      return ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final title = item['title'] as String? ?? '';
                          final type = item['list_type'] as String? ?? '';
                          return cardItemList(title: title, type: type);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
      floatingActionButton: addButton(this),
    );
  }

  @override
  void onClick(ActionIconButtonViewModel viewModel) {
    if (viewModel.icon == AppIcons.menu) {
      _scaffoldKey.currentState?.openDrawer();
      return;
    }

    if (viewModel.icon == AppIcons.refresh) {
      widget.viewModel.loadItems();
      return;
    }
  }

  void onActionButtonClick(ActionButtonViewModel viewModel) {
    if (viewModel.icon == AppIcons.add) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ação: Adicionar (Button)')),
      );
      return;
    }
  }

  @override
  void onItemSelected(ActionSidebarItemViewModel item) {
    setState(() {
      _selectedIndex = item.index;
    });

    if (item.index == 3) {
      Navigator.pop(context);
      widget.viewModel.coordinator.goToLogin();
      return;
    }

    Navigator.pop(context);
  }
}

ActionIconButton menuIconButton(ActionIconButtonDelegate delegate) {
  final ActionIconButtonViewModel viewModel = ActionIconButtonViewModel(
    icon: AppIcons.menu,
    color: black,
    size: 30,
  );
  return ActionIconButton.initialize(viewModel: viewModel, delegate: delegate);
}

ActionIconButton refreshIconButton(ActionIconButtonDelegate delegate) {
  final ActionIconButtonViewModel viewModel = const ActionIconButtonViewModel(
    icon: AppIcons.refresh,
    size: 30,
  );
  return ActionIconButton.initialize(viewModel: viewModel, delegate: delegate);
}

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

ActionCardItemList cardItemList({required String title, required String type}) {
 ActionCardItemListStyle style = ActionCardItemListStyle.primary;

  final ActionCardItemListViewModel viewModel = ActionCardItemListViewModel(
    style: style,
    title: title,
    type: type,
  );

  return ActionCardItemList.instantiate(viewModel: viewModel);
}

ActionLoad showLoading() {
    final vm = ActionLoadViewModel(4, 48, ActionLoadType.primary);
    return ActionLoad.initialize(viewModel: vm);
  }

Widget addButton(ActionButtonDelegate delegate) {
  final ActionButtonViewModel viewModel = ActionButtonViewModel(
    style: ActionButtonStyle.primary,
    size: ActionButtonSize.iconOnlyLarge,
    icon: AppIcons.add,
    iconColor: Colors.white,
  );
  return FloatingActionButton(
    onPressed: () => delegate.onActionButtonClick(viewModel),
    backgroundColor: primaryColor,
    child: Icon(viewModel.icon, color: viewModel.iconColor),
  );
}


import 'package:arc_to_do_list/DesignSytem/Components/Buttons/FloatingButton/action_floating_button.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Buttons/FloatingButton/action_floating_button_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/IconButton/action_icon_button.dart';
import 'package:arc_to_do_list/DesignSytem/Components/IconButton/action_icon_button_view_model.dart';

import 'package:arc_to_do_list/DesignSytem/Components/Sidebar/action_sidebar.dart';
import 'package:arc_to_do_list/DesignSytem/Components/SidebarItem/action_sidebar_item_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/colors.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/icons.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/styles.dart';
import 'package:arc_to_do_list/Scenes/Home/Components/ActionCreateList.dart';
import 'package:arc_to_do_list/Scenes/Home/Components/CardItemListHomeView.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Cards/CardList/action_card_list.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Cards/CardList/action_card_list_view_model.dart';
import 'package:arc_to_do_list/Scenes/Home/Components/FloatingButtonHomeView.dart';
import 'package:arc_to_do_list/Scenes/Home/Components/IconButtonHomeView.dart';
import 'package:arc_to_do_list/Scenes/Home/Components/LoadHomeView.dart';
import 'package:arc_to_do_list/Scenes/Home/Components/SidebarHomeView.dart';
import 'package:arc_to_do_list/Scenes/Home/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:arc_to_do_list/models/list_summary.dart';

enum HomeViewIndex {
  items,
  createList,
  archive,
  logout,
}

class HomeView extends StatefulWidget {
  final HomeViewModel viewModel;
  const HomeView({super.key, required this.viewModel});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> 
implements ActionIconButtonDelegate, ActionSidebarDelegate, ActionFloatingButtonDelegate, ActionCardItemListDelegate {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  List<ListSummary> items = [];
  List<String> typeList = [];
  
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadTypeList();
    widget.viewModel.loadItems();

    widget.viewModel.items.addListener(() {
      setState(() {
        items = widget.viewModel.items.value;
      });
    });
    widget.viewModel.typeList.addListener(() {
      setState(() {
        typeList = widget.viewModel.typeList.value.map((e) => e.type).toList();
      });
    });
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
                  return ValueListenableBuilder<List<ListSummary>>(
                    valueListenable: widget.viewModel.items,
                    builder: (context, items, __) {
                      if (items.isEmpty) {
                        return listEmpty();
                      }
                      return ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final id = item.id;
                          final title = item.title;
                          final type = item.listType;
                          return cardItemList(id: id, title: title, type: type, delegate: this);
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

  @override
  void onActionFloatingButtonClick(ActionFloatingButtonViewModel viewModel) {
    if (viewModel.icon == AppIcons.add) {
      popUpList(
        context: context,
        onCreate: (title, type) {
          widget.viewModel.createItem(title: title, type: type);
        },
        onCancel: () {},
        typeItems: typeList,
      );
      return;
    }
  }

  @override
  void onTap(ActionCardItemListViewModel viewModel) {
    widget.viewModel.coordinator.goToPageList(title: viewModel.title, type: viewModel.type, idList: viewModel.id);
  }

  @override
  void onItemSelected(ActionSidebarItemViewModel item) {
    setState(() {
      _selectedIndex = item.index;
    });

    if (item.index == HomeViewIndex.items.index) {
      widget.viewModel.loadItems();
      return;
    }

    if (item.index == HomeViewIndex.createList.index) {
      widget.viewModel.loadTypeList();
      _scaffoldKey.currentState?.closeDrawer();
      _selectedIndex = 0;
      popUpList(
        context: context,
        onCreate: (title, type) {
          widget.viewModel.createItem(title: title, type: type);
        },
        onCancel: () {},
        typeItems: typeList,
      );
      return;
    }

    if (item.index == HomeViewIndex.logout.index) {
      Navigator.pop(context);
      widget.viewModel.coordinator.goToLogin();
      return;
    }

    Navigator.pop(context);
  }
}

Widget listEmpty() {
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

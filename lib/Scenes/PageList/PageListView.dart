import 'package:flutter/material.dart';
import 'package:arc_to_do_list/DesignSytem/Components/IconButton/action_icon_button.dart';
import 'package:arc_to_do_list/DesignSytem/Components/IconButton/action_icon_button_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/icons.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/styles.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Cards/CardItemInList/action_card_item_in_list.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Cards/CardItemInList/action_card_item_in_list_view_model.dart';
import 'package:arc_to_do_list/Scenes/PageList/PageListViewModel.dart';
import 'package:arc_to_do_list/Scenes/PageList/Components/IconButtonPageListView.dart';
import 'package:arc_to_do_list/Scenes/PageList/Components/LoadPageListView.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Buttons/FloatingButton/action_floating_button.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Buttons/FloatingButton/action_floating_button_view_model.dart';
import 'package:arc_to_do_list/Scenes/Home/Components/FloatingButtonHomeView.dart';
import 'package:arc_to_do_list/Scenes/PageList/Components/ItemDialogsPageListView.dart';
import 'package:arc_to_do_list/models/page_list_item.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Inputs/currency_brl_input_formatter.dart';

class PageListView extends StatefulWidget {
  final PageListViewModel viewModel;

  const PageListView({super.key, required this.viewModel});

  @override
  State<PageListView> createState() => _PageListViewState();
}

class _PageListViewState extends State<PageListView>
    implements ActionIconButtonDelegate, ActionCardItemInListDelegate, ActionFloatingButtonDelegate {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        leading: backIconButton(this),
        actions: [
          refreshIconButton(this),
        ],
        centerTitle: true,
        title: Text(widget.viewModel.title, style: poppinsRegular20),
      ),
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
                  return ValueListenableBuilder<List<PageListItem>>(
                    valueListenable: widget.viewModel.items,
                    builder: (context, items, __) {
                      if (items.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              'Nenhum item nesta lista.',
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
                          final id = item.id;
                          final title = item.title;
                          final type = item.type;
                          final quantity = item.quantity;
                          final value = item.value;
                          final formattedValue = value == null || value.isEmpty
                              ? null
                              : CurrencyBRLInputFormatter.formatFromText(value);
                          final vm = ActionCardItemInListViewModel(
                            id: id,
                            style: ActionCardItemInListStyle.primary,
                            title: title,
                            type: type,
                            quantity: quantity,
                            value: formattedValue,
                            editIcon: AppIcons.edit,
                            deleteIcon: AppIcons.delete,
                          );
                          return ActionCardItemInList.instantiate(viewModel: vm, delegate: this);
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
    if (viewModel.icon == AppIcons.arrowBack) {
      Navigator.of(context).pop();
      return;
    }
    if (viewModel.icon == AppIcons.refresh) {
      widget.viewModel.loadItems();
      return;
    }
  }

  void _performDeleteByViewModel(ActionCardItemInListViewModel viewModel) {
    widget.viewModel.deleteItem(itemId: viewModel.id);
  }

  void _performEditByViewModel(ActionCardItemInListViewModel viewModel) {
    showEditItemDialog(context, widget.viewModel, itemId: viewModel.id, currentTitle: viewModel.title, currentQuantity: viewModel.quantity, currentValue: viewModel.value);
  }

  @override
  void onEdit(ActionCardItemInListViewModel viewModel) {
    _performEditByViewModel(viewModel);
  }

  @override
  void onDelete(ActionCardItemInListViewModel viewModel) {
    _performDeleteByViewModel(viewModel);
  }

  @override
  void onActionFloatingButtonClick(ActionFloatingButtonViewModel viewModel) {
    if (viewModel.icon == AppIcons.add) {
      showAddItemDialog(context, widget.viewModel);
      return;
    }
  }

  
}

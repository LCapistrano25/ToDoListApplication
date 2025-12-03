import 'package:arc_to_do_list/DesignSytem/Components/Sidebar/action_sidebar_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/SidebarItem/action_sidebar_item.dart';
import 'package:arc_to_do_list/DesignSytem/Components/SidebarItem/action_sidebar_item_view_model.dart';
import 'package:flutter/material.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/colors.dart';

abstract class ActionSidebarDelegate {
  void onItemSelected(ActionSidebarItemViewModel item);
}

class ActionSidebar extends StatelessWidget {
  final ActionSidebarViewModel viewModel;
  final ActionSidebarDelegate? delegate;

  const ActionSidebar._({
    required this.viewModel,
    this.delegate,
  });

  static ActionSidebar instantiate({
    required ActionSidebarViewModel viewModel,
    ActionSidebarDelegate? delegate,
  }) {
    return ActionSidebar._(
      viewModel: viewModel,
      delegate: delegate,
    );
  }

  Color _getTextColor() {
    Color? color = black;

    switch(viewModel.style) {
      case ActionSidebarStyle.primary:
        color = black;
        break;
      case ActionSidebarStyle.secundary:
        color = brandWhite;
        break;
    }
    return color;
  }

  Color _getBackgroundColor() {
    Color? color = black;

    switch(viewModel.style) {
      case ActionSidebarStyle.primary:
          color = brandWhite;
          break;
      case ActionSidebarStyle.secundary:
          color = brandNeutralDark;
          break;
    }

    return color;
  }

  List<Color> _getTitleColor() {
    Color? color1 = black;
    Color? color2 = primaryColor;

    switch(viewModel.style) {
      case ActionSidebarStyle.primary:
        color1 = black;
        color2 = primaryColor;
        break;
      case ActionSidebarStyle.secundary:
        color1 = brandWhite;
        color2 = primaryColor;
        break;
    }
    return [color1, color2];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: _getBackgroundColor(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              if (viewModel.title != null)
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'To do',
                        style: TextStyle(
                          color: _getTitleColor()[0],
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                      TextSpan(
                        text: ' List',
                        style: TextStyle(
                          color: _getTitleColor()[1],
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),


              const SizedBox(height: 16),

              /// Lista de Itens
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.items.length,
                  itemBuilder: (_, index) {
                    final item = viewModel.items[index];
                    final effectiveItem = item.copyWith(
                      isSelected: item.index == viewModel.selectedIndex,
                    );
                    return ActionSidebarItem.instantiate(
                      viewModel: effectiveItem,
                      onTap: (selectedItem) {
                        delegate?.onItemSelected(selectedItem);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

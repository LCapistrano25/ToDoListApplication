import 'package:flutter/material.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/colors.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Cards/CardList/action_card_list_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Dialogs/action_confirm_delete_dialog.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Dialogs/action_confirm_delete_dialog_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/icons.dart';

abstract class ActionCardItemListDelegate {
  void onTap(ActionCardItemListViewModel viewModel);
  void onDelete(ActionCardItemListViewModel viewModel);
}

class ActionCardItemList extends StatelessWidget {
  final ActionCardItemListViewModel viewModel;
  final ActionCardItemListDelegate? delegate;

  const ActionCardItemList._({
    required this.viewModel,
    this.delegate,
  });

  static ActionCardItemList instantiate({
    required ActionCardItemListViewModel viewModel,
    ActionCardItemListDelegate? delegate,
  }) {
    return ActionCardItemList._(
      viewModel: viewModel,
      delegate: delegate,
    );
  }

  Color _getBackgroundColor() {
    if (viewModel.backgroundColor != null) return viewModel.backgroundColor!;
    switch (viewModel.style) {
      case ActionCardItemListStyle.primary:
        return brandWhite;
      case ActionCardItemListStyle.secondary:
        return alternativeColor;
    }
  }

  Color _getTitleColor() {
    if (viewModel.titleColor != null) return viewModel.titleColor!;
    switch (viewModel.style) {
      case ActionCardItemListStyle.primary:
        return textMain;
      case ActionCardItemListStyle.secondary:
        return textSecondary;
    }
  }

  Color _getSubtitleColor() {
    if (viewModel.subtitleColor != null) return viewModel.subtitleColor!;
    switch (viewModel.style) {
      case ActionCardItemListStyle.primary:
        return textSecondary;
      case ActionCardItemListStyle.secondary:
        return textDisabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = viewModel.width;
    final double height = viewModel.height;

    final Widget content = Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: _getBackgroundColor(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 25,
            top: 12,
            child: SizedBox(
              height: 56,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 239,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 239,
                          child: Text(
                            viewModel.title,
                            style: TextStyle(
                              color: _getTitleColor(),
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 1.20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          viewModel.type,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _getSubtitleColor(),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 1.40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (viewModel.deleteIcon != null)
            Positioned(
              right: 12,
              top: 12,
              child: IconButton(
                icon: Icon(viewModel.deleteIcon, size: 20, color: destructiveColor),
                onPressed: delegate == null
                    ? null
                    : () {
                        final vm = ActionConfirmDeleteDialogViewModel(
                          message: 'Deseja realmente excluir "${viewModel.title}"? Esta ação não pode ser desfeita.',
                        );
                        showDialog<void>(
                          context: context,
                          builder: (_) => ActionConfirmDeleteDialog.instantiate(
                            viewModel: vm,
                            onConfirm: () => delegate!.onDelete(viewModel),
                            onCancel: () {},
                          ),
                        );
                      },
              ),
            ),
        ],
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: delegate == null ? null : () => delegate!.onTap(viewModel),
        child: content,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/colors.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Cards/CardItemInList/action_card_item_in_list_view_model.dart';

abstract class ActionCardItemInListDelegate {
  void onEdit(ActionCardItemInListViewModel viewModel) {}
  void onDelete(ActionCardItemInListViewModel viewModel) {}
}

class ActionCardItemInList extends StatelessWidget {
  final ActionCardItemInListViewModel viewModel;
  final ActionCardItemInListDelegate? delegate;

  const ActionCardItemInList._({
    required this.viewModel,
    this.delegate,
  });

  static ActionCardItemInList instantiate({
    required ActionCardItemInListViewModel viewModel,
    ActionCardItemInListDelegate? delegate,
  }) {
    return ActionCardItemInList._(
      viewModel: viewModel,
      delegate: delegate,
    );
  }

  Color _getBackgroundColor() {
    if (viewModel.backgroundColor != null) return viewModel.backgroundColor!;
    return viewModel.style == ActionCardItemInListStyle.primary
        ? brandWhite
        : alternativeColor;
  }

  Color _getTitleColor() {
    if (viewModel.titleColor != null) return viewModel.titleColor!;
    return viewModel.style == ActionCardItemInListStyle.primary
        ? textMain
        : textSecondary;
  }

  Color _getSubtitleColor() {
    if (viewModel.subtitleColor != null) return viewModel.subtitleColor!;
    return viewModel.style == ActionCardItemInListStyle.primary
        ? textSecondary
        : textDisabled;
  }

  @override
  Widget build(BuildContext context) {
    final double minHeight = viewModel.height;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: minHeight),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  Expanded(
                    child: Text(
                      viewModel.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: _getTitleColor(),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (viewModel.editIcon != null)
                        IconButton(
                          icon: Icon(viewModel.editIcon, size: 20, color: _getSubtitleColor()),
                          onPressed: delegate == null
                              ? null
                              : () => delegate!.onEdit(viewModel),
                        ),

                      if (viewModel.deleteIcon != null)
                        IconButton(
                          icon: Icon(viewModel.deleteIcon, size: 20, color: destructiveColor),
                          onPressed: delegate == null
                              ? null
                              : () => delegate!.onDelete(viewModel),
                        ),
                    ],
                  ),
               ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      viewModel.type,
                      style: TextStyle(
                        color: _getSubtitleColor(),
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      viewModel.value ?? '',
                      style: TextStyle(
                        color: _getSubtitleColor(),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  if (viewModel.quantity != null)
                    Text(
                      "Qtd: ${viewModel.quantity}",
                      style: TextStyle(
                        color: _getTitleColor(),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

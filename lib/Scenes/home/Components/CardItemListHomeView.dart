
import 'package:arc_to_do_list/DesignSytem/Components/CardItemList/action_card_item_list.dart';
import 'package:arc_to_do_list/DesignSytem/Components/CardItemList/action_card_item_list_view_model.dart';

ActionCardItemList cardItemList({required String title, required String type}) {
 ActionCardItemListStyle style = ActionCardItemListStyle.primary;

  final ActionCardItemListViewModel viewModel = ActionCardItemListViewModel(
    style: style,
    title: title,
    type: type,
  );

  return ActionCardItemList.instantiate(viewModel: viewModel);
}

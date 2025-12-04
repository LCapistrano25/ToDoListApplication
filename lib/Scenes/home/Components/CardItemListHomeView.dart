import 'package:arc_to_do_list/DesignSytem/Components/Cards/CardList/action_card_list.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Cards/CardList/action_card_list_view_model.dart';

ActionCardItemList cardItemList({required int id, required String title, required String type, ActionCardItemListDelegate? delegate}) {
 ActionCardItemListStyle style = ActionCardItemListStyle.primary;

  final ActionCardItemListViewModel viewModel = ActionCardItemListViewModel(
    id: id,
    style: style,
    title: title,
    type: type,
  );

  return ActionCardItemList.instantiate(viewModel: viewModel, delegate: delegate);
}

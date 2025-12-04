import 'package:arc_to_do_list/DesignSytem/Shared/colors.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/icons.dart';
import 'package:arc_to_do_list/DesignSytem/Components/IconButton/action_icon_button.dart';
import 'package:arc_to_do_list/DesignSytem/Components/IconButton/action_icon_button_view_model.dart';

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
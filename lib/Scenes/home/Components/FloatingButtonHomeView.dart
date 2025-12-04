
import 'package:arc_to_do_list/DesignSytem/Components/Buttons/FloatingButton/action_floating_button.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Buttons/FloatingButton/action_floating_button_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/icons.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/colors.dart';

ActionFloatingButton addButton(ActionFloatingButtonDelegate delegate) {
  final ActionFloatingButtonViewModel viewModel = ActionFloatingButtonViewModel(
    style: ActionFloatingButtonStyle.primary,
    size: ActionFloatingButtonSize.iconOnlyLarge,
    icon: AppIcons.add,
    iconColor: brandWhite,
  );
  return ActionFloatingButton.instantiate(viewModel: viewModel, delegate: delegate);
}

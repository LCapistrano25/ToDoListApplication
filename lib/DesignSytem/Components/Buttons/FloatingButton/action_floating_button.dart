import 'package:arc_to_do_list/DesignSytem/Components/Buttons/FloatingButton/action_floating_button_view_model.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/colors.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/styles.dart';
import 'package:flutter/material.dart';

abstract class ActionFloatingButtonDelegate {
  void onActionFloatingButtonClick(ActionFloatingButtonViewModel viewModel);
}

class ActionFloatingButton extends StatelessWidget {
  final ActionFloatingButtonViewModel viewModel;
  final ActionFloatingButtonDelegate? delegate;

  // Construtor privado, chamado pelo 'instantiate'
  const ActionFloatingButton._({
    required this.viewModel,
    this.delegate,
  });
  
  // Método estático para criar a instância do widget
  static ActionFloatingButton instantiate({
    required ActionFloatingButtonViewModel viewModel,
    ActionFloatingButtonDelegate? delegate,
  }) {
    return ActionFloatingButton._(
      viewModel: viewModel,
      delegate: delegate,
    );
  }

  bool get _isDisabled =>
      !viewModel.enabled || viewModel.style == ActionFloatingButtonStyle.disabled;

  // Helper para obter a cor de fundo com base no estilo
  Color _getBackgroundColor() {
    if (viewModel.backgroundColor != null) {
      return viewModel.backgroundColor!;
    }

    if (_isDisabled) {
      return viewModel.style == ActionFloatingButtonStyle.empty
          ? Colors.transparent
          : disabledColor;
    }

    switch (viewModel.style) {
      case ActionFloatingButtonStyle.primary:
        return primaryColor;
      case ActionFloatingButtonStyle.secondary:
        return secondaryColor;
      case ActionFloatingButtonStyle.destructive:
        return destructiveColor;
      case ActionFloatingButtonStyle.disabled:
        return disabledColor;
      case ActionFloatingButtonStyle.empty:
        return Colors.transparent;
    }
  }

  // Helper para obter a cor do texto
  Color _getForegroundColor() {
    if (viewModel.textColor != null) {
      return viewModel.textColor!;
    }

    if (_isDisabled) {
      if (viewModel.style == ActionFloatingButtonStyle.empty) {
        return textDisabled;
      }

      return Colors.white;
    }

    switch (viewModel.style) {
      case ActionFloatingButtonStyle.primary:
        return textMain;
      case ActionFloatingButtonStyle.secondary:
        return textMain;
      case ActionFloatingButtonStyle.destructive:
        return Colors.white;
      case ActionFloatingButtonStyle.empty:
        return textMain;
      case ActionFloatingButtonStyle.disabled:
        return textMain;
    }
  }

  Color _getIconColor() {
    if (viewModel.iconColor != null) {
      return viewModel.iconColor!;
    }

    if (_isDisabled) {
      if (viewModel.style == ActionFloatingButtonStyle.empty) {
        return textDisabled;
      }

      return Colors.white;
    }

    switch (viewModel.style) {
      case ActionFloatingButtonStyle.destructive:
        return Colors.white;
      default:
        return _getForegroundColor();
    }
  }

  BorderSide? _getBorder() {
    Color? color = viewModel.borderColor;

    if (color == null) {
      if (viewModel.style == ActionFloatingButtonStyle.empty) {
        color = _isDisabled ? lightOutline : lightOutline;
      }
    }

    if (color == null) {
      return null;
    }

    return BorderSide(
      color: _isDisabled ? color.withOpacity(0.6) : color,
      width: 1.5,
    );
  }

  // Helper para obter o tamanho do ícone com base no tamanho do botão
  double _getIconSize() {
    switch (viewModel.size) {
      case ActionFloatingButtonSize.iconOnlySmall:
        return 16.0;
      case ActionFloatingButtonSize.iconOnlyMedium:
        return 20.0;
      case ActionFloatingButtonSize.iconOnlyLarge:
        return 24.0;
      case ActionFloatingButtonSize.small:
        return 16.0;
      case ActionFloatingButtonSize.medium:
        return 20.0;
      case ActionFloatingButtonSize.large:
        return 24.0;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (viewModel.size) {
      case ActionFloatingButtonSize.iconOnlySmall:
        return const EdgeInsets.all(8.0);
      case ActionFloatingButtonSize.iconOnlyMedium:
        return const EdgeInsets.all(12.0);
      case ActionFloatingButtonSize.iconOnlyLarge:
        return const EdgeInsets.all(16.0);
      case ActionFloatingButtonSize.small:
        return const EdgeInsets.symmetric(vertical: 8, horizontal: 16);
      case ActionFloatingButtonSize.medium:
        return const EdgeInsets.symmetric(vertical: 12, horizontal: 20);
      case ActionFloatingButtonSize.large:
        return const EdgeInsets.symmetric(vertical: 16, horizontal: 24);
    }
  }

  Size? _getFixedSize() {
    switch (viewModel.size) {
      case ActionFloatingButtonSize.iconOnlySmall:
        return const Size.square(40);
      case ActionFloatingButtonSize.iconOnlyMedium:
        return const Size.square(48);
      case ActionFloatingButtonSize.iconOnlyLarge:
        return const Size.square(56);
      default:
        return null;
    }
  }

  Size _getMinimumSize() {
    switch (viewModel.size) {
      case ActionFloatingButtonSize.small:
        return const Size(64, 40);
      case ActionFloatingButtonSize.medium:
        return const Size(72, 48);
      case ActionFloatingButtonSize.large:
        return const Size(80, 56);
      case ActionFloatingButtonSize.iconOnlySmall:
        return const Size.square(40);
      case ActionFloatingButtonSize.iconOnlyMedium:
        return const Size.square(48);
      case ActionFloatingButtonSize.iconOnlyLarge:
        return const Size.square(56);
    }
  }

  TextStyle _getTextStyle() {
    switch (viewModel.size) {
      case ActionFloatingButtonSize.small:
        return poppinsRegular12;
      case ActionFloatingButtonSize.medium:
        return poppinsRegular14;
      case ActionFloatingButtonSize.large:
        return poppinsRegular16;
      case ActionFloatingButtonSize.iconOnlySmall:
      case ActionFloatingButtonSize.iconOnlyMedium:
      case ActionFloatingButtonSize.iconOnlyLarge:
        return poppinsRegular14;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget? iconWidget = viewModel.icon != null
        ? Icon(
            viewModel.icon,
            size: _getIconSize(),
            color: _getIconColor(),
          )
        : null;

    final Widget? labelWidget = viewModel.text != null
        ? Text(
            viewModel.text!,
            style: _getTextStyle().copyWith(color: _getForegroundColor()),
          )
        : null;

    if (labelWidget != null) {
      return FloatingActionButton.extended(
        onPressed: _isDisabled ? null : () => delegate?.onActionFloatingButtonClick(viewModel),
        backgroundColor: _getBackgroundColor(),
        foregroundColor: _getForegroundColor(),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: _getBorder() ?? BorderSide.none,
        ),
        icon: iconWidget,
        label: labelWidget,
      );
    }

    return FloatingActionButton(
      onPressed: _isDisabled ? null : () => delegate?.onActionFloatingButtonClick(viewModel),
      backgroundColor: _getBackgroundColor(),
      foregroundColor: _getForegroundColor(),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: _getBorder() ?? BorderSide.none,
      ),
      child: iconWidget ?? const SizedBox.shrink(),
    );
  }
}


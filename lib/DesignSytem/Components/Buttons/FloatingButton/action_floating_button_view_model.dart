import 'package:flutter/material.dart';

enum ActionFloatingButtonSize {
  iconOnlySmall,
  iconOnlyMedium,
  iconOnlyLarge,
  small,
  medium,
  large,
}

enum ActionFloatingButtonStyle {
  primary,
  secondary,
  destructive,
  disabled,
  empty,
}

class ActionFloatingButtonViewModel {
  final ActionFloatingButtonSize size;
  final ActionFloatingButtonStyle style;
  final String? text;
  final IconData? icon;
  final bool enabled;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final Color? borderColor;

  ActionFloatingButtonViewModel({
    required this.size,
    required this.style,
    this.text,
    this.icon,
    this.enabled = true,
    this.backgroundColor,
    this.borderColor,
    this.iconColor,
    this.textColor,
  }) : assert(text != null || icon != null, 'ActionFloatingButtonViewModel deve ter pelo menos um texto ou um ícone.');
}
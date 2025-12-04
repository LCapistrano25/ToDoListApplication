import 'package:flutter/material.dart';

enum ActionCardItemInListStyle {
  primary,
  secondary,
}

class ActionCardItemInListViewModel {
  final int id;
  final ActionCardItemInListStyle style;
  final String title;
  final int? quantity;
  final String type;
  final String? value;
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? valueColor;
  final IconData? editIcon;
  final IconData? deleteIcon;

  const ActionCardItemInListViewModel({
    required this.id,
    required this.style,
    required this.title,
    this.quantity,
    required this.type,
    this.value,
    this.width = 388,
    this.height = 110,
    this.backgroundColor,
    this.titleColor,
    this.subtitleColor,
    this.valueColor,
    this.editIcon,
    this.deleteIcon,
  });
}

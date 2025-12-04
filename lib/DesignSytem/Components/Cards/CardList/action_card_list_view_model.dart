import 'package:flutter/material.dart';

enum ActionCardItemListStyle {
  primary,
  secondary,
}

class ActionCardItemListViewModel {
  final int id;
  final ActionCardItemListStyle style;
  final String title;
  final String type;
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subtitleColor;

  const ActionCardItemListViewModel({
    required this.id,
    required this.style,
    required this.title,
    required this.type,
    this.width = 379,
    this.height = 80,
    this.backgroundColor,
    this.titleColor,
    this.subtitleColor,
  });
}

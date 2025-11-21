import 'package:flutter/material.dart';

class ActionIconButtonViewModel{
  final IconData icon;
  final Color? color;
  final double? size;
  
  const ActionIconButtonViewModel({
    required this.icon,
    this.color,
    this.size,
  });
}

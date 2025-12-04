import 'package:flutter/material.dart';

class ActionConfirmDeleteDialogViewModel {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final Color? borderColor;
  final double? borderSize;

  const ActionConfirmDeleteDialogViewModel({
    this.title = 'Confirmar deleção',
    this.message = 'Deseja realmente excluir este item? Esta ação não pode ser desfeita.',
    this.confirmText = 'Excluir',
    this.cancelText = 'Cancelar',
    this.borderColor,
    this.borderSize,
  });
}

import 'package:flutter/material.dart';

class ActionCreateListDialogViewModel {
  final String title;
  final String nameLabel;
  final String typeLabel;
  final List<DropdownMenuItem<String>> typeItems;
  final Color? borderColor;
  final double? borderSize;

  ActionCreateListDialogViewModel({
    this.title = 'Criar Lista',
    this.nameLabel = 'Nome Lista',
    this.typeLabel = 'Tipo de lista',
    List<DropdownMenuItem<String>>? typeItems,
    this.borderColor,
    this.borderSize,
  }) : typeItems = typeItems ?? const [
          DropdownMenuItem<String>(
            value: 'Lista de Compras',
            child: Text('Lista de Compras'),
          ),
          DropdownMenuItem<String>(
            value: 'Lista de Tarefas',
            child: Text('Lista de Tarefas'),
          ),
          DropdownMenuItem<String>(
            value: 'Lista de Construção',
            child: Text('Lista de Construção'),
          ),
        ];
}


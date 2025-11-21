import 'package:arc_to_do_list/DesignSytem/Components/Inputs/action_input_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arc_to_do_list/DesignSytem/Shared/colors.dart';

abstract class ActionInputDelegate {
  void onClick(ActionInputViewModel viewModel);
}

class ActionInput extends StatefulWidget {
  final ActionInputViewModel viewModel;
  final ActionInputDelegate? delegate;

  const ActionInput._({
    required this.viewModel,
    this.delegate,
  });

  static ActionInput instantiate({
    required ActionInputViewModel viewModel,
    ActionInputDelegate? delegate,
  }) {
    return ActionInput._(
      viewModel: viewModel,
      delegate: delegate,
    );
  }

  @override
  State<ActionInput> createState() => _ActionInputState();
}

class _ActionInputState extends State<ActionInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

     _controller = widget.viewModel.controller ?? TextEditingController();

    _controller.addListener(() {
      final text = _controller.text;
      widget.viewModel.onChanged?.call(text);
      widget.delegate?.onClick(widget.viewModel);
    });
  }

  @override
  void dispose() {
    // Só descartamos o controller se ele foi criado internamente
    if (widget.viewModel.controller == null) {
        _controller.dispose();
    }
    
    super.dispose();
  }

  Color _getBackgroundColor() {
    switch (widget.viewModel.style) {
      case ActionInputStyle.primary:
        return brandWhite;
      case ActionInputStyle.secondary:
        return alternativeColor;
    }
  }

  BorderSide _getBorder() {
    Color color;
    switch (widget.viewModel.style) {
      case ActionInputStyle.primary:
        color = brandWhite;
        break;
      case ActionInputStyle.secondary:
        color = alternativeColor;
        break;
    }

    return BorderSide(
      color: widget.viewModel.borderColor ?? color,
      width: 1.5,
    );
  }

  Color _getTextColor() {
    switch (widget.viewModel.style) {
      case ActionInputStyle.primary:
        return textTitle;
      case ActionInputStyle.secondary:
        return textSecondary;
    }
  }

  Color _getIconColor() => _getTextColor();

  List<TextInputFormatter> _getFormatters() {
    switch (widget.viewModel.formatter) {
      case ActionTypeInputFormatter.digitsOnly:
        return [FilteringTextInputFormatter.digitsOnly];
      case ActionTypeInputFormatter.singleLine:
        return [FilteringTextInputFormatter.singleLineFormatter];
      case ActionTypeInputFormatter.lettersOnly:
        return [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))];
      case ActionTypeInputFormatter.lettersAndDigits:
        return [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))];
      case ActionTypeInputFormatter.decimal:
        return [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))];
      case ActionTypeInputFormatter.decimal2Fixed:
        return [FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?'))];
      case ActionTypeInputFormatter.global:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;

    return TextField(
      controller: _controller,
      readOnly: viewModel.readOnly,
      enabled: viewModel.enabled,
      obscureText: viewModel.obscureText,
      keyboardType: viewModel.keyboardType,
      textInputAction: viewModel.textInputAction,
      onSubmitted: viewModel.onSubmitted,
      maxLength: viewModel.maxLength,
      buildCounter: viewModel.showCounter ? null : (_, {required int currentLength, required int? maxLength, required bool isFocused}) => null,
      onTap: viewModel.onTap,
      style: TextStyle(color: _getTextColor()),
      inputFormatters: _getFormatters(),
      decoration: InputDecoration(
        labelText: viewModel.labelText,
        labelStyle: TextStyle(color: _getTextColor()),
        hoverColor: _getBackgroundColor(),
        hintText: viewModel.hintText,
        hintStyle: TextStyle(color: _getTextColor().withOpacity(0.6)),
        helperText: viewModel.helperText,
        helperStyle: TextStyle(color: _getTextColor().withOpacity(0.7)),
        errorText: viewModel.errorText,
        errorStyle: const TextStyle(color: destructiveColor),
        prefixIcon: viewModel.prefixIcon != null
            ? Icon(viewModel.prefixIcon, color: viewModel.iconColor ?? _getIconColor())
            : null,
        suffixIcon: viewModel.suffixIcon != null
            ? Icon(viewModel.suffixIcon, color: viewModel.iconColor ?? _getIconColor())
            : null,
        filled: true,
        fillColor: _getBackgroundColor(),
        enabledBorder: OutlineInputBorder(
          borderSide: _getBorder(),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: _getBorder(),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: _getBorder(),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

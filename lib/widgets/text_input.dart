import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInput extends StatelessWidget {
  final Widget? icon;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final String? initialValue;
  final String? placeholder;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaveHandler;
  final void Function()? onIconTapHandler;
  final void Function()? onTapHandler;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final bool? showCursor;
  final FocusNode? focusNode;
  final bool hideErrorMessage;
  final Iterable<String>? autofillHints;
  final String? suffixText;
  final String counterText;
  final TextStyle? suffixStyle;
  final TextAlign textAlign;
  final bool enableInteractiveSelection;
  final bool obscureText;

  TextInput({
    this.icon,
    this.inputType,
    this.inputFormatters,
    this.maxLength,
    this.initialValue,
    this.placeholder,
    this.validator,
    this.onSaveHandler,
    this.onFieldSubmitted,
    this.onIconTapHandler,
    this.onTapHandler,
    this.controller,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.readOnly = false,
    this.showCursor,
    this.focusNode,
    this.hideErrorMessage = false,
    this.autofillHints,
    this.suffixText,
    this.counterText = '',
    this.suffixStyle,
    this.textAlign = TextAlign.start,
    this.enableInteractiveSelection = false,
    this.onEditingComplete,
    this.obscureText = false,
  });

  void _unfocusKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: autofillHints,
      textCapitalization: textCapitalization!,
      focusNode: focusNode,
      readOnly: readOnly,
      showCursor: showCursor,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      controller: controller,
      initialValue: initialValue,
      style: Theme.of(context).textTheme.headline4,
      textAlign: textAlign,
      decoration: InputDecoration(
        suffixText: suffixText,
        suffixStyle: suffixStyle,
        counterText: counterText,
        labelText: placeholder,
        suffixIcon: icon != null
            ? IconButton(
                icon: icon!,
                onPressed: onIconTapHandler,
              )
            : null,
        errorStyle: hideErrorMessage ? TextStyle(height: 0) : null,
      ),
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTapHandler ?? () => _unfocusKeyboard(context),
      onChanged: (String value) {
        if (value.length == maxLength) {
          _unfocusKeyboard(context);
        }
      },
      onSaved: onSaveHandler,
      keyboardType: inputType,
      maxLength: maxLength,
      validator: validator,
      enableInteractiveSelection: enableInteractiveSelection,
      onEditingComplete: onEditingComplete,
      obscureText: obscureText,
    );
  }
}

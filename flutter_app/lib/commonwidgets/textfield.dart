import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextBoxWithTitle extends StatelessWidget {
  final String title;
  final String label;
  final String hint;
  final int maxLength;
  final String inputType;
  final String textCapitalization;
  final bool digitsOnly;
  final ValueChanged changed;
  final FormFieldSetter saved;
  final FormFieldValidator validator;
  final bool onSecure;
  final bool onsaved;
  final bool onValidate;
  final TextEditingController controller;
  final GlobalKey<FormState> key;

  TextBoxWithTitle(
      {this.key,
      this.controller,
      this.title,
      this.label,
      this.hint,
      this.maxLength,
      this.inputType,
      this.changed,
      this.saved,
      this.digitsOnly,
      this.validator,
      this.textCapitalization,
      this.onsaved,
      this.onValidate,
      this.onSecure});

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(shape: BoxShape.rectangle),
      child: new Column(
        children: <Widget>[
          new TextFormField(
            key: key,
            controller: controller,
            maxLength: maxLength != 0 ? maxLength : 50,
            keyboardType: inputType != null && inputType != ''
                ? getType(inputType)
                : null,
            textCapitalization:
                textCapitalization != null && textCapitalization != ''
                    ? getCharacter(textCapitalization)
                    : null,
            inputFormatters: digitsOnly ? getDigits() : null,
            decoration: new InputDecoration(
                labelText: label, hintText: hint, border: OutlineInputBorder()),
            onSaved: saved,
            validator: onValidate ? getValidate() : null,
            obscureText: onSecure != null ? onSecure : false,
          ),
        ],
      ),
    );
  }

  TextCapitalization getCharacter(String text) {
    switch (text) {
      case 'words':
        return TextCapitalization.words;
        break;
      case 'character':
        return TextCapitalization.characters;
        break;
      case 'sentence':
        return TextCapitalization.sentences;
        break;
      default:
        return null;
    }
  }

  TextInputType getType(String type) {
    const List<String> _names = <String>[
      'text',
      'multiline',
      'number',
      'phone',
      'datetime',
      'emailAddress',
      'url',
    ];

    switch (type) {
      case 'text':
        return TextInputType.text;
        break;
      case 'number':
        return TextInputType.number;
        break;
      case 'datetime':
        return TextInputType.datetime;
        break;
      case 'emailAddress':
        return TextInputType.emailAddress;
        break;
      default:
        return null;
    }
  }

  getValidate() {
    if (key.currentState.validate()) controller.text;
  }

  getDigits() {
    WhitelistingTextInputFormatter.digitsOnly;
  }
}

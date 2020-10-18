import 'package:flutter/material.dart';

class ArrowLogInputDropdown extends StatelessWidget {
  final dynamic value;
  final void Function(dynamic) onValueChanged;
  final List<ArrowLogInputDropdownOption> options;
  final String placeholder;

  const ArrowLogInputDropdown({
    @required this.onValueChanged,
    @required this.options,
    @required this.placeholder,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: DropdownButton(
        isExpanded: true,
        style: TextStyle(color: Colors.white),
        value: value,
        focusColor: Colors.black,
        hint: Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            placeholder,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: Colors.white54
            )
          ),
        ),
        selectedItemBuilder: (BuildContext context) {
          return options
            .map((o) => DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(o.text),
              ),
            ))
            .toList();
        },
        iconEnabledColor: Colors.white,
        underline: Container(
          height: 2.0,
          color: Colors.white,
        ),
        items: options
            .map((o) => DropdownMenuItem(
              value: o.value,
              child: Text(o.text, style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black)),
            ))
            .toList(),
        onChanged: onValueChanged,
      ),
    );
  }
}

class ArrowLogInputDropdownOption {
  final dynamic value;
  final String text;

  ArrowLogInputDropdownOption(this.value, this.text);
}
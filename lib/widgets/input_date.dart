import 'package:arrow_log/utils/date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArrowLogInputDate extends StatelessWidget {
  final DateTime date;
  final void Function(DateTime) onDateChanged;

  ArrowLogInputDate({
    @required this.date,
    @required this.onDateChanged
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime selectedValue = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (selectedValue != null) {
          onDateChanged(selectedValue);
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          autofocus: false,
          controller: TextEditingController(
            text: DateUtil.getDayValue(date) == DateUtil.getDayValue(DateTime.now()) ? 'Now' : DateFormat('dd-MM-yyyy').format(date)
          ),
          style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
          validator: (String value) {
            return null;
          }, 
        ),
      ),
    );
  }
}
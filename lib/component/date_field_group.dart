import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class DateFieldGroup extends StatelessWidget {

  final DateTime initiaDate;
  final DateTime startDate;
  final DateTime endDate;

  final SelectableDayPredicate  selectableDayPredicate;

  final DatePickerMode initialDatePickerMode;

  final Widget child;

  final Function(DateTime) onSelect;

  const DateFieldGroup({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.initiaDate,
    required this.selectableDayPredicate,
    this.initialDatePickerMode = DatePickerMode.day,
    required this.child,
    required this.onSelect,
  }):super(key:key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AbsorbPointer(
        child: child,
        ),
      onTap: () async{
        DateTime? selectedDate = await showDatePicker(
          context: context, 
          initialDate: initiaDate, 
          firstDate: startDate, 
          lastDate: endDate,
          selectableDayPredicate: selectableDayPredicate,
          initialDatePickerMode: initialDatePickerMode,);
          if(selectedDate != null && onSelect !=null){
            onSelect(selectedDate);
          }
      },
    );
  }
}
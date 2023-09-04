import 'package:flutter/material.dart';
import 'package:flutter_application_0/model/todo.dart';

class PriorityFiledGroup extends StatefulWidget{

  final Priority initialValue;

  final Function(Priority) onChange;

  final Widget child;

  const PriorityFiledGroup({
    Key? key,
    required this.initialValue,
    required this.onChange,
    required this.child,
  }): super(key: key);

  @override
  _PriorityFileGroupState createState() => _PriorityFileGroupState();
}


class _PriorityFileGroupState extends State<PriorityFiledGroup>{


  GlobalKey<PopupMenuButtonState> popupMenuStateKey = GlobalKey<PopupMenuButtonState>();

  void _onTap(){
    popupMenuStateKey.currentState?.showButtonMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: _onTap,
          child: widget.child,
          behavior: HitTestBehavior.opaque,
          ),
          PopupMenuButton<Priority>(
            key:popupMenuStateKey,
            itemBuilder:(BuildContext context) => Priority.values.map(_buildPriorityPopupMenuItem).toList(),
            onSelected: widget.onChange,
            child: Container(),
          )
      ],);
  }


  PopupMenuItem<Priority> _buildPriorityPopupMenuItem(Priority priority) {
    return PopupMenuItem<Priority>(
      value: priority,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(priority.description),
          Container(
            width: 100,
            height: 5,
            color: priority.color,
          )
        ],
      ),
    );
  }
}
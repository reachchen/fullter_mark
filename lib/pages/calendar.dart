import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_application_0/const/route_argument.dart';
import 'package:flutter_application_0/const/route_url.dart';
import 'package:flutter_application_0/extension/date_time.dart';
import 'package:flutter_application_0/model/todo.dart';
import 'package:flutter_application_0/model/todo_list.dart';

class CalendarPage extends StatefulWidget{

const CalendarPage(this.todoList);

final TodoList todoList;


@override
_CalendarPageState createState() => _CalendarPageState();

  
}

class _CalendarPageState extends State<CalendarPage>{

  CalendarController? _calendarController;
  TodoList? _todoList;
  DateTime? _initialDay;
  Map<DateTime,List<Todo>> _date2TodoMap = {};
  List<Todo> _todosToShow = [];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _todoList = widget.todoList;
    _calendarController = CalendarController();
    _initialDay = DateTime.now().dayTime;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updateData(){

    setState(() {
      _todosToShow.clear();
      _date2TodoMap.clear();
      
    });

  }

  void _initDate2TodoMap(){
    _todoList!.list.forEach((todo) { 
      _date2TodoMap.putIfAbsent(todo.date?? DateTime.now(),()=>[]);
      _date2TodoMap[todo.date]!.add(todo);
    });
    _todosToShow.addAll(_date2TodoMap[_initialDay]??[]);
  }

  void _onTap(Todo todo) async{

    var changedTodo = await Navigator.of(context).pushNamed(EDIT_TODO_PAGE_URL,
        arguments: EditTodoPageArgument(openType: OpenType.Preview, todo: todo));
    if (changedTodo == null) {
      return;
    }
    _todoList!.update(todo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('日历'),
      ),
      body: Column(
        children: <Widget>[
          TableCalendar(
            calendarController: _calendarController,
            locale: 'zh_CN',
            events: _date2TodoMap,
            headerStyle: HeaderStyle(),
            calendarStyle: CalendarStyle(
              todayColor: Colors.transparent,
              todayStyle: TextStyle(color: Colors.black),
            ),
            initialSelectedDay: _initialDay,
            onDaySelected: (DateTime day,List events,List eventts){
              this.setState(() {
                _todosToShow = events.cast<Todo>();
              });
            },
          ),
          Expanded(
            child: _buildTaskListArea(),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskListArea() {
    return ListView.builder(
      itemCount: _todosToShow.length,
      itemBuilder: (context, index) {
        Todo todo = _todosToShow[index];
        return GestureDetector(
          onTap: () => _onTap(todo),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    color: todo.status.color,
                    height: 10,
                    width: 10,
                    margin: EdgeInsets.all(10),
                  ),
                  Text(todo.title),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      size: 15,
                      color: Color(0xffb9b9bc),
                    ),
                    Text(
                      ' ${todo.startTime.hour} - ${todo.endTime.hour}',
                      style: TextStyle(color: Color(0xffb9b9bc)),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Color(0xffececed),
                margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
              )
            ],
          ),
        );
      },
    );
  }


}
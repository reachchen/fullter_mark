import 'package:flutter/material.dart';
import 'package:flutter_application_0/const/route_argument.dart';
import 'package:flutter_application_0/model/network_client.dart';
import 'package:flutter_application_0/pages/about.dart';
import 'package:flutter_application_0/pages/calendar.dart';
import 'package:flutter_application_0/pages/reporter.dart';
import 'package:flutter_application_0/pages/todo_list.dart';
import 'package:flutter_application_0/config/colors.dart';
import 'package:flutter_application_0/model/todo_list.dart';
import 'package:flutter_application_0/const/route_url.dart';
import 'package:flutter_application_0/model/todo.dart';

class TodoEntryPage extends StatefulWidget{

  const TodoEntryPage({Key? key}) :super(key: key);

  @override
  _TodoEntryPageState createState() => _TodoEntryPageState();
}

class _TodoEntryPageState extends State<TodoEntryPage> with WidgetsBindingObserver{

  late int currentIndex;
  late List<Widget> pages;
  late TodoList todoList;
  late String userKey;


  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    WidgetsBinding.instance!.addObserver(this);
    
  }

  

  BottomNavigationBarItem _buildBottomNavigationBarItem(
    String imagePath,
    {
      double? size,
      bool singleImage = false,
    }
  ){
    if(singleImage){
      return BottomNavigationBarItem(
        icon: Image(
          width: size,
          height: size,
          image: AssetImage(imagePath),
      ),
      label: '',
      );
    }
    ImageIcon activeIcon = ImageIcon(
      AssetImage(imagePath),
      size: size,
      color: activeTabIconColor,
    );
    ImageIcon inactiveImageIcon = ImageIcon(
      AssetImage(imagePath),
      size: size,
      color: inactiveTabIconColor,
    );
    return BottomNavigationBarItem(
      activeIcon:activeIcon,
      icon: inactiveImageIcon,
      label: '',
    );
  }

  // _onTabChange(int index) async {
  //   if (index == 2) {
  //     Future todo =  Navigator.of(context).pushNamed(
  //       EDIT_TODO_PAGE_URL,
  //       arguments: EditTodoPageArgument(
  //         openType: OpenType.Add
  //       ),
  //     );
  //     todo.then((value){
  //       index =0;
  //       todoList.add(value);
  //       setState(() {
  //         currentIndex =index;
  //       });
  //     });
  //     return;
  //   }
  //   setState(() {
  //     currentIndex = index;
  //   });
  // }

  _onTabChange(int index) async {
    if (index == 2) {
      var todo = await Navigator.of(context).pushNamed(
        EDIT_TODO_PAGE_URL,
        arguments: EditTodoPageArgument(
          openType: OpenType.Add,
        ),
      );
      if (todo != null) {
        index = 0;
        todoList.add(todo as Todo);
      }
      return;
    }
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    TodoEntryArgument arguments = ModalRoute.of(context)!.settings.arguments as TodoEntryArgument;
    userKey = arguments.userKey;
    todoList = TodoList(userKey);

    pages = <Widget>[
      TodoListPage(todoList: todoList),
      CalendarPage(),
      Container(),
      ReporterPage(),
      AboutPage(todoList: todoList,userKey: userKey),
    ];

  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    todoList.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      NetworkClient.instance().uploadList(todoList.list, userKey);
    }
    if (state == AppLifecycleState.resumed) {
      todoList.syncWithNetwork();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabChange,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          _buildBottomNavigationBarItem('assets/images/lists.png'),
          _buildBottomNavigationBarItem('assets/images/calendar.png'),
          _buildBottomNavigationBarItem('assets/images/add.png',size: 50,singleImage: true,),
          _buildBottomNavigationBarItem('assets/images/report.png'),
          _buildBottomNavigationBarItem('assets/images/about.png')
        ],
      ),
      body: IndexedStack(
        children: pages,
        index: currentIndex,
      ),
    );
  }
    
  }
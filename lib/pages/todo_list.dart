import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget{

  const TodoListPage({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('列表'),
      ),
      body: Center(
      child: Text(
        this.runtimeType.toString(),
      ),
      ),
   );
  }

  
  

}
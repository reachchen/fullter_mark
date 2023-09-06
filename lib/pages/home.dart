import 'package:flutter_application_0/const/route_url.dart';
import 'package:flutter_application_0/const/route_argument.dart';
// import 'package:flutter_application_0/model/login_center.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget{

  void _goToLoginOrTodoEntry(BuildContext context) async {
    // String currentUserKey = await LoginCenter.instance().currentUserKey();
    String currentUserKey = "";
    if (currentUserKey.isEmpty) {
      Navigator.of(context).pushReplacementNamed(LOGIN_PAGE_URL);
    } else {
      Navigator.of(context).pushReplacementNamed(
        TODO_ENTRY_PAGE_URL,
        arguments: TodoEntryArgument(currentUserKey),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _goToLoginOrTodoEntry(context);
    return Container();
  }
}
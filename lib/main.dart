import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_0/model/todo.dart';
import 'package:flutter_application_0/pages/edit_todo.dart';
import 'package:flutter_application_0/pages/login.dart';
import 'package:flutter_application_0/pages/register.dart';
import 'package:flutter_application_0/const/route_url.dart';
import 'package:flutter_application_0/config/colors.dart';
import 'package:flutter_application_0/pages/todo_entry.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_application_0/pages/webview.dart';
import 'package:flutter_application_0/pages/home.dart';
void main() => runApp(MyApp());

Map<String, WidgetBuilder> routes = {
  HOME_PAGE_URL: (context) => HomePage(),
  LOGIN_PAGE_URL: (context) => LoginPage(),
  REGISTER_PAGE_URL: (context) => RegisterPage(),
  TODO_ENTRY_PAGE_URL: (context) => TodoEntryPage(),
  EDIT_TODO_PAGE_URL: (context) =>EditTodoPage(),
  WEB_VIEW_PAGE_URL: (context) => WebViewPage(),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      theme: ThemeData(
        primaryColor: PRIMARY_COLOR,
        indicatorColor: ACCENT_COLOR,
        accentColor: PRIMARY_COLOR,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('zh', 'CN'),
      ],
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        if ([REGISTER_PAGE_URL, LOGIN_PAGE_URL].contains(settings.name)) {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, _, __) => RegisterPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          );
        }else if([EDIT_TODO_PAGE_URL].contains(settings.name)){
          return CupertinoPageRoute<Todo>(
          builder:(context) => EditTodoPage(),
          settings:settings,
          fullscreenDialog:true,);
        }
        return MaterialPageRoute(
          builder: (context)=>LoginPage(),
          settings: settings,
        );
      },
    );
  }
}




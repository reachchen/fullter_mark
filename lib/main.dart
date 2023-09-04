import 'package:flutter/material.dart';
import 'package:flutter_application_0/pages/edit_todo.dart';
import 'package:flutter_application_0/pages/login.dart';
import 'package:flutter_application_0/pages/register.dart';
import 'package:flutter_application_0/const/route_url.dart';
import 'package:flutter_application_0/config/colors.dart';
import 'package:flutter_application_0/pages/todo_entry.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() => runApp(MyApp());

final Map<String, WidgetBuilder> routes = {
  LOGIN_PAGE_URL: (context) => LoginPage(),
  REGISTER_PAGE_URL: (context) => RegisterPage(),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        // if ([REGISTER_PAGE_URL, LOGIN_PAGE_URL].contains(settings.name)) {
        //   return PageRouteBuilder(
        //     settings: settings,
        //     pageBuilder: (context, _, __) => routes[settings.name](context),
        //     transitionsBuilder:
        //         (context, animation, secondaryAnimation, child) {
        //       return FadeTransition(
        //         opacity: animation,
        //         child: child,
        //       );
        //     },
        //   );
        // }
        return MaterialPageRoute(
          builder: (context)=>EditTodoPage(),
          settings: settings,
        );
      },
    );
  }
}




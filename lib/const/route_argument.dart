import 'package:flutter_application_0/model/todo.dart';
class RegisterPageArgument {
  final String className;
  final String url;

  RegisterPageArgument(this.className, this.url);
}

enum OpenType {
  Add,
  Edit,
  Preview,
}

class EditTodoPageArgument {
  OpenType openType = OpenType.Edit;
  final Todo? todo;

  EditTodoPageArgument({required this.openType, this.todo});
}      

class LocationDetailArgument {
  final Location location;

  LocationDetailArgument(this.location);
}

class TodoEntryArgument {
  final String userKey;

  TodoEntryArgument(this.userKey);
}

class WebViewArgument {
  final String url;
  final String title;

  WebViewArgument(this.url, this.title);
}
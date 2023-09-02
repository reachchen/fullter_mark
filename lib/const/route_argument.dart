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
  final OpenType openType;
  final Todo todo;

  EditTodoPageArgument({required this.openType, required this.todo});
}      
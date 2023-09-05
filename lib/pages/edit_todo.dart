import 'package:flutter/material.dart';
import 'package:flutter_application_0/component/date_field_group.dart';
import 'package:flutter_application_0/component/label_group.dart';
import 'package:flutter_application_0/component/prority_filed_group.dart';
import 'package:flutter_application_0/component/time_filed_group.dart';
import 'package:flutter_application_0/const/route_argument.dart';
import 'package:flutter_application_0/extension/date_time.dart';
import 'package:flutter_application_0/extension/time_of_day.dart';
import 'package:flutter_application_0/model/todo.dart';
// import 'package:flutter_application_0/utils/generate_todo.dart';

const TextStyle _labelTextStyle = TextStyle(
  color: Color(0xFF1D1D26),
  fontFamily: 'Avenir',
  fontSize:14.0,);
const EdgeInsets  _labelPadding = const EdgeInsets.fromLTRB(20, 10, 20,20);
const InputBorder _textFormBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Colors.black26,
    width: 0.5,
  ),
);

class EditTodoPage extends StatefulWidget{
  const EditTodoPage({Key? key}) : super(key: key);

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage>{

  OpenType?  _openType ;
  Todo? _todo ;

  // OpenType?  _openType = OpenType.Edit;
  // Todo? _todo = generateTodos(2).first;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Map<OpenType,_OpenTypeConfig> _openTypeConfigMap;

  final TextEditingController _dateTextEditingController = TextEditingController();
  final TextEditingController _startTimeTextEditingController = TextEditingController();
  final TextEditingController _endTimeTextEditingController = TextEditingController();



  @override
  void initState() {
    super.initState();
    _openTypeConfigMap = {
      OpenType.Preview:_OpenTypeConfig('查看TODO',Icons.edit,_edit),
      OpenType.Edit:_OpenTypeConfig('编辑TODO',Icons.check,_submit),
      OpenType.Add:_OpenTypeConfig('添加TODO',Icons.check,_submit),
    
  };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    EditTodoPageArgument arguments = (ModalRoute.of(context)!.settings.arguments) as EditTodoPageArgument;
    _openType = arguments.openType;
    _todo = arguments.todo;
    _dateTextEditingController.text = _todo!.date.toString();
    _startTimeTextEditingController.text = _todo!.startTime.timeString;
    _endTimeTextEditingController.text = _todo!.endTime.timeString;
  }

  @override
  void dispose() {
    super.dispose();
    _dateTextEditingController.dispose();
    _startTimeTextEditingController.dispose();
    _endTimeTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_openTypeConfigMap[_openType]!.title),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: _openTypeConfigMap[_openType]?.onPressed, 
            icon: Icon(
            _openTypeConfigMap[_openType]!.icon,
            color: Colors.black87,
          ),
          )
        ],
      ),
      body: _buildForm(),
    );
  }

  Widget _buildForm(){
    bool canEdit = _openType !=OpenType.Preview;
    return SingleChildScrollView(
      child: IgnorePointer(
        ignoring: !canEdit,
        child: GestureDetector(
          behavior:HitTestBehavior.translucent,
          onTap: (){
              FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _buildTextFormField(
                  '名称', 
                  '任务', 
                  maxLines: 1, 
                  initiaValue: _todo!.title, 
                  onSaved: (value)=>_todo!.title = value!,),
                _buildTextFormField(
                  '描述',
                  '任务描述',
                  maxLines: 2,
                  initiaValue: _todo!.description,
                  onSaved: (value) => _todo!.description = value!,),
                _buildDateFormField(
                  '日期',
                  '请选择日期',
                  initialValue: _todo!.date,
                  controller: _dateTextEditingController,
                  onSelect: (value) {
                    _todo!.date = value.dayTime;
                    _dateTextEditingController.text = _todo!.date.toString();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: _buildTimeFormField(
                        '开始时间',
                        '请选择开始时间',
                        initialValue: _todo!.startTime,
                        controller: _startTimeTextEditingController,
                        onSelect: (value) {
                          _todo!.startTime = value;
                          _startTimeTextEditingController.text =
                              _todo!.startTime.timeString;
                        },
                      ),
                    ),
                    Expanded(
                      child: _buildTimeFormField(
                        '终止时间',
                        '请选择终止时间',
                        initialValue: _todo!.endTime,
                        controller: _endTimeTextEditingController,
                        onSelect: (value) {
                          _todo!.endTime = value;
                          _endTimeTextEditingController.text =
                              _todo!.endTime.timeString;
                        },
                      ),
                    ),
                  ],
                ),
                _buildPriorityFormField(
                  '优先级',
                ),
              ],

            ),),
          ),),
    );
  }

  Widget _buildTextFormField(String title,String hintText,{
    required int maxLines,
    required String initiaValue,
    required FormFieldSetter<String>  onSaved,
  }){
    TextInputType inputType = maxLines ==null ? TextInputType.multiline:TextInputType.text;
    return LabelGroup(labelText: title, labelStyle: _labelTextStyle, child: TextFormField(
      keyboardType: inputType,
      validator: (String? value){
        return value!.length > 0 ? null : '$title 不能为空';
      },
      onSaved: onSaved,
      textInputAction: TextInputAction.done,
      maxLength: maxLines,
      initialValue: initiaValue,
      decoration: InputDecoration(hintText: hintText,enabledBorder: _textFormBorder),
    ), padding: _labelPadding);
  }

  Widget _buildDateFormField(String title,String hintText,{required DateTime initialValue,required TextEditingController controller,
      required Function(DateTime) onSelect,
  }){
      DateTime now = DateTime.now();
      return LabelGroup(labelText: title, labelStyle: _labelTextStyle, 
      child:DateFieldGroup(
        onSelect:onSelect,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(hintText: hintText,disabledBorder: _textFormBorder,),
          validator: (String? value){
            return value ==null ? '$title 不能为空':null;
          },
          ),
          initiaDate: initialValue,
          startDate: initialValue,
          endDate: DateTime(2025), selectableDayPredicate: (DateTime day) { return true; },
          ) , 
          padding: _labelPadding);
  }

  Widget _buildTimeFormField(
    String title,
    String hintText, {
    required TextEditingController controller,
    required TimeOfDay initialValue,
    required Function(TimeOfDay) onSelect,
  }) {
    return LabelGroup(
      labelText: title,
      labelStyle: _labelTextStyle,
      padding: _labelPadding,
      child: TimeFieldGroup(
        onSelect: onSelect,
        child: TextFormField(
          validator: (String? value) {
            return value!.length > 0 ? null : '$title 不能为空';
          },
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            disabledBorder: _textFormBorder,
          ),
        ),
        initialTime: initialValue,
      ),
    );
  }

  Widget _buildPriorityFormField(
    String title, {
    TextEditingController? textController,
     Function(Priority)? onSaved,
  }) {
    return LabelGroup(
      labelText: title,
      labelStyle: _labelTextStyle,
      padding: _labelPadding,
      child: PriorityFiledGroup(
        initialValue: _todo!.priority,
        onChange: (Priority priority) {
          setState(() {
            _todo!.priority = priority;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(_todo!.priority.description),
                  ),
                  Container(
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    child: Container(
                      width: 100,
                      height: 5,
                      color: _todo!.priority.color,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }

  void _edit() {
    setState(() {
      _openType = OpenType.Edit;
    });
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(_todo);
    }
  }
}


class _OpenTypeConfig {

  final String title;
  final IconData icon;
  final void Function() onPressed;

  const _OpenTypeConfig(this.title,this.icon,this.onPressed);
}
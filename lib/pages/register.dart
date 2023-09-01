
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter_application_0/const/route_url.dart';

class RegisterPage extends StatefulWidget{

  @override
  _RegisterPageState createState() => _RegisterPageState();
}


class _RegisterPageState extends State<RegisterPage>{

  final picker =  ImagePicker();
  bool canRegister = false;
  bool photo = false;
  late File  image ;

  TextEditingController  _emailControler = TextEditingController();
  TextEditingController  _passwordControler = TextEditingController();
  TextEditingController  _repeatPasswordControler = TextEditingController();


  @override
  void initState() {
    super.initState();
    canRegister  = false;
  }

  void _checkInputValid(String _){
    bool isInputVaild = _emailControler.text.contains('@')&&
    _passwordControler.text.length>=6&&
    _repeatPasswordControler.text == _passwordControler.text;
  
    if(isInputVaild == canRegister){
      return;
    }
    setState(() {
      canRegister = isInputVaild;
      
    });
  }
  void _gotoLogin(){
    Navigator.of(context).pop();
  }

  void _getImage() async {
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedFile.path);
      photo = true;
    });
  }
  @override
  Widget build(BuildContext context) {

  return GestureDetector(
    onTap: (){
      FocusScope.of(context).unfocus();
    },
    child: Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Center(
                      child: GestureDetector(
                        onTap: _getImage,
                        child: FractionallySizedBox(
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 48,
                                backgroundImage:(photo ? FileImage(image): FileImage(File('')))as FileImage,
                              ),
                              Positioned(
                                right: 20,
                                top: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(17),
                                    ),
                                    color: Color.fromARGB(255, 80, 210, 194),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 34,
                                    color: Colors.white,
                                  ),
                                  ),
                              ),
                            ]
                          ),
                        widthFactor: 0.4,
                        heightFactor: 0.4,
                        ),
                      ) ,
                      ),
                  )
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              left: 24,
                              right: 24,
                              bottom: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: '请输入邮箱',
                                    labelText: '邮箱',
                                  ),
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (String value){
                                    FocusScope.of(context).nextFocus();
                                  },
                                  onChanged: _checkInputValid,
                                  controller: _emailControler,
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: '请输入六位以上密码',
                                    labelText: '密码',
                                  ),
                                  textInputAction: TextInputAction.next,
                                  onSubmitted:(String value){
                                    FocusScope.of(context).nextFocus();
                                  },
                                  obscureText: true,
                                  onChanged: _checkInputValid,
                                  controller: _passwordControler,
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: '再次输入密码',
                                    labelText: '确认密码',
                                  ),
                                  obscureText: true,
                                  onChanged: _checkInputValid,
                                  controller: _repeatPasswordControler,
                                )
                              ],
                            ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 24,
                                right: 24,
                                top: 12,
                                bottom: 12,
                              ),
                              child: FlatButton(
                                onPressed: canRegister ? (){} : null,
                                child: Text('注册并登录',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                ),
                                disabledColor: Color.fromRGBO(69, 202, 160, 0.5),
                                color: Color.fromRGBO(69, 202, 181, 1),
                              ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 24,right: 24,top: 12,bottom: 12
                                ),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('已有账号？'),
                                      InkWell(
                                        child: Text('立即登录'),
                                        onTap: _gotoLogin,
                                      ),
                                    ],
                                  ),
                                ),
                                )
                        ],
                      ),
                    ))
              ],

            )
            ),
        ),
      ),

    ),
  );
  }

}


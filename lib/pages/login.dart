import 'package:flutter/material.dart';
import 'package:flutter_application_0/component/dialog.dart';
import 'package:flutter_application_0/component/fractionally_sized_trastion.dart';
import 'package:flutter_application_0/component/image_hero.dart';
import 'package:flutter_application_0/const/route_argument.dart';
import 'package:flutter_application_0/model/login_center.dart';
import 'package:flutter_application_0/const/route_url.dart';
import 'package:flutter_application_0/pages/register.dart';
import 'package:flutter_application_0/pages/todo_entry.dart';
import 'package:flutter_application_0/model/network_client.dart';
import 'package:flutter_application_0/utils/network.dart';

class LoginPage extends StatefulWidget{

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{

  late bool canLogin;
  late bool useHero;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    canLogin = false;
    useHero = true;

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    Animation<double> parentAnimation = CurvedAnimation(
      parent: _animationController, 
      curve: Curves.bounceIn,);
    Tween<double> tween = Tween<double>(begin: 0.4,end:0.5);
    _animation = tween.animate(parentAnimation);
    _animationController.forward().then((value) => _animationController.reverse());


  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _checkInputValid(String _){
    bool isInputValid = _emailController.text.contains('@')&&_passwordController.text.length>=6;
    if(isInputValid == canLogin){
      return;
    }
    setState(() {
      canLogin = isInputValid;
    });
  }

  void _gotoRegister(){
    Navigator.of(context).pushNamed(REGISTER_PAGE_URL,
    arguments: RegisterPageArgument('LoginPage', LOGIN_PAGE_URL));
  }

  void _Login() async{

    if (await checkConnectivityResult(context) == false) {
      return;
    }
    String email = _emailController.text;
    String password = _passwordController.text;
    showDialog(
      context: context,
      builder: (buildContext) => ProgressDialog(text: '请求中'),
    );
    String result = await NetworkClient.instance().login(email, password);
    Navigator.of(context).pop();
    if (result.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) => SimpleAlertDialog(
          title: '服务器返回信息',
          content: '登录失败，错误信息为：\n$result',
        ),
      );
      return;
    }
    setState(() {
      useHero = false;
    });
    String currentUserKey = await LoginCenter.instance().login(email);
    Navigator.of(context).pushReplacementNamed(
      TODO_ENTRY_PAGE_URL,
      arguments: TodoEntryArgument(currentUserKey),
    );

    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>TodoEntryPage(),),);
  
  }

  @override
  Widget build(BuildContext context) {
    String markAssetName = 'assets/images/mark.png';
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child:  ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                child: Center(
                  child: FractionallySizedTransition(
                    child: useHero ?ImageHero.asset(markAssetName):Image.asset(markAssetName),
                    factor: _animation,
                  ),
                ),
              ),
              ),
              Expanded(
                child:Container(
                  child:Column(
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
                            controller: _emailController,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText:'请输入六位以上密码',
                              labelText: '密码',
                            ),
                            obscureText: true,
                            onChanged:_checkInputValid,
                            controller: _passwordController,
                          ),
                        ],
                      ),
                      ),
                      Padding(padding: EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 12,
                        bottom:12,
                      ),
                      child: FlatButton(
                        onPressed: canLogin? _Login:null,
                        child: Text(
                          '登录',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        disabledColor: Color.fromRGBO(69,202, 160, 0.5),
                        color:Color.fromRGBO(69, 202, 181, 1),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(
                    left:24,right:24,top: 12,bottom: 12
                  ),
                    child:Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('没有账号？'),
                          InkWell(
                            child: Text('立即注册'),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => RegisterPage())
                            ),
                          )
                        ],
                      ),
                    ))
                    ],
                )
              ))
            ],
          ),
        )
      ),
    ),
  ),
);
  }
}
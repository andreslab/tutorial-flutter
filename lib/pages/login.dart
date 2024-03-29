import 'dart:io';

import 'package:chat_secreto/widgets/circle.dart';
import 'package:chat_secreto/widgets/input_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../api/auth_api.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //key que se agrega al Form para acceder a funciones
  final _formKey = GlobalKey<FormState>();
  final _authAPI = AuthAPI();
  var _isFetching = false;

  var _email = '', _password = '';

  @override
  void initState(){
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  _submit() async{

    if (_isFetching) return;

    final isValid = _formKey.currentState.validate();
    if(isValid) {
      //se usa setState para que el cambio de varible pueda afectar a la interfaz
      setState(() {
        _isFetching = true;
      });
      //se escribe await porque devuelve un Future
      final isOk = await _authAPI.login(context, email: _email, password: _password);
      
      setState(() {
        _isFetching = false;
      });
      
      if (isOk) {
        print("LOGIN OK");
        Navigator.pushNamed(context, "home");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //captura el tamano de la pantalla
    final size = MediaQuery.of(context).size;

    // TODO: implement build
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          //cuando le da tap fuera del teclado
          FocusScope.of(context).requestFocus(FocusNode());
        },
              child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: <Widget>[
              Positioned(
                right: -size.width * 0.25,
                top: -size.width * 0.36,
                child: Circle(
                  radius: size.width * 0.50,
                  colors: [Colors.pinkAccent, Colors.pinkAccent],
                ),
              ),
              Positioned(
                left: -size.width * 0.35,
                top: -size.width * 0.34,
                child: Circle(
                  radius: size.width * 0.40,
                  colors: [Colors.orange, Colors.deepOrange],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  width: size.width,
                  height: size.height,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                                width: 90,
                                height: 90,
                                margin: EdgeInsets.only(top: size.width * 0.3),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26, blurRadius: 25)
                                    ])),
                            Text("Hello again. \nWelcome back",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w300)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: 350, minWidth: 350),
                              child: Form(
                                key: _formKey,
                                                              child: Column(children: <Widget>[
                                  InputText(label: "EMAIL ADDRESS",
                                  validator: (String text) {
                                    if (text.contains("@")) {
                                      _email = text;
                                      return null;
                                    }
                                    return "Invalid Email";
                                    },
                                    inputType: TextInputType.emailAddress,),
                                  SizedBox(height: 30,),
                                  InputText(label: "PASSWORD",
                                  validator: (String text) {
                                     if (text.isNotEmpty && text.length > 5) {
                                       _password = text;
                                      return null;
                                    }
                                    return "Invalid Password";
                                  },
                                  isSecure: true,)
                                ],),
                              )
                            ),
                            SizedBox(height: 40,),
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: 350, minWidth: 350),
                              child: CupertinoButton(
                                padding: EdgeInsets.symmetric(vertical: 17),
                                color: Colors.pinkAccent,
                                borderRadius: BorderRadius.circular(4),
                                onPressed: () => _submit(),
                                child: Text("Sign in",
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("New to Friendly Desi?",
                                style: TextStyle(fontSize: 16,
                                color: Colors.black54)),
                                CupertinoButton(
                                  child: Text("Sign up",
                                  style: TextStyle(fontSize: 16, color: Colors.pinkAccent)),
                                  onPressed: () => Navigator.pushNamed(context, "signup"),
                                  //onPressed: () => sleep(),
                                  /*onPressed: () {
                                    sleep1().then((String text){
                                      print(text);
                                    });
                                  },*/
                                  //onPressed: () => process_1(),
                                )
                              ],
                            ),
                            SizedBox(height: size.height*0.03,)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
              ,_isFetching ? Positioned.fill(
                child: Container(
                  color: Colors.black45,
                  child: CupertinoActivityIndicator(
                    radius: 15,
                  ),
                ),
              ) : Container()
            ],
          ),
        ),
      ),
    );
  }

  //imprimir luego de 3 segundos
  sleep(){
    Future.delayed(Duration(seconds: 3), () => print("AWAKE"));
  }

  //luego de 3 segundos retorna un string
  sleep1<String>(){
    return Future.delayed(Duration(seconds: 3), () => "00000");
  }

  //funcion asincrona en la funcion princiapl que llama
  void process_1() async {
    final text = await sleep1();
    print(text);
  }
}

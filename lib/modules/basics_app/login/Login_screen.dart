import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appaa/shared/component/components.dart';
import 'package:flutter_appaa/shared/component/constants.dart';

var emailController = TextEditingController();
var passwordController = TextEditingController();
var formKey=GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 bool isPassword=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        //color: Colors.lightGreenAccent,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              //height: double.infinity,

              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          //fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: defaultFormField(
                          controller: emailController,
                          label: 'email',
                          prefix: Icons.email,
                          type: TextInputType.emailAddress,
                          validate: (String value){
                            if (value.isEmpty){
                              return'email must not be empty';
                            }
                            return null;
                          },
                          onChange: (String value){
                            print(value);
                          }
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child:  defaultFormField(
                          controller: passwordController,
                          label: 'password',
                          prefix: Icons.lock,
                          type: TextInputType.visiblePassword,
                          validate: (String value){
                            if (value.isEmpty){
                              return'password must not be empty';
                            }
                            return null;
                          },

                          isPassword: isPassword,
                          suffixPressed: (){
                            setState(() {
                              isPassword=!isPassword;

                            });
                          },
                          suffix: isPassword? Icons.visibility_off:Icons.visibility,
                          onChange: (String value){
                            print(value);
                          }
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        TextButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(end: 10.0),
                            child: Text(
                              'Forgot password ?',
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: defaultButtons(
                        radius: 5.0,
                          function: (){
                          if(formKey.currentState.validate()){
                            print(emailController.text);
                            print(passwordController.text);
                          }

                      },
                          text: 'login'
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsetsDirectional.only(start: 20.0,top: 10.0,end: 20.0,bottom: 10.0),
                    //   child: defaultButtons(
                    //     // width: double.infinity,
                    //     //background: Colors.blue,
                    //       function: (){
                    //         print(emailController.text);
                    //         print(passwordController.text);
                    //       },
                    //       text: 'register'
                    //   ),
                    // ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: 20.0,start: 20.0),
                          child: Text('Don\'t have an account?'),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: 20.0,start: 5.0),
                          child: TextButton(onPressed: (){},
                              child: Text('register now')),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

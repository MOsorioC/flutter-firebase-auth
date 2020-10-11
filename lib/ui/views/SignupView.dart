import 'package:flutter/material.dart';
import 'package:login_provider/core/constants/RoutePath.dart';
import 'package:login_provider/core/services/AuthenticationService.dart';
import 'package:login_provider/ui/widgets/BaseWidget.dart';

class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AuthenticationService>(
      model: AuthenticationService(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
              child: Padding(
            padding: EdgeInsets.all(16.0),
            child: model.isBusy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                      ),
                      Text(
                        "SigUp",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(hintText: "Email"),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(hintText: "Password"),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      ButtonTheme(
                        minWidth: 200.0,
                        child: OutlineButton(
                          onPressed: () async {
                            if (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              await model.signUpWithEmail(
                                  email: emailController.text,
                                  password: passwordController.text);

                              if (Status.Authenticated == model.status) {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    RoutePath.privateHome, (route) => false);
                              }
                            }
                          },
                          child: Text("Create Account", style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold
                          ),),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          textColor: Colors.pinkAccent,
                        ),
                      )
                    ],
                  ),
          )),
        )),
      ),
    );
  }
}

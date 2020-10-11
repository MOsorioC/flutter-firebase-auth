import 'package:flutter/material.dart';
import 'package:login_provider/core/constants/RoutePath.dart';
import 'package:login_provider/core/services/AuthenticationService.dart';
import 'package:login_provider/ui/views/PrivateView.dart';
import 'package:login_provider/ui/widgets/BaseWidget.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<AuthenticationService>(
      model: AuthenticationService(),
      builder: (context, model, child) => Status.Authenticated == model.status
          ? PrivateView()
          : Scaffold(
              appBar: AppBar(
                title: Text("Firebase Auth"),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 200,
                      child: OutlineButton(
                        onPressed: () async {
                          Navigator.pushNamed(
                            context,
                            RoutePath.signUp,
                          );
                        },
                        child: Text("SignUp"),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ButtonTheme(
                      minWidth: 200.0,
                      child: OutlineButton(
                        onPressed: () async {
                          Navigator.pushNamed(
                              context,
                              RoutePath.signIn
                          );
                        },
                        child: Text("SignIn"),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

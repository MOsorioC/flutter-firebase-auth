import 'package:flutter/material.dart';
import 'package:login_provider/core/constants/RoutePath.dart';
import 'package:login_provider/core/services/AuthenticationService.dart';
import 'package:provider/provider.dart';

class PrivateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthenticationService authenticationServiceProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Private view"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hola ${authenticationServiceProvider.user?.email}"),
              SizedBox(
                height: 16.0,
              ),
              OutlineButton(
                onPressed: () async {
                  await authenticationServiceProvider.signOut();
                  Navigator.pushReplacementNamed(context, RoutePath.home);
                },
                child: Text("LogOut"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_provider/core/constants/RoutePath.dart';
import 'package:login_provider/provider_conf.dart';
import 'package:login_provider/ui/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: providers,
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              initialRoute: RoutePath.home,
              onGenerateRoute: generateRoute,
            ),
          );
        }

        return MaterialApp(
          title: 'Flutter Demo',
          home: Container(child: Text("loading"),),
        );
      },
    );
  }
}

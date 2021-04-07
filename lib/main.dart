import 'package:flutter/material.dart';
import 'package:flutter_app/routing/app_router.dart';
import 'package:flutter_app/views/signup/signup_page.dart';
import 'package:flutter_app/ui_elements/loading_view.dart';
import 'constants/page_names.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      onGenerateRoute: AppRouter.routeAll,
      initialRoute: LANDING,
    );
  }
}

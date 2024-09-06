import 'package:flutter/material.dart';
import 'package:flutter_workspace/core/environment.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Environment.instance.buildType.build(context),
    );
  }
}

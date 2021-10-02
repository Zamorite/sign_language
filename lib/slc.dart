import 'package:flutter/material.dart';
import 'package:slc/views/home.dart';

class SLC extends StatelessWidget {
  const SLC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SLC',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomeView(),
    );
  }
}

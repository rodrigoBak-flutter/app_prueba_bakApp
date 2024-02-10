import 'package:flutter/material.dart';
import 'package:klikticket/pages/charts_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Más'),
      ),
      body: const ChartsPage(),
    );
  }
}

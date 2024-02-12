import 'package:klikticket/providers/expenses_provider.dart';
import 'package:klikticket/providers/shared_pref.dart';
import 'package:flutter/material.dart';

import 'package:klikticket/providers/ui_provider.dart';
import 'package:klikticket/routes/routes.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = UserPrefs();
  await prefs.initPrefs();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UIProvider()),
    ChangeNotifierProvider(create: (_) => ExpensesProvider()),
    //  ChangeNotifierProvider(create: (_) => ThemeProvider(prefs.darkMode)),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KLIKTICKET PRUEBA',
      // theme: value.getTheme(),
      initialRoute: 'loading',
      routes: appRoutes,
    );
  }
}


/*
return Consumer<ThemeProvider>(builder: (context, value, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KLIKTICKET PRUEBA',
       // theme: value.getTheme(),
        initialRoute: 'loading',
        routes: appRoutes,
      );

 */
import 'package:flutter/material.dart';
import 'package:klikticket/pages/login_page.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 24, 24, 241),
        body: FutureBuilder(
          future: checkLoginState(context),
          builder: (context, snapshot) {
            return Center(
              child: Image.asset('assets/loading.gif'),
            );
          },
        ));
  }

  Future checkLoginState(BuildContext context) async {
    await Future.delayed(
      const Duration(seconds: 3),
    );

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const LoginPage(),
          transitionDuration: const Duration(milliseconds: 1500),
        ));
  }
}

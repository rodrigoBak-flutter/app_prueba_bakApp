import 'package:klikticket/pages/home_page.dart';
import 'package:klikticket/utils/page_animation_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ClientesScree extends StatelessWidget {
  const ClientesScree({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          height: size.height * 0.12,
          color: const Color.fromARGB(255, 24, 24, 241),
          child: Padding(
            padding: const EdgeInsets.only(top: 35, left: 20),
            child: GestureDetector(
              onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  PageAnimationRoutes(widget: HomePage()),
                  ModalRoute.withName('')),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.35),
        Text(
          'Aun no tienes Clientes',
          style: GoogleFonts.roboto(
              fontSize: size.height * 0.020,
              color: Colors.grey,
              fontWeight: FontWeight.bold),
        ),
      ],
    ));
  }
}

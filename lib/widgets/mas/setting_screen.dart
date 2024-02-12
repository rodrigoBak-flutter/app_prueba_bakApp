import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:klikticket/pages/charts_page.dart';
import 'package:klikticket/pages/home_page.dart';
import 'package:klikticket/pages/login_page.dart';
import 'package:klikticket/utils/page_animation_routes.dart';
import 'package:klikticket/widgets/mas/bloque_1/notificaciones/notificaciones.dart';
import 'package:klikticket/widgets/mas/bloque_2/anticipos/anticipos.dart';

import 'package:klikticket/widgets/mas/bloque_2/saldo/saldo.dart';
import 'package:klikticket/widgets/mas/bloque_3/centro_de_costes/centro_costes.dart';
import 'package:klikticket/widgets/mas/bloque_3/clientes/clientes.dart';
import 'package:klikticket/widgets/mas/bloque_3/proveedores/proveedores.dart';
import 'package:klikticket/widgets/mas/bloque_4/ayuda/ayuda.dart';
import 'package:klikticket/widgets/mas/bloque_4/configuraciones/configuraciones.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    //Esta linea de codigo me permite manejar la proporciones, es decir, el espacio que ocupara cada Widget, por ejemplo el 30% de mi pantalla "X"
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 24, 24, 241),
          centerTitle: true,
          title: Text(
            'Más',
            style: GoogleFonts.roboto(
                fontSize: size.height * 0.025,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _NotificacionesWidget(size: size),
                    const Divider(),
                    _Bloque2(size: size),
                    const Divider(),
                    _Bloque3(size: size),
                    const Divider(),
                    _Bloque4(size: size),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class _NotificacionesWidget extends StatelessWidget {
  const _NotificacionesWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                PageAnimationRoutes(widget: const NotificacionesScreen()),
                ModalRoute.withName('')),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.notifications,
                      color: Colors.yellow,
                    ),
                    Text(
                      'Notificaciones',
                      style: GoogleFonts.roboto(
                          fontSize: size.height * 0.020,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  ],
                ),
              )
            ]),
          ),
          GestureDetector(
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                PageAnimationRoutes(widget: const BorradorScreen()),
                ModalRoute.withName('')),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.edit,
                      color: Colors.yellow,
                    ),
                    Text(
                      'Borrador',
                      style: GoogleFonts.roboto(
                          fontSize: size.height * 0.020,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}

class BorradorScreen extends StatelessWidget {
  const BorradorScreen({super.key});

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
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 35, left: 20),
            child: GestureDetector(
              onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  PageAnimationRoutes(widget: const HomePage()),
                  ModalRoute.withName('')),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

class _Bloque2 extends StatelessWidget {
  const _Bloque2({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: GestureDetector(
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                PageAnimationRoutes(widget: const SaldoScreen()),
                ModalRoute.withName('')),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.money,
                  color: Colors.orangeAccent,
                ),
                Text(
                  'Saldo',
                  style: GoogleFonts.roboto(
                      fontSize: size.height * 0.020,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: GestureDetector(
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                PageAnimationRoutes(widget: const AnticiposScreen()),
                ModalRoute.withName('')),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.cast_sharp,
                  color: Colors.orangeAccent,
                ),
                Text(
                  'Anticipos',
                  style: GoogleFonts.roboto(
                      fontSize: size.height * 0.020,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              PageAnimationRoutes(widget: const ChartsPage()),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.analytics_outlined,
                  color: Colors.orangeAccent,
                ),
                Text(
                  'Estadisticas',
                  style: GoogleFonts.roboto(
                      fontSize: size.height * 0.020,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Bloque3 extends StatelessWidget {
  const _Bloque3({
    super.key,
    required this.size,
  });

  final Size size;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: GestureDetector(
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                PageAnimationRoutes(widget: const ClientesScree()),
                ModalRoute.withName('')),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.person_outline,
                  color: Colors.green,
                ),
                Text(
                  'Clientes',
                  style: GoogleFonts.roboto(
                      fontSize: size.height * 0.020,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: GestureDetector(
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                PageAnimationRoutes(widget: const ProveedoresScreen()),
                ModalRoute.withName('')),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.person_search_outlined,
                  color: Colors.green,
                ),
                Text(
                  'Proveedores',
                  style: GoogleFonts.roboto(
                      fontSize: size.height * 0.020,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: GestureDetector(
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                PageAnimationRoutes(widget: const CentroCostesScreen()),
                ModalRoute.withName('')),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.analytics_outlined,
                  color: Colors.green,
                ),
                Text(
                  'Centro de costes',
                  style: GoogleFonts.roboto(
                      fontSize: size.height * 0.020,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Bloque4 extends StatelessWidget {
  const _Bloque4({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: GestureDetector(
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                PageAnimationRoutes(widget: const AyudaScreen()),
                ModalRoute.withName('')),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.help_outline,
                  color: Colors.lightBlue,
                ),
                Text(
                  'Ayuda',
                  style: GoogleFonts.roboto(
                      fontSize: size.height * 0.020,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: GestureDetector(
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                PageAnimationRoutes(widget: const ConfiguracionScreen()),
                ModalRoute.withName('')),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.settings_outlined,
                  color: Colors.lightBlue,
                ),
                Text(
                  'Configuraciones',
                  style: GoogleFonts.roboto(
                      fontSize: size.height * 0.020,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),

        //const DarkModeSwichWidget(),
        // const SharedFriendsWidget(),
        GestureDetector(
          onTap: () {
            //FUNVION PARA NAVEGAR A MI PAGINA DE LOGIN
            Navigator.pushAndRemoveUntil(
                context,
                PageAnimationRoutes(widget: const LoginPage()),
                ModalRoute.withName(''));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.exit_to_app,
                  color: Colors.lightBlue,
                ),
                Text(
                  'Cerrar Sesion',
                  style: GoogleFonts.roboto(
                      fontSize: size.height * 0.020,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Bloque5 extends StatefulWidget {
  const Bloque5({super.key});

  @override
  State<Bloque5> createState() => _Bloque5State();
}

class _Bloque5State extends State<Bloque5> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container();
  }
}


/*

const AppBarSettingWidget(),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView(
                    children: const [
                      //MODO OSCURO O MODO CLARO
                      DarkModeSwichWidget(),
                      Divider(
                        thickness: 2,
                      ),
                      //OPCION PARA COMPARTIR CON MAS PERSONAS
                      SharedFriendsWidget(),
                      Divider(
                        thickness: 2,
                      ),
                      //NOTIFICACIONES LOCALES
                      TimePickerWidget(),
                      Divider(
                        thickness: 2,
                      ),
                      //CERRAR SESION
                      CerrarSesionWidget(),
                      Divider(
                        thickness: 2,
                      ),
                    ],
                  ),
                ),
              )


 */

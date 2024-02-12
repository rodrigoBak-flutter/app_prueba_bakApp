import 'dart:async';

import 'package:local_auth/local_auth.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klikticket/pages/home_page.dart';
import 'package:klikticket/utils/page_animation_routes.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    //Esta linea de codigo me permite manejar la proporciones, es decir, el espacio que ocupara cada Widget, por ejemplo el 30% de mi pantalla "X"
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      /* AuthBackground, esta configuracion se encuentra en los auth_widget
        Parametros requeredidos
        Widget child;
        String subtitle;
        String description;
      */
      body: AuthBackground(
        subtitle: '¡Bienvenido!',
        description: 'Accede y empieza a optimizar tu tiempo',
        child: Column(
          children: [
            //Altura de mi caja, medida en porcentaje
            SizedBox(height: size.height * 0.25),
            FadeInUpBig(
              duration: const Duration(milliseconds: 1000),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: CardContainer(
                  //Llamo a controlador para poder restringir mi login de usuario
                  child: ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: LoginForm(),
                  ),
                ),
              ),
            ),
            //Altura de mi caja, medida en porcentaje
            SizedBox(height: size.height * 0.04),
            FadeInLeftBig(
              duration: const Duration(milliseconds: 1500),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿Aún no tienes una cuenta?',
                    style: GoogleFonts.roboto(
                      fontSize: size.height * 0.017,
                      color: Colors.white,
                    ),
                  ),
                  //BOTON DE NAVEGACION
                  TextButtonWidget(
                      textButton: 'Créala aquí',
                      //Llamo a la funcion que me permite navegar del RegisterScreen al LoginScreen
                      onPressed: () {}),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            //BUTON CONTACTAR CON SUPORTE
            FadeInRightBig(
              duration: const Duration(milliseconds: 1500),
              child: const SupportButtonWidget(),
            ),
            //Altura de mi caja, medida en porcentaje
            SizedBox(height: size.height * 0.03),
            FadeInLeftBig(
              duration: const Duration(milliseconds: 2000),
              child: Text(
                'v1.0.0',
                style: GoogleFonts.roboto(
                  fontSize: size.height * 0.017,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SupportButtonWidget extends StatelessWidget {
  const SupportButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          // isDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              height: size.height * 0.212,
              child: Column(
                children: [
                  Container(
                    width: size.width * 0.25,
                    alignment: Alignment.topCenter,
                    child: const Divider(
                      color: Colors.black,
                      thickness: 5,
                    ),
                  ),
                  const _ButtonSheepSoporte(
                    title: 'Correo',
                    subtitle: 'Contacta con soporte a través de un email',
                    icon: Icons.email_outlined,
                  ),
                  const _ButtonSheepSoporte(
                    title: 'Teléfono',
                    subtitle: 'Contacta con soporte a través de una llamada',
                    icon: Icons.phone_outlined,
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        width: size.width * 0.6,
        height: size.height * 0.05,
        decoration: const BoxDecoration(
            color: Colors.white38,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.headset_mic_outlined,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Contacta con soporte',
              style: GoogleFonts.roboto(
                fontSize: size.height * 0.017,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ButtonSheepSoporte extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const _ButtonSheepSoporte({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: Colors.black,
                size: 30,
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                children: [
                  Container(
                    width: size.width * 0.70,
                    child: Text(
                      title,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.roboto(
                          fontSize: size.height * 0.017,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: size.width * 0.70,
                    child: Text(
                      subtitle,
                      style: GoogleFonts.roboto(
                        fontSize: size.height * 0.013,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
            ],
          ),
        ),
        const Divider(color: Colors.black)
      ],
    );
  }
}

class TextButtonWidget extends StatelessWidget {
  final String textButton;
  final Function onPressed;
  const TextButtonWidget(
      {super.key, required this.textButton, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.topRight,
      child: TextButton(
        //Llamo a la funcion que me permite navegar del RegisterScreen al LoginScreen, si todo va OK
        onPressed: () => onPressed(),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            const StadiumBorder(),
          ),
        ),
        child: Text(
          textButton,
          style: GoogleFonts.roboto(
            fontSize: size.height * 0.015,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

class ProgressDialog {
  static show(BuildContext context) {
    final size = MediaQuery.of(context).size;
    showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return Container(
              color: Colors.white.withOpacity(0.9),
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ZoomIn(
                        from: 1,
                        duration: const Duration(seconds: 2),
                        child: Image.asset('assets/logo_azul.png')),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    const SpinKitThreeBounce(
                      color: Color.fromARGB(255, 24, 24, 241),
                    ),
                  ],
                ),
              ));
        });
  }

  static dissmiss(BuildContext context) {
    Navigator.pop(context);
  }
}

//Esta clase me permite manejar el estado del formulario de LoginScreen
class LoginFormProvider extends ChangeNotifier {
  //Esta llave me permite saber que formulario estoy controlando
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  //Simulacion de carga, validacion
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    //Todos mis Widgets estan escuchando
    notifyListeners();
  }

  //Funcion para saber si es valido mi formulario
  bool isValidForm() {
    //Para ver en la terminal si viene la llave/Key
    // print(formKey.currentState?.validate());
    //Para ver el email y el password
    // print('$email - $password');

    //Si la llave viene OK, paso a validar campos
    return formKey.currentState?.validate() ?? false;
  }
}

/*
    
  Este Widget contiene la configuaracion basica de la cabecera de mis pantallas de Login y Registro

  Parametros obligatorios:          
  Widget child;
  String subtitle;
  String description;                   

*/

class AuthBackground extends StatelessWidget {
  final Widget child;
  final String subtitle;
  final String description;

  const AuthBackground(
      {Key? key,
      required this.child,
      required this.subtitle,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          left: -350,
          child: Image.asset(
            'assets/fondo.png',
            fit: BoxFit.cover,
          ),
        ),
        //Este es mi Header personalizado, con esto hice la curvatura de mi login y registro
        // _HeaderWave(),
        //Aca se encuentra la configuracion de mi logo "KLIKTICHET", traido de mis "assets"
        _HeaderLogo(),
        //Aca se encuentra la configuracion del subtitulo, debajo de mi logo "KLIKTICHET"
        _HeaderSubtitle(
          subtitle: subtitle,
        ),
        //Aca se encuentra la configuracion del la descripcion, debajo de mi subtitulo "!Bienvenido" y "Crea tu cuenta"
        _HeaderDescripption(
          description: description,
        ),

        child,
      ],
    );
  }
}

//Este Widget contiene el logo dentro de AuthBackground
class _HeaderLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Esta linea de codigo me permite manejar la proporciones, es decir, el espacio que ocupara cada Widget, por ejemplo el 30% de mi pantalla "X"
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: 0,
      child: Container(
        //Seapracion del marger izquierdo
        margin: const EdgeInsets.only(left: 10),
        //Ancho de la imagen
        width: size.width * 0.8,
        //Alto de la imagen
        height: size.height * 0.25,
        child: Image.asset(
          'assets/logo_azul.png',
        ),
      ),
    );
  }
}

//Este Widget contiene el texto !Bienvendo! dentro de AuthBackground
class _HeaderSubtitle extends StatelessWidget {
  final String subtitle;

  const _HeaderSubtitle({super.key, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //El Positioned, te permite determinar entro de un eje carteciano la posicion exacta donde necesitas colocar el WIDGET
    return Positioned(
      left: 15,
      top: 155,
      child: FadeInLeftBig(
        duration: const Duration(milliseconds: 1500),
        child: Text(
          subtitle,
          style: GoogleFonts.roboto(
              fontSize: size.height * 0.017,
              color: const Color.fromARGB(255, 24, 24, 241),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

//Este Widget contiene el texto "Descripcion KT" dentro de AuthBackground
class _HeaderDescripption extends StatelessWidget {
  final String description;

  const _HeaderDescripption({super.key, required this.description});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //El Positioned, te permite determinar entro de un eje carteciano la posicion exacta donde necesitas colocar el WIDGET
    return Positioned(
      left: 15,
      top: 180,
      child: FadeInRightBig(
        duration: const Duration(milliseconds: 1500),
        child: Text(
          description,
          style: GoogleFonts.roboto(
              fontSize: size.height * 0.012,
              color: const Color.fromARGB(255, 24, 24, 241),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

//Este es mi Header personalizado, con esto hice la curvatura de mi login y registro
class _HeaderWave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //Con esto le doy el tamaño, ancho y alto
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderWavePainter(),
      ),
    );
  }
}

class _HeaderWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = Paint();

    // Propiedades
    lapiz.color = const Color.fromARGB(255, 24, 24, 241);
    lapiz.style = PaintingStyle.fill; // .fill .stroke
    lapiz.strokeWidth = 20;

    final path = Path();

    // Dibujar con el path y el lapiz
    //Para desplazar la curvatura hacia abajo o hacia arriba, manipular los height
    path.lineTo(0, size.height * 0.35);
    path.quadraticBezierTo(size.width * 0.15, size.height * 0.23,
        size.width * 0.35, size.height * 0.3);
    path.quadraticBezierTo(
        size.width * 0.7, size.height * 0.45, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

//CardContainer
class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _createCardShape(),
      child: child,
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15,
            offset: Offset(0, 5),
          )
        ],
      );
}

//FORMULARIO QUE CONTIENE LA LOGICA DE MI LOGIN
class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  //CONTROLADORES DE TEXTO, PARA SABER QUE ESCRIBE EL USUARIO EN LOS CAMPOS
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  late final LocalAuthentication auth;
  //LOGICA PARA MOSTRAR O OCULTAR CONTRASEÑA
  bool _passwordVisible = true;

//LLAMO A MI INITSTATE PARA QUE CUANDO CORRA LA APP AUTOMATICAMENTE EJECUTE LA FUNCION DE AUTHENTICATION MEDIANTE TOUCH O FACE

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
    //INICIALIZACION DEL PAQUETE
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Validaciones desde mi Provider
    final loginForm = Provider.of<LoginFormProvider>(context);

    final size = MediaQuery.of(context).size;

    return Form(
      key: loginForm.formKey,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            controller: emailCtrl,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'juan@klikticket.es',
              labelText: 'Correo electrónico',
              prefixIcon: Icons.email_outlined,
              colorImputLine: Colors.white,
              suffixIcon: GestureDetector(
                onTap: () => setState(() {
                  emailCtrl.clear();
                }),
                child: const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ),
            onChanged: (value) {
              loginForm.email = value;
            },
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'Debe introducir un email valido';
            },
          ),
          _ButtonOlvidePass(size: size),
          TextFormField(
            controller: passCtrl,
            autocorrect: false,
            obscureText: !_passwordVisible,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecorations.authInputDecoration(
              colorImputLine: Colors.white,
              hintText: '*****',
              labelText: 'Contraseña',
              prefixIcon: Icons.lock_outline,
              //Icono para que aparezca y desaparezca la contraseña
              suffixIcon: GestureDetector(
                onTap: () => setState(() {
                  _passwordVisible = !_passwordVisible;
                }),
                child: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            onChanged: (value) {
              loginForm.password = value;
            },
            validator: (value) {
              //&& value.length >= 6
              return (value != null && value.length >= 6)
                  ? null
                  : 'Debe introducir una contraseña valida';
            },
          ),
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
                color: (loginForm.password == '')
                    ? Colors.grey
                    : const Color.fromARGB(255, 24, 24, 241),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                // ignore: sort_child_properties_last
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                    child: Text(
                      'INICIAR SESION',
                      style: GoogleFonts.roboto(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),

                //SI ES ANDROID ENTRA POR ACA
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  //NO ME DEJA AVANZAR SI NO TENGO INTRODUCIDO UN EMAIL Y UNA CONTRASEÑA
                  if (!loginForm.isValidForm()) return;
                  //MOSTRAR UN LOADING
                  ProgressDialog.show(context);

                  await Future.delayed(
                    const Duration(seconds: 3),
                  );

                  //SI todo VA OK, PUEDO INGRESAR A LA PANTALLAS PRINCIPAL
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageAnimationRoutes(
                        widget: const HomePage(),
                      ),
                      ModalRoute.withName(''));
                }),
          ),
          const SizedBox(height: 30),
          //INGRESAR CON HUELLA
          GestureDetector(
            onTap: () async {
              try {
                bool authenticated = await auth.authenticate(
                    localizedReason: 'Introduce tu huella para iniciar sesion',
                    options: const AuthenticationOptions(
                        stickyAuth: true,
                        biometricOnly: false,
                        useErrorDialogs: false,
                        sensitiveTransaction: true),
                    authMessages: []);
                //SI EL USUARIO SE AUTENTICA MEDIANDO FACEID LO DEVUELVO A LA PANTALLA HOME
                if (authenticated == true) {
                  //  print('INICIAR CON HUELLA');
                  // ignore: use_build_context_synchronously
                  FocusScope.of(context).unfocus();
                  //MOSTRAR UN LOADING
                  // ignore: use_build_context_synchronously
                  ProgressDialog.show(context);

                  await Future.delayed(
                    const Duration(seconds: 3),
                  );
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageAnimationRoutes(widget: HomePage()),
                      ModalRoute.withName(''));
                }
                print('AUTENTICADO: $authenticated');

                //TODO: SI EL USAURIO NO SE AUTENTICA MEDIANTE ESTE FACTOR, POR FALLO MANEJAR EL FALLO MEDIANTE PIN
              } on PlatformException catch (e) {
                //PARA MOSTRAR EL ERROR EN CONSOLA
                print('NO SOPORTA TOUCHID: $e');
              }
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.fingerprint),
                Text('Iniciar sesion con huella')
              ],
            ),
          )
        ],
      ),
    );
  }
}
/*
    
  Este Widget contiene la configuaracion basica de lo Inputs de mis pantallas de "Login" y "Registro"

  Parametros obligatorios:     Parametro No obligatorio     
  String hintText;             IconData labelText;
  String labelText;                   

*/

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    required Color colorImputLine,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            //Color de la linea que aparece por debajo de los inputs, dentro del TextFormField, antes que el usuario haga "Click"
            color: colorImputLine,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide:
              //Color de la linea que se redibuja cuando el usuario hace "click" en algun TextFormField
              BorderSide(color: Color.fromARGB(255, 24, 24, 241), width: 1),
        ),
        //Lo que el usuario ve antes de que haga "click" en el TextFormField
        hintText: hintText,
        //Lo que el usuario ve despues de que haga "click" en el TextFormField
        labelText: labelText,
        //Color de la letra
        labelStyle: const TextStyle(color: Colors.grey),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon != null
            //Color de los iconos dentro del TextFormField
            ? Icon(
                prefixIcon,
                color: const Color.fromARGB(255, 72, 138, 255),
              )
            : null);
  }
}

class _ButtonOlvidePass extends StatelessWidget {
  const _ButtonOlvidePass({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return TextButtonWidget(
        textButton: '¿Has olvidado tu contraseña?',
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Theme.of(context).primaryColor),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    content: SizedBox(
                      width: double.infinity,
                      height: size.height * 0.25,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Introduce tu email para restablecer la contraseña',
                            style: GoogleFonts.roboto(
                              fontSize: size.height * 0.017,
                              color: Colors.black,
                            ),
                          ),
                          ChangeNotifierProvider(
                            create: (_) => LoginFormProvider(),
                            child: OlvideContraForm(),
                          ),
                        ],
                      ),
                    ));
              });
        });
  }
}

//MANEJAR FORMULARIO DE OLVIDE CONTRASEÑA
class OlvideContraForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                // color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: const Offset(0, 5),
                      blurRadius: 5)
                ]),
            child: TextFormField(
              style: GoogleFonts.roboto(),
              autofocus: true,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  colorImputLine: Colors.red,
                  hintText: 'john.doe@klikticket.es',
                  labelText: 'Email',
                  prefixIcon: Icons.email_outlined),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un email';
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          MaterialButton(
            minWidth: 500,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.white,
            elevation: 0,
            color: const Color.fromARGB(255, 255, 198, 66),
            onPressed: () async {
              FocusScope.of(context).unfocus();

              if (!loginForm.isValidForm()) return;

              loginForm.isLoading = true;

              await Future.delayed(
                const Duration(seconds: 5),
              );

              // TODO: validar si el login es correcto
              loginForm.isLoading = false;

              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                context,
                PageAnimationRoutes(widget: const LoginRecScreen()),
                ModalRoute.withName(''),
              );
            },
            child: loginForm.isLoading
                ? Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ))
                : Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: const Text(
                      'RECUPERAR CONTRASEÑA',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class LoginRecScreen extends StatefulWidget {
  const LoginRecScreen({super.key});

  @override
  State<LoginRecScreen> createState() => _LoginRecScreenState();
}

class _LoginRecScreenState extends State<LoginRecScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '¡Enviado!',
              style: GoogleFonts.roboto(
                  fontSize: size.height * 0.035,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.075,
            ),
            Text(
              'Revisa la bandeja de entrada',
              style: GoogleFonts.roboto(
                fontSize: size.height * 0.03,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: size.height * 0.40,
              child: const Image(
                image: AssetImage('assets/correo.gif'),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: size.height * 0.1,
              width: size.width * 0.1,
              child: OtpTimer(),
            ),
            //BOTON DE NAVEGACION
            TextButtonCustomWidget(
                textButton: 'Cerrar',
                //Llamo a la funcion que me permite navegar del RegisterScreen al LoginScreen
                onPressed: () {
                  Navigator.push(
                    context,
                    PageAnimationRoutes(widget: const LoginPage()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class TextButtonCustomWidget extends StatelessWidget {
  final String textButton;
  final Function onPressed;
  const TextButtonCustomWidget(
      {super.key, required this.textButton, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextButton(
      //Llamo a la funcion que me permite navegar del RegisterScreen al LoginScreen, si todo va OK
      onPressed: () => onPressed(),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          const StadiumBorder(),
        ),
      ),
      child: Text(
        textButton,
        style: GoogleFonts.roboto(
          fontSize: size.height * 0.025,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }
}

class Constants {
  static bottomSheet() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25),
      ),
    );
  }

  static sheetBoxDecoration(Color color) {
    return BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)));
  }

  static customButton(
      Color decoration, Color border, Color textColor, String text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: decoration,
          border: Border.all(color: border),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.roboto(
                fontSize: 12, color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  static CustomButton(Color decoration, Color border, String _text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: decoration,
            border: Border.all(
              color: border,
            ),
            borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: Text(_text),
        ),
      ),
    );
  }
}

class OtpTimer extends StatefulWidget {
  @override
  _OtpTimerState createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 5;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) % 60).toString()}';

  //${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}

  startTimeout([int? milliseconds]) async {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });

    await Future.delayed(
      const Duration(seconds: 5),
    );

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        PageAnimationRoutes(widget: const LoginPage()),
        ModalRoute.withName(''));
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Text(
      timerText,
      style: GoogleFonts.roboto(
        fontSize: size.height * 0.04,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

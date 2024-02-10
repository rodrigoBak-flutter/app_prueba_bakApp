import 'package:google_fonts/google_fonts.dart';
import 'package:klikticket/models/combined_model.dart';

import 'package:klikticket/widgets/add_expenses_wt/bs_category.dart';
import 'package:klikticket/widgets/add_expenses_wt/bs_num_keyboard.dart';
import 'package:klikticket/widgets/add_expenses_wt/comment_box.dart';
import 'package:klikticket/widgets/add_expenses_wt/date_picker.dart';
import 'package:klikticket/widgets/add_expenses_wt/save_button.dart';
import 'package:flutter/material.dart';

class AddExpenses extends StatelessWidget {
  // initialChildSize: CON ESTO DETERMINAMOS EL PUNTO DONDE QUEREMOS QUE ARRANQUE NUESTRA CAJA
  static const double initialChildSize = 0.7;
  // minChildSize: CON ESTO REGULAMOS LA ALTURA MINIMA DONDE VA A LLEGAR NUESTRO CONTENEDOR
  static const double minChildSize = 0.08;
  // maxChildSize: CON ESTO REGULAMOS LA ALTURA MINIMA DONDE VA A LLEGAR NUESTRO CONTENEDOR
  static const double maxChildSize = 0.7;
  const AddExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    //Esta linea de codigo me permite manejar la proporciones, es decir, el espacio que ocupara cada Widget, por ejemplo el 30% de mi pantalla "X"
    final size = MediaQuery.of(context).size;
    CombinedModel cModel = CombinedModel();
    bool hasData = false;
    final editCModel =
        ModalRoute.of(context)!.settings.arguments as CombinedModel?;

    if (editCModel != null) {
      cModel = editCModel;
      hasData = true;
    }
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            //IMAGEN RENDERIZADA DE FONDO
            InteractiveViewer(
              child: Image.asset(
                'assets/no-image.png',
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: IconButton(
                //ENVIARLO A LA PAGINA ANTERIOR
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 40,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),

            DraggableScrollableSheet(
              // initialChildSize: CON ESTO DETERMINAMOS EL PUNTO DONDE QUEREMOS QUE ARRANQUE NUESTRA CAJA
              initialChildSize: initialChildSize,
              // minChildSize: CON ESTO REGULAMOS LA ALTURA MINIMA DONDE VA A LLEGAR NUESTRO CONTENEDOR
              minChildSize: minChildSize,
              // maxChildSize: CON ESTO REGULAMOS LA ALTURA MINIMA DONDE VA A LLEGAR NUESTRO CONTENEDOR
              maxChildSize: maxChildSize,
              builder: (context, scrollController) => Container(
                //LA CONFIGURACION QUE CONTIENE LA CAJA CON MI FORMULARIO LISTADO
                decoration: _builBoxDecoration(),
                //LISTADO QUE CONTIENE EL FORMULARIO DE GASTOS
                child: Column(
                  children: [
                    SizedBox(
                        width: size.width * 0.2,
                        child: const Divider(
                          thickness: 2,
                          color: Colors.grey,
                        )),
                    SizedBox(
                      height: size.height * 0.05,
                      child: ListView(
                        controller: scrollController,
                        children: [
                          SizedBox(
                            height: size.height * 0.05,
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: scrollController,
                              children: [
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Text(
                                  'Ticket',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.height * 0.03,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //LISTA QUE CONTIENE MI FORMULARIO
                    const ListaFormDetalleWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //DECORACION QUE CONTIENEN MI CAJA CON LOS DATOS
  BoxDecoration _builBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5))
        ],
      );
}

class ListaFormDetalleWidget extends StatelessWidget {
  const ListaFormDetalleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //Esta linea de codigo me permite manejar la proporciones, es decir, el espacio que ocupara cada Widget, por ejemplo el 30% de mi pantalla "X"
    final size = MediaQuery.of(context).size;
    CombinedModel cModel = CombinedModel();
    bool hasData = false;
    final editCModel =
        ModalRoute.of(context)!.settings.arguments as CombinedModel?;

    if (editCModel != null) {
      cModel = editCModel;
      hasData = true;
    }

    return Expanded(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              BSNumKeyboard(cModel: cModel),
              DatePicker(cModel: cModel),
              BSCategory(cModel: cModel),
              CommentBox(cModel: cModel),
              Center(
                child: SaveButton(
                  cModel: cModel,
                  hasData: hasData,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}


  


  /*
  class AddExpenses extends StatelessWidget {
  const AddExpenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CombinedModel cModel = CombinedModel();
    bool hasData = false;
    final editCModel =
        ModalRoute.of(context)!.settings.arguments as CombinedModel?;

    if (editCModel != null) {
      cModel = editCModel;
      hasData = true;
    }

    return Scaffold(
        appBar: AppBar(
          title: (hasData)
              ? const Text('Editar Gasto')
              : const Text('Agregar Gasto'),
          elevation: 0.0,
        ),
        body: Column(
          children: [
            BSNumKeyboard(cModel: cModel),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DatePicker(cModel: cModel),
                    BSCategory(cModel: cModel),
                    CommentBox(cModel: cModel),
                    Expanded(
                        child: Center(
                            child: SaveButton(
                      cModel: cModel,
                      hasData: hasData,
                    ))),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

  
   */
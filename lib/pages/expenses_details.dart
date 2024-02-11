import 'package:google_fonts/google_fonts.dart';
import 'package:klikticket/models/combined_model.dart';
import 'package:klikticket/providers/ui_provider.dart';
import 'package:klikticket/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:klikticket/utils/utils.dart';
import 'package:klikticket/utils/math_operations.dart';
import 'package:klikticket/providers/expenses_provider.dart';

class ExpensesDetails extends StatefulWidget {
  const ExpensesDetails({Key? key}) : super(key: key);

  @override
  _ExpensesDetailsState createState() => _ExpensesDetailsState();
}

class _ExpensesDetailsState extends State<ExpensesDetails> {
  List<CombinedModel> cList = [];
  final _scrollController = ScrollController();
  double _offset = 0;

  void _listener() {
    setState(() {
      _offset = _scrollController.offset / 100;
      if (_offset > 0.80) _offset = 0.80;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_listener);
    cList = context.read<ExpensesProvider>().allItemsList;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dataDay = ModalRoute.of(context)!.settings.arguments as int?;

    final exProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();
    cList = context.watch<ExpensesProvider>().allItemsList;

    double totalExp = 0.0;

    if (dataDay != null) {
      cList = cList.where((e) => e.day == dataDay).toList();
    }

    totalExp = cList.map((e) => e.amount).fold(0.0, (a, b) => a + b);

    cList.sort((a, b) => b.day.compareTo(a.day));

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromARGB(255, 24, 24, 241),
            expandedHeight: 125.0,
            title: const Text('Gastos'),
            centerTitle: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Align(
                  alignment: Alignment(_offset, 1),
                  child: Text(
                    getAmountFormat(totalExp),
                  )),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 15.0),
              height: 40.0,
              color: Colors.white,
              child: Container(
                decoration: Constants.sheetBoxDecoration(Colors.white),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, i) {
              var item = cList[i];
              return Slidable(
                key: ValueKey(item),
                endActionPane: ActionPane(
                  motion: const BehindMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        setState(() {
                          cList.removeAt(i);
                        });
                        exProvider.deleteExpense(item.id!);
                        uiProvider.bnbIndex = 0;
                        Fluttertoast.showToast(
                          msg: 'Gasto Eliminado',
                          backgroundColor: Colors.red,
                        );
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Borrar',
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        Navigator.pushNamed(context, 'add_expenses',
                            arguments: item);
                      },
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Editar',
                    )
                  ],
                ),
                child: ListTile(
                  onLongPress: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: Colors.transparent,
                      contentPadding: EdgeInsets.zero,
                      content: //IMAGEN RENDERIZADA DE FONDO
                          Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        height: size.height * 0.7,
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.6,
                              width: double.infinity,
                              child: InteractiveViewer(
                                child: Image.asset(
                                  'assets/ticket.jpg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    cList[0].category,
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    getAmountFormat(cList[0].amount),
                                    style: GoogleFonts.roboto(
                                        fontSize: size.height * 0.025,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${cList[0].day}/${cList[0].month}/${cList[0].year}',
                                    style: GoogleFonts.roboto(
                                        fontSize: size.height * 0.025,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  leading: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 40.0,
                      ),
                      Positioned(top: 16, child: Text(item.day.toString()))
                    ],
                  ),
                  title: Row(
                    children: [
                      Text(item.category),
                      const SizedBox(width: 8.0),
                      Icon(
                        item.icon.toIcon(),
                        color: item.color.toColor(),
                        // size: 18.0,
                      )
                    ],
                  ),
                  subtitle: Text(item.comment),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        getAmountFormat(item.amount),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${(100 * item.amount / totalExp).toStringAsFixed(2)}%',
                        style: const TextStyle(fontSize: 11.0),
                      )
                    ],
                  ),
                ),
              );
            }, childCount: cList.length),
          )
        ],
      ),
      //Posicion del boton flotante
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      //Configuracion del Boton flotante
      floatingActionButton: const FloatButtonUI(
        color: Color.fromARGB(255, 55, 73, 87),
        icon: Icons.add_a_photo_outlined,
        //Funcion para agregar gasto
      ),
    );
  }
}

class FloatButtonUI extends StatefulWidget {
  final IconData icon;
  final Color color;

  const FloatButtonUI({
    super.key,
    required this.icon,
    required this.color,
  });

  @override
  State<FloatButtonUI> createState() => _FloatButtonUIState();
}

class _FloatButtonUIState extends State<FloatButtonUI> {
  @override
  Widget build(BuildContext context) {
    //Esta linea de codigo me permite manejar la proporciones, es decir, el espacio que ocupara cada Widget, por ejemplo el 30% de mi pantalla "X"
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isDismissible: false,
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
              child: Column(
                children: [
                  Container(
                    width: size.width * 0.2,
                    alignment: Alignment.topCenter,
                    child: const Divider(
                      color: Colors.grey,
                      thickness: 5,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      '¿Que desea registrar?',
                      style: GoogleFonts.roboto(
                        fontSize: size.height * 0.025,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          //CONTENIDO DEL BOTON FLOTANTE
                          FloatButtonWidget(
                            //APERTURA DE LA CAMARA
                            onTap: () {},
                            title: 'Ticket',
                            subtitle: 'Registrar solo un ticket a la vez',
                            icon: Icons.camera_alt_outlined,
                            size: size,
                          ),
                          FloatButtonWidget(
                            //APERTURA DE LA GALERIA
                            onTap: () {},
                            title: 'Galeria',
                            subtitle: 'Importar ticket de la galeria',
                            icon: Icons.archive_outlined,
                            size: size,
                          ),
                          FloatButtonWidget(
                            //APERTURA DE LA GALERIA
                            onTap: () {
                              print('HACER APERTURA DEL MULTICAMARA EN TRUE');
                            },

                            title: 'Multitiket',
                            subtitle: 'Registrar multiples tickets a la vez',
                            icon: Icons.copy,
                            size: size,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        },
      ),
      //BOTON FLOTANTE
      child: BotonFlotanteWidget(
        widget: widget,
        size: size,
        widget1: widget,
      ),
    );
  }
}

//CONFIGURACION DEl CONTENIDO DE MI BOTON FLOTANTE
class FloatButtonWidget extends StatelessWidget {
  final Function onTap;
  final String title;
  final String subtitle;
  final IconData icon;
  const FloatButtonWidget({
    super.key,
    required this.size,
    required this.onTap,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Colors.grey,
              )
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon),
            ),
            title: Container(
              alignment: Alignment.center,
              child: Text(
                title,
                style: GoogleFonts.roboto(
                    fontSize: size.height * 0.02,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Container(
                alignment: Alignment.center,
                child: Text(
                  subtitle,
                  style: GoogleFonts.roboto(
                    fontSize: size.height * 0.015,
                    color: Colors.grey[700],
                  ),
                )),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    );
  }
}

//CONFIGURACION DE MI BOTON FLOTANTE
class BotonFlotanteWidget extends StatelessWidget {
  const BotonFlotanteWidget({
    super.key,
    required this.widget,
    required this.size,
    required this.widget1,
  });

  final FloatButtonUI widget;
  final Size size;
  final FloatButtonUI widget1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
          ),
        ],
      ),
      width: size.width * 0.4,
      height: size.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            width: 35,
            height: 35,
            child: Icon(
              widget.icon,
              size: 15,
              color: Colors.white,
            ),
          ),
          Text(
            'Agregar gasto',
            style: GoogleFonts.roboto(
              fontSize: size.height * 0.015,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klikticket/models/combined_model.dart';
import 'package:klikticket/providers/expenses_provider.dart';
import 'package:klikticket/utils/constants.dart';
import 'package:klikticket/utils/math_operations.dart';
import 'package:klikticket/widgets/balance_page_wt/flayer_frecuency.dart';
import 'package:klikticket/widgets/balance_page_wt/flayer_skin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'flayer_categories.dart';

class FrontSheet extends StatelessWidget {
  const FrontSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final eList = context.watch<ExpensesProvider>().eList;

    bool hasData = false;

    if (eList.isNotEmpty) {
      hasData = true;
    }

    return (eList.isNotEmpty == false)
        ? SizedBox(
            height: size.height * 0.7,
            child: const Center(
                child: SpinKitThreeBounce(
              color: Color.fromARGB(255, 24, 24, 241),
            )),
          )
        : Container(
            // height: 800.0,
            decoration: Constants.sheetBoxDecoration(Colors.white),
            child: (hasData)
                ? ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                        const FlayerSkin(
                            myTitle: 'Último Gasto',
                            myWidget: _UltimoGastoWidget()),
                        const FlayerSkin(
                            myTitle: 'Gastos en Borrador',
                            myWidget: _GastoBorradorWidget()),
                        const FlayerSkin(
                            myTitle: 'KlikCard', myWidget: _KlikCardWidget()),
                        const FlayerSkin(
                            myTitle: 'Información', myWidget: _InfoWidget()),
                        FlayerSkin(
                          myTitle: 'Liquidaciones',
                          myWidget: _LiquidacionesWidget(
                            imgList: [
                              Container(),
                              Container(),
                              Container(),
                            ],
                          ),
                        ),
                        const FlayerSkin(
                            myTitle: 'Viajes', myWidget: _ViajesWidget()),
                        FlayerSkin(
                            myTitle: 'Estadísticas',
                            myWidget: SizedBox(
                              height: 250,
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                children: const [
                                  FlayerCategories(),
                                  FlayerFrecuency(),
                                ],
                              ),
                            )),
                        const SizedBox(
                          height: 80,
                        )
                        //const FlayerSkin(myTitle: 'Categoría de Gastos', myWidget: FlayerCategories()),
                        //const FlayerSkin(myTitle: 'Frecuencia de Gastos', myWidget: FlayerFrecuency()),
                        //const FlayerSkin(myTitle: 'Movimientos', myWidget: FlayerMovements()),
                        //const FlayerSkin(myTitle: 'Balance General', myWidget: FlayerBalance()),
                      ])
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Container(
                          padding: const EdgeInsets.all(50),
                          child: Image.asset('assets/empty.png'),
                        ),
                        const Text(
                          'No tienes gastos registrados',
                          maxLines: 1,
                          style: TextStyle(fontSize: 15.0, letterSpacing: 1.3),
                        )
                      ]));
  }
}

class _ViajesWidget extends StatelessWidget {
  const _ViajesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)]),
    );
  }
}

class _LiquidacionesWidget extends StatefulWidget {
  final List<Widget> imgList;
  const _LiquidacionesWidget({
    super.key,
    required this.imgList,
  });

  @override
  State<_LiquidacionesWidget> createState() => _LiquidacionesWidgetState();
}

class _LiquidacionesWidgetState extends State<_LiquidacionesWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.imgList
        .map((item) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.grey,
                      )
                    ]),
              ),
            ))
        .toList();

    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imgList.map((url) {
            int index = widget.imgList.indexOf(url);
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 3,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}

//ULTIMO GASTO
class _UltimoGastoWidget extends StatefulWidget {
  const _UltimoGastoWidget({super.key});

  @override
  State<_UltimoGastoWidget> createState() => _UltimoGastoWidgetState();
}

class _UltimoGastoWidgetState extends State<_UltimoGastoWidget> {
  List<CombinedModel> cList = [];
  @override
  Widget build(BuildContext context) {
    cList = context.watch<ExpensesProvider>().allItemsList;
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)]),
      child: (cList.isEmpty)
          ? const Text('')
          : GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'add_expenses',
                  arguments: cList[0]),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                    'Ultimo gasto: ${cList[0].category} ${cList[0].day}/${cList[0].month}/${cList[0].year} ${getAmountFormat(cList[0].amount)}'),
              ),
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
            ),
    );
  }
}

//GASTO EN BORRADOR
class _GastoBorradorWidget extends StatelessWidget {
  const _GastoBorradorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 198, 66),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)]),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('BORRADOR'),
          Text('Tienes gastos en borrador'),
        ],
      ),
    );
  }
}

//KLIKCARD
class _KlikCardWidget extends StatelessWidget {
  const _KlikCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 198, 66),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)]),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('KLIKCARD'),
          Text('Tienes 3 gastos pendientes'),
        ],
      ),
    );
  }
}

//INFORMACION
class _InfoWidget extends StatelessWidget {
  const _InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(blurRadius: 5, color: Colors.grey),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: Text('LIQUIDACIONES'),
                  ),
                  Container(child: Text('Abiertas 1')),
                  Container(child: Text('Eviadas 1')),
                  Container(child: Text('Aprobadas 1')),
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)]),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: Text('SALDO ANTICIPO'),
                  ),
                  Text(getAmountFormat(967.20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

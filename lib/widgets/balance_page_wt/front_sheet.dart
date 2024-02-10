import 'package:flutter_spinkit/flutter_spinkit.dart';
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
                            myTitle: 'Liquidaciones', myWidget: Container()),
                        FlayerSkin(myTitle: 'Viajes', myWidget: Container()),
                        FlayerSkin(
                            myTitle: 'Estadísticas',
                            myWidget: SizedBox(
                              height: 250,
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: FlayerCategories(),
                                  ),
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
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)]),
      child: (cList.isEmpty)
          ? const Text('')
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                  'Ultimo gasto: ${cList[0].category} ${cList[0].day}/${cList[0].month}/${cList[0].year} ${getAmountFormat(cList[0].amount)}'),
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

import 'package:klikticket/models/combined_model.dart';
import 'package:klikticket/providers/expenses_provider.dart';
import 'package:klikticket/utils/constants.dart';
import 'package:klikticket/utils/utils.dart';
import 'package:klikticket/utils/math_operations.dart';
import 'package:klikticket/widgets/global_wt/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class CategoriesDetails extends StatefulWidget {
  const CategoriesDetails({Key? key}) : super(key: key);

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  @override
  Widget build(BuildContext context) {
    var cList = context.watch<ExpensesProvider>().allItemsList;
    var eList = context.watch<ExpensesProvider>().eList;
    var etList = context.watch<ExpensesProvider>().etList;
    final cModel = ModalRoute.of(context)!.settings.arguments as CombinedModel?;

    var totalEt = getAmountFormat(getSumOfEntrie(etList));

    var totalEx = getAmountFormat(getSumOfExP(eList));

    cList = cList.where((e) => e.category == cModel!.category).toList();

    return Scaffold(
  
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromARGB(255, 24, 24, 241),
            expandedHeight: 200.0,
            title: Text(cModel!.category),
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    getAmountFormat(cModel.amount),
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PercentCircular(
                            percent: cModel.amount / getSumOfExP(eList),
                            radius: 70,
                            color: Colors.blue,
                            arcType: ArcType.HALF,
                          ),
                          Text(
                            'Absorbe de tus\nIngresos: $totalEx',
                            textAlign: TextAlign.center,
                             style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 10.0),
              height: 40.0,
              
            ),
          ),
          SliverList(
            
              delegate: SliverChildBuilderDelegate((context, i) {
            var item = cList[i];
            return ListTile(
              leading: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  const Icon(Icons.calendar_today, size: 40.0),
                  Positioned(top: 16, child: Text(item.day.toString()))
                ],
              ),
              title: PercentLinear(
                percent: item.amount / cModel.amount,
                color: item.color.toColor(),
              ),
              trailing: Text(
                getAmountFormat(item.amount),
                style: const TextStyle(
                    // fontSize: 18.0,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold),
              ),
            );
          }, childCount: cList.length))
        ],
      ),
    );
  }
}

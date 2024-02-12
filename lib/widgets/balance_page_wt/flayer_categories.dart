import 'package:klikticket/models/combined_model.dart';
import 'package:klikticket/providers/ui_provider.dart';
import 'package:klikticket/widgets/charts_page_wt/chart_pie_flayer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:klikticket/providers/expenses_provider.dart';
import 'package:klikticket/utils/utils.dart';

class FlayerCategories extends StatelessWidget {
  const FlayerCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exProvider = context.watch<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();
    final gList = exProvider.grouptemsList;
    List<CombinedModel> limitList = [];
    bool hasLimit = false;

    if (gList.length >= 6) {
      limitList = gList.sublist(0, 5);
      hasLimit = true;
    }

    if (limitList.length == 5) {
      limitList.add(
          CombinedModel(category: 'Otros..', icon: 'otros', color: '#20634b'));
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)]),
        width: 320,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 130,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: (hasLimit) ? limitList.length : gList.length,
                    itemBuilder: (_, i) {
                      var item = gList[i];
                      if (hasLimit == true) item = limitList[i];
    
                      return GestureDetector(
                        onTap: () {
                          if (item.category == 'Otros..') {
                            uiProvider.bnbIndex = 1;
                            uiProvider.selectedChart = 'Gráfico Pie';
                          } else {
                            Navigator.pushNamed(context, 'cat_details',
                                arguments: item);
                          }
                        },
                        child: ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -4),
                          horizontalTitleGap: -10,
                          leading: Icon(
                            item.icon.toIcon(),
                            color: item.color.toColor(),
                          ),
                          title: Text(
                            item.category,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 11.0),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                    width: 180,
                    child: Container(
                      height: 200.0,
                      child: const ChartPieFlayer(),
                    )),
              ],
            ),
            GestureDetector(
              onTap: () {
                uiProvider.bnbIndex = 1;
                uiProvider.selectedChart = 'Gráfico Pie';
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  widthFactor: 4.5,
                  child: Text(
                    'DETALLES',
                    style: TextStyle(fontSize: 10.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

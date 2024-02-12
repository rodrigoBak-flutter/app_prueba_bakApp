import 'package:klikticket/pages/home_page.dart';
import 'package:klikticket/providers/ui_provider.dart';
import 'package:klikticket/utils/page_animation_routes.dart';
import 'package:klikticket/widgets/charts_page_wt/chart_selector.dart';
import 'package:klikticket/widgets/charts_page_wt/chart_switch.dart';
import 'package:klikticket/widgets/charts_page_wt/per_category_list.dart';
import 'package:klikticket/widgets/charts_page_wt/per_day_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class ChartsPage extends StatelessWidget {
  const ChartsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentChart = context.watch<UIProvider>().selectedChart;
    bool _isPerDay = false;

    if (currentChart == 'Gráfico Lineal' ||
        currentChart == 'Gráfico de dispersión') {
      _isPerDay = true;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 24, 24, 241),
        title: Text(currentChart),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 350.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ChartSelector(),
                    Expanded(
                      child: ChartSwitch(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              // padding: const EdgeInsets.only(top: 10.0),
              height: 40.0,

              child: Container(
                decoration: Constants.sheetBoxDecoration(Colors.white),
              ),
            ),
          ),
          (_isPerDay) ? const PerDayList() : const PerCategoryList()
        ],
      ),
    );
  }
}

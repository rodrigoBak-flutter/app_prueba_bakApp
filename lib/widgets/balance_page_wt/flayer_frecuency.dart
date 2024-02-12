import 'package:klikticket/widgets/charts_page_wt/chart_line.dart';
import 'package:flutter/material.dart';

class FlayerFrecuency extends StatelessWidget {
  const FlayerFrecuency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey)]),
        width: 400,
        height: 180.0,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: ChartLine(),
        ),
      ),
    );
  }
}

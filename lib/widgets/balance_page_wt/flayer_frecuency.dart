import 'package:klikticket/widgets/charts_page_wt/chart_line.dart';
import 'package:flutter/material.dart';

class FlayerFrecuency extends StatelessWidget {
  const FlayerFrecuency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      width: 400,
      height: 180.0,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: ChartLine(),
      ),
    );
  }
}

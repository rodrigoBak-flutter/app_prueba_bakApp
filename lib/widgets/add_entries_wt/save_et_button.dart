import 'package:klikticket/models/combined_model.dart';
import 'package:klikticket/providers/ui_provider.dart';
import 'package:klikticket/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../providers/expenses_provider.dart';

class SaveEtButton extends StatelessWidget {
  final CombinedModel cModel;
  const SaveEtButton({Key? key, required this.cModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();

    return GestureDetector(
        onTap: () {
          if (cModel.amount != 0.00) {
            exProvider.addNewEntrie(cModel);
            Fluttertoast.showToast(
                msg: 'Ingreso agregado 👍',
                backgroundColor: const Color.fromARGB(255, 24, 24, 241));
            uiProvider.bnbIndex = 0;
            Navigator.pop(context);
          } else if (cModel.amount == 0.0) {
            Fluttertoast.showToast(
                msg: 'No olvides agregar un ingreso',
                backgroundColor: Colors.red);
          }
        },
        child: SizedBox(
          height: 70.0,
          width: 150.0,
          child: Constants.customButton(
              const Color.fromARGB(255, 24, 24, 241), Colors.white, 'GUARDAR'),
        ));
  }
}

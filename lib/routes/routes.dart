import 'package:flutter/material.dart';
import 'package:klikticket/pages/add_expenses.dart';
import 'package:klikticket/pages/categories_details.dart';
import 'package:klikticket/pages/expenses_details.dart';
import 'package:klikticket/pages/home_page.dart';
import 'package:klikticket/pages/loading_page.dart';
import 'package:klikticket/pages/login_page.dart';

/*

--- Este es un mapa de rutas me permite centralizar todas mis pantallas en un solo archivo 

y tener mas control sobre las mismas, manteniendo mi arquitectura mucho mas limpia ------

*/

final Map<String, Widget Function(BuildContext)> appRoutes = {
  //Se puede enrutar de las dos maneras, poniendo el context o en su lugar un " _ "
  'loading': (_) => const LoadingPage(),
  'login': (_) => const LoginPage(),
  'home': (_) => const HomePage(),
  'add_expenses': (_) => const AddExpenses(),
  'exp_details': (_) => const ExpensesDetails(),
  'cat_details': (_) => const CategoriesDetails(),
};

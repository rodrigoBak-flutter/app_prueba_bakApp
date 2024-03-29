import 'package:klikticket/pages/aprobador.dart';
import 'package:klikticket/pages/expenses_details.dart';
import 'package:klikticket/pages/liquidaciones.dart';

import 'package:klikticket/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:klikticket/widgets/mas/setting_screen.dart';
import 'package:provider/provider.dart';

import 'package:klikticket/providers/ui_provider.dart';
import 'package:klikticket/pages/balance_page.dart';

import '../widgets/home_page_wt/custom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomNavigationBar(),
      body: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final exProvider = context.read<ExpensesProvider>();
    final DateTime _date = DateTime.now();

    final currentIndex = uiProvider.bnbIndex;
    final currentMonth = uiProvider.selectedMonth + 1;

    switch (currentIndex) {
      case 0:
        exProvider.getExpensesByDate(currentMonth, _date.year);
        exProvider.getEntriesByDate(currentMonth, _date.year);
        exProvider.getAllFeatures();
        return const BalancePage();
      case 1:
        return const ExpensesDetails();
      case 2:
        return const LiquidacionesPage();
      case 3:
        return const AprobadorPage();
      case 4:
        return const SettingScreen();
      // return const SettingPage();

      default:
        return const BalancePage();
    }
  }
}

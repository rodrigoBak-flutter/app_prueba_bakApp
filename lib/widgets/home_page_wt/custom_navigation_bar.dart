import 'package:klikticket/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    
    return BottomNavigationBar(
      currentIndex: uiProvider.bnbIndex,
      onTap: (int i) => uiProvider.bnbIndex = i,
      elevation: 0.0,
      selectedItemColor: const Color.fromARGB(255, 24, 24, 241),
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: 
      const [
        BottomNavigationBarItem(label: 'Dashboard', icon: Icon(Icons.dashboard_customize_outlined)),
        BottomNavigationBarItem(label: 'Gastos', icon: Icon(Icons.receipt_outlined)),
        BottomNavigationBarItem(label: 'Liquidaciones', icon: Icon(Icons.receipt_long_outlined)),
        BottomNavigationBarItem(label: 'Aprobador', icon: Icon(Icons.person_2_outlined)),
        BottomNavigationBarItem(label: 'Mas', icon: Icon(Icons.more_horiz)),
      ]
    );
  }
}
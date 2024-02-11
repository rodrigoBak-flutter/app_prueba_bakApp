import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klikticket/pages/add_expenses.dart';
import 'package:klikticket/utils/page_animation_routes.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageAnimationRoutes(
              widget: const AddExpenses(),
            ));
      },
      child: Container(
        width: 150,
        height: 40,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 55, 73, 87),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            const Icon(Icons.add,color: Colors.white),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Agregar gasto',
                style: GoogleFonts.roboto(
                  fontSize: size.height * 0.016,
                  color: Colors.white
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}


/*
    List<SpeedDialChild> childButtons = [];

    childButtons.add(
      SpeedDialChild(
        backgroundColor: Colors.red,
        child: const Icon(Icons.remove),
        label: 'Gasto',
        labelStyle: const TextStyle(
          fontSize: 18.0
        ),
        onTap: (){
          Navigator.push(
            context, 
            PageAnimationRoutes(
              widget: const AddExpenses(),
              ejex: 0.8,
              ejey: 0.8
            )
          );
        }
      )
    );

    childButtons.add(
      SpeedDialChild(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        label: 'Ingreso',
        labelStyle: const TextStyle(
          fontSize: 18.0
        ),
        onTap: (){
          Navigator.push(
            context, 
            PageAnimationRoutes(
              widget: const AddEntries(),
              ejex: 0.8,
              ejey: 0.8        
            ),
          );
        }
      )
    );


    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      children: childButtons,
      spacing: 10.0,
      childMargin: const EdgeInsets.symmetric(horizontal: 6.0),
      childrenButtonSize: const Size(60, 60),
    );

 */
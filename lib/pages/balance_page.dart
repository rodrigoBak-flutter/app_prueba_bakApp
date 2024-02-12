import 'package:klikticket/widgets/balance_page_wt/custom_fab.dart';
import 'package:klikticket/widgets/balance_page_wt/front_sheet.dart';
import 'package:klikticket/widgets/mas/bloque_1/notificaciones/notificaciones.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:klikticket/utils/page_animation_routes.dart';
import 'package:klikticket/pages/add_expenses.dart';
import 'package:flutter/material.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({Key? key}) : super(key: key);

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  String shortcut = 'Ninguna acción establecida';
  final _scrollController = ScrollController();
  double _offset = 0;

  void _listener() {
    setState(() {
      _offset = _scrollController.offset / 100;
      if (_offset > 0.80) _offset = 0.80;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_listener);

    //INGRESO DIRECTO MANTENIENDO EL CLICK EN EL ICONO(POR FUERA DE LA APLICACION)
    const QuickActions quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      shortcut = shortcutType;
      if (shortcutType == "nuevo-ticket") {
        Navigator.pushAndRemoveUntil(
                      context,
                      PageAnimationRoutes(
                        widget: const AddExpenses(),
                      ),
                      ModalRoute.withName(''));
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
          type: 'nuevo-ticket',
          localizedTitle: 'Nuevo Ticket',
          icon: 'ic_launcher'),
    ]).then((void _) {
      setState(() {
        if (shortcut == 'ninguna acción establecida') {
          shortcut = 'acciones listas';
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const CustomFAB(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromARGB(255, 24, 24, 241),
            expandedHeight: 125.0,
            title: SizedBox(
              width: 200,
              child: Image.asset('assets/logo_blanco.png'),
            ),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Align(
                  alignment: Alignment(_offset, 1),
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      'Nombre Apellido',
                      style: TextStyle(fontSize: 12),
                    ),
                  )),
              centerTitle: true,
            ),
            actions: [
              IconButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  PageAnimationRoutes(widget: const NotificacionesScreen()),
                  ModalRoute.withName('')), icon: const Icon(Icons.notifications))
            ],
          ),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              const FrontSheet(),
            ],
          ))
        ],
      ),
    );
  }
}

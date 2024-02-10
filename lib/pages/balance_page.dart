import 'package:klikticket/widgets/balance_page_wt/custom_fab.dart';
import 'package:klikticket/widgets/balance_page_wt/front_sheet.dart';

import 'package:flutter/material.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({Key? key}) : super(key: key);

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
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
                      'Carlos Garmendia',
                      style: TextStyle(fontSize: 12),
                    ),
                  )),
              centerTitle: true,
            ),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.notifications))
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

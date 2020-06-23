




import 'package:Borhan_User/screens/test/menu_page.dart';
import 'package:Borhan_User/screens/test/zoom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage2 extends StatefulWidget {
  @override
  _MyHomePage2State createState() => new _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> with TickerProviderStateMixin {
  MenuController menuController;

  @override
  void initState() {
    super.initState();

    menuController = new MenuController(
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ChangeNotifierProvider.value(
      value: menuController,
     // builder: (context) => menuController,
      child: ZoomScaffold(
        menuScreen: MenuScreen(),
        contentScreen: Layout(
            contentBuilder: (cc) => Container(
                  color: Colors.grey[200],
                  child: Container(
                    color: Colors.grey[200],
                  ),
                )),
      ),
     ),
    );
  }
}
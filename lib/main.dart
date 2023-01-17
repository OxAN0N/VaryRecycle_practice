import 'package:flutter/material.dart';
import 'package:varyrecycle/screens/home.dart';
import 'package:varyrecycle/screens/user.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final PageController _clickPage = PageController(
    initialPage: 0,
  );

  int _clickedPage = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        color: const Color.fromRGBO(254, 254, 252, 1),
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: IconButton(
                icon: Icon(
                  Icons.home,
                  color: _clickedPage == 0
                      ? Colors.lightGreen
                      : const Color.fromRGBO(58, 60, 59, 1),
                ),
                onPressed: () {
                  setState(() {
                    _clickPage.jumpToPage(0);
                    _clickedPage = 0;
                  });
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(
                  Icons.person,
                  color: _clickedPage == 1
                      ? Colors.lightGreen
                      : const Color.fromRGBO(58, 60, 59, 1),
                ),
                onPressed: () {
                  setState(() {
                    _clickPage.jumpToPage(1);
                    _clickedPage = 1;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen.shade500,
        child: const Icon(Icons.camera),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _clickPage,
        children: const [
          HomePage(),
          UserPage(),
        ],
      ),
    ));
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:varyrecycle/screens/camera.dart';
import 'package:varyrecycle/screens/home.dart';
import 'package:varyrecycle/screens/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MaterialApp(
    home: App(
      camera: firstCamera,
    ),
  ));
}

class App extends StatefulWidget {
  final CameraDescription camera;
  const App({super.key, required this.camera});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final PageController _clickPage = PageController(
    initialPage: 0,
  );

  int _clickedPage = 0;

  void _openCameraPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePictureScreen(
                  camera: widget.camera,
                )));
  }

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
        elevation: 200,
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
        onPressed: _openCameraPage,
        child: const Icon(Icons.camera),
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

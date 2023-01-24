import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

// 사용자가 주어진 카메라를 사용하여 사진을 찍을 수 있는 화면
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.veryHigh,
    );
    _initializeControllerFuture = _controller.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Future가 완료되면, 프리뷰를 보여줍니다.
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CameraPreview(_controller),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white70,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      IconButton(
                          onPressed: () async {
                            // try / catch 블럭에서 사진을 촬영합니다. 만약 뭔가 잘못된다면 에러에
                            // 대응할 수 있습니다.
                            try {
                              // 카메라 초기화가 완료됐는지 확인합니다.
                              await _initializeControllerFuture;

                              // path 패키지를 사용하여 이미지가 저장될 경로를 지정합니다.
                              final path = join(
                                // 본 예제에서는 임시 디렉토리에 이미지를 저장합니다. `path_provider`
                                // 플러그인을 사용하여 임시 디렉토리를 찾으세요.
                                (await getTemporaryDirectory()).path,
                                '${DateTime.now()}.png',
                              );

                              // 사진 촬영을 시도하고 저장되는 경로를 로그로 남깁니다.
                              await _controller.takePicture();

                              // 사진을 촬영하면, 새로운 화면으로 넘어갑니다.
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DisplayPictureScreen(imagePath: path),
                                ),
                              );
                            } catch (e) {
                              // 만약 에러가 발생하면, 콘솔에 에러 로그를 남깁니다.
                              print(e);
                            }
                          },
                          icon: const Icon(
                            Icons.camera,
                            color: Colors.white70,
                            size: 50,
                          )),
                      const SizedBox(
                        width: 75,
                      )
                    ],
                  )
                ],
              ),
            );
          } else {
            // 그렇지 않다면, 진행 표시기를 보여줍니다.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.black,
      //   shape: const CircularNotchedRectangle(),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       IconButton(
      //         icon: const Icon(
      //           Icons.arrow_back_ios_new,
      //           color: Colors.white70,
      //           size: 30,
      //         ),
      //         onPressed: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       IconButton(
      //           onPressed: () async {
      //             // try / catch 블럭에서 사진을 촬영합니다. 만약 뭔가 잘못된다면 에러에
      //             // 대응할 수 있습니다.
      //             try {
      //               // 카메라 초기화가 완료됐는지 확인합니다.
      //               await _initializeControllerFuture;

      //               // path 패키지를 사용하여 이미지가 저장될 경로를 지정합니다.
      //               final path = join(
      //                 // 본 예제에서는 임시 디렉토리에 이미지를 저장합니다. `path_provider`
      //                 // 플러그인을 사용하여 임시 디렉토리를 찾으세요.
      //                 (await getTemporaryDirectory()).path,
      //                 '${DateTime.now()}.png',
      //               );

      //               // 사진 촬영을 시도하고 저장되는 경로를 로그로 남깁니다.
      //               await _controller.takePicture();

      //               // 사진을 촬영하면, 새로운 화면으로 넘어갑니다.
      //               // ignore: use_build_context_synchronously
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) =>
      //                       DisplayPictureScreen(imagePath: path),
      //                 ),
      //               );
      //             } catch (e) {
      //               // 만약 에러가 발생하면, 콘솔에 에러 로그를 남깁니다.
      //               print(e);
      //             }
      //           },
      //           icon: const Icon(
      //             Icons.camera,
      //             color: Colors.white70,
      //             size: 50,
      //           )),
      //       const SizedBox(
      //         width: 75,
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}

// 사용자가 촬영한 사진을 보여주는 위젯
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // 이미지는 디바이스에 파일로 저장됩니다. 이미지를 보여주기 위해 주어진
      // 경로로 `Image.file`을 생성하세요.
      body: Image.file(File(imagePath)),
    );
  }
}

import 'package:camera/camera.dart';
import 'package:filter_camera/widget/filter_carousel.dart';
import 'package:flutter/material.dart';

class TakepictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakepictureScreen({Key? key, required this.camera}) : super(key: key);

  @override
  _TakepictureScreenState createState() => _TakepictureScreenState();
}

class _TakepictureScreenState extends State<TakepictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: PhotoFilterCarousel(cameraController: _controller),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
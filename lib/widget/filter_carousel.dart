import 'package:filter_camera/widget/filter_selector.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class PhotoFilterCarousel extends StatefulWidget {
  final CameraController cameraController;

  const PhotoFilterCarousel({
    super.key,
    required this.cameraController,
  });

  @override
  State<PhotoFilterCarousel> createState() => _PhotoFilterCarouselState();
}

class _PhotoFilterCarouselState extends State<PhotoFilterCarousel> {
  final _filters = [
    Colors.white,
    ...List.generate(
      Colors.primaries.length,
      (index) => Colors.primaries[(index * 4) % Colors.primaries.length],
    )
  ];

  final _filterColor = ValueNotifier<Color>(Colors.white);

  void _onFilterChanged(Color value) {
    _filterColor.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        children: [
          _buildCameraPreview(),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: _buildFilterSelector(),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraPreview() {
    return ValueListenableBuilder<Color>(
      valueListenable: _filterColor,
      builder: (context, color, child) {
        return ColorFiltered(
          // Terapkan filter warna di sini
          colorFilter: ColorFilter.mode(
            color.withOpacity(0.5),
            BlendMode.color,
          ),
          child: ClipRect(
            child: AspectRatio(
              aspectRatio: widget.cameraController.value.aspectRatio,
              child: CameraPreview(widget.cameraController),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterSelector() {
    return FilterSelector(
      onFilterChanged: _onFilterChanged,
      filters: _filters,
    );
  }
}
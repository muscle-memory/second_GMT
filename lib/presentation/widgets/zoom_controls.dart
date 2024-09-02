import 'dart:math';
import 'package:flutter/material.dart';

class ZoomControls extends StatefulWidget {
  final TransformationController controller;

  const ZoomControls({
    super.key,
    required this.controller,
  });

  @override
  ZoomControlsState createState() => ZoomControlsState();
}

class ZoomControlsState extends State<ZoomControls> {
  double _scale = 1.0;

  void _zoomIn() {
    setState(() {
      _scale = min(_scale * 1.2, 3.0);
      widget.controller.value = Matrix4.identity()..scale(_scale);
    });
  }

  void _zoomOut() {
    setState(() {
      _scale = max(_scale / 1.2, 1.0);
      widget.controller.value = Matrix4.identity()..scale(_scale);
    });
  }

  void _resetZoom() {
    setState(() {
      _scale = 1.0;
      widget.controller.value = Matrix4.identity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          onPressed: _zoomIn,
          backgroundColor: Colors.blue,
          child: const Icon(Icons.zoom_in),
        ),
        const SizedBox(height: 20),
        FloatingActionButton(
          onPressed: _zoomOut,
          backgroundColor: Colors.blue,
          child: const Icon(Icons.zoom_out),
        ),
        const SizedBox(height: 20),
        FloatingActionButton(
          onPressed: _resetZoom,
          backgroundColor: Colors.blue,
          child: const Icon(Icons.flag),
        ),
      ],
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';

class ZoomControls extends StatefulWidget {
  final TransformationController controller;
  final ValueChanged<bool> onTouchChange;
  final bool isHandlingTouches;

  const ZoomControls({
    super.key,
    required this.controller,
    required this.onTouchChange,
    required this.isHandlingTouches,
  });

  @override
  ZoomControlsState createState() => ZoomControlsState();
}

class ZoomControlsState extends State<ZoomControls> {
  double _scale = 1.0;

  void _zoomIn() {
    setState(() {
      _scale = min(_scale * 1.2, 2.5);
      widget.controller.value = Matrix4.diagonal3Values(_scale, _scale, 1.0);
    });
  }

  void _zoomOut() {
    setState(() {
      _scale = max(_scale / 1.2, 1.0);
      widget.controller.value = Matrix4.diagonal3Values(_scale, _scale, 1.0);
    });
  }

  void _toggleHandleTouches() {
    widget.onTouchChange(!widget.isHandlingTouches);
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
        const SizedBox(height: 10),
        FloatingActionButton(
          onPressed: _zoomOut,
          backgroundColor: Colors.blue,
          child: const Icon(Icons.zoom_out),
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          onPressed: _toggleHandleTouches,
          backgroundColor: Colors.blue,
          child: const Icon(Icons.info),
        ),
      ],
    );
  }
}

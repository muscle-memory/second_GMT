import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/GridPainter.dart';
import '../widgets/Tooltip_container.dart';
import '../widgets/zoom_controls.dart';
import 'package:chart_sample/utils/trace_data_loader.dart';

class LineChartScreen extends StatefulWidget {
  final TransformationController transformationController;

  const LineChartScreen({
    super.key,
    required this.transformationController,
  });

  @override
  State<LineChartScreen> createState() => _LineChartScreenState();
}

class _LineChartScreenState extends State<LineChartScreen> {
  OverlayEntry? _overlayEntry;
  List<Map<String, double>> traceData = [];
  bool _shouldRemoveTooltip = true;
  Offset? _markerPosition;
  Size? _containerSize;
  Offset _transformedPosition = Offset.zero;
  Size _containerSizeState = Size.zero;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    traceData = await loadTraceData();
    setState(() {});
  }

  void _onMarkerPressed(Offset transformedPosition, Size containerSize) {
    final Map<String, double>? matchedPoint =
    _findPointByRatio(transformedPosition.dx, containerSize.width);

    setState(() {
      _shouldRemoveTooltip = false;
      _markerPosition = transformedPosition;
      _containerSize = containerSize;

      print('\nMarker X: ${matchedPoint?['x']} Y: ${matchedPoint?['y']}');
    });
  }

  void _updateTooltip(Offset position, Offset transformedPosition, Size containerSize, double containerHeight) {
    final Map<String, double>? matchedPoint =
    _findPointByRatio(transformedPosition.dx, containerSize.width);

    if (_shouldRemoveTooltip) {
      _removeTooltip();
    }

    setState(() {
      _overlayEntry = _createTooltip(position, matchedPoint, containerHeight);
      Overlay.of(context)?.insert(_overlayEntry!);
    });

    _shouldRemoveTooltip = true;
  }

  void _removeTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createTooltip(Offset Position, Map<String, double>? matchedPoint, double containerHeight) {
    String message = '';

    if (matchedPoint != null) {
      message = '\n X: ${matchedPoint['x']}\n Y: ${matchedPoint['y']}';
    }

    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              left: Position.dx,
              top: 150,
              child: TooltipContainer(
                message: message,
                containerHeight: containerHeight,
              ),
            ),
          ],
        );
      },
    );
  }

  Map<String, double>? _findPointByRatio(double clickedX, double containerWidth) {
    if (traceData.isEmpty) return null;

    double minX = traceData.first['x']!;
    double maxX = traceData.last['x']!;

    double clickRatio = clickedX / containerWidth;
    double actualX = minX + (clickRatio * (maxX - minX));

    Map<String, double>? closestPoint;
    double closestDistance = double.infinity;

    for (var point in traceData) {
      double x = point['x']!;
      double distance = (x - actualX).abs();

      if (distance < closestDistance) {
        closestDistance = distance;
        closestPoint = point;
      }
    }

    return closestPoint;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Line Chart Example'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: traceData.isEmpty ? const Text('Loading') : _buildChart(),
        ),
      ),
    );
  }

  Widget _buildChart() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double containerHeight = constraints.maxHeight;
                return GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    Offset position = details.localPosition;
                    final RenderBox renderBox = context.findRenderObject() as RenderBox;
                    Offset localPosition = renderBox.globalToLocal(details.globalPosition);

                    Matrix4 matrix = widget.transformationController.value;
                    double scaleX = matrix.getMaxScaleOnAxis();
                    Offset transPosition = Offset(
                        matrix.getTranslation().x, matrix.getTranslation().y);

                    Offset transformedPosition = (localPosition - transPosition) / scaleX;

                    final Size containerSize = Size(constraints.maxWidth, constraints.maxHeight);
                    _updateTooltip(position, transformedPosition, containerSize, containerHeight);

                    setState(() {
                      _transformedPosition = transformedPosition;
                      _containerSizeState = containerSize;
                    });
                  },
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: Size(constraints.maxWidth, constraints.maxHeight),
                        painter: GridPainter(),
                      ),
                      Container(
                        width: constraints.maxWidth,
                        height: containerHeight,
                        decoration: BoxDecoration(
                          border: const Border(
                            left: BorderSide(color: Colors.black, width: 4.0),
                            bottom: BorderSide(color: Colors.black, width: 4.0),
                          ),
                        ),
                        child: InteractiveViewer(
                          transformationController: widget.transformationController,
                          panEnabled: true,
                          scaleEnabled: true,
                          minScale: 1.0,
                          maxScale: 3.0,
                          child: SvgPicture.asset(
                            'lib/assets/chart2.svg',
                            alignment: Alignment.bottomLeft,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 50),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ZoomControls(
                controller: widget.transformationController,
                onMarkerPressed: _onMarkerPressed,
                transformedPosition: _transformedPosition,
                containerSize: _containerSizeState,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

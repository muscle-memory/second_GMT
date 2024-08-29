import 'package:flutter/services.dart' show rootBundle;

Future<List<Map<String, double>>> loadTraceData() async {
  String traceString = await rootBundle.loadString('lib/assets/cmp_c.txt');
  List<Map<String, double>> traceData = [];

  List<String> lines = traceString.split('\n');

  for (String line in lines) {
    List<String> values = line.split(RegExp(r'[,\s]+')).map((value) =>
        value.trim()).toList();

    // x와 y 값이 존재할 경우
    if (values.length == 2) {
      double? x = double.tryParse(values[0]);
      double? y = double.tryParse(values[1]);

      if (x != null && y != null) {
        traceData.add({'x': x, 'y': y});
      }
    }
  }
  return traceData;
}
import 'dart:convert' as convert;
import 'dart:io';

void commonGenerateEnv(String path) async {
  final s = Platform.pathSeparator;

  try {
    final json = await File(path).readAsString();
    // If the file is empty, json.decode will throw a FormatException.
    // Guard against empty content and treat it as an empty map.
    final map = json.trim().isEmpty
        ? <String, dynamic>{}
        : convert.json.decode(json) as Map<String, dynamic>;

    final fileName = 'lib${s}main_config${s}environment.dart';

    await File(fileName).writeAsString(
      '// ignore_for_file: prefer_single_quotes\nconst Map<String,dynamic> env = ${convert.json.encode(map)};',
    );
  } catch (e) {
    // ignore: avoid_print
    print(e.toString());
  }
}

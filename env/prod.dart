import 'dart:io';

import 'common.dart';

void main() {
  final s = Platform.pathSeparator;

  commonGenerateEnv('config${s}prod_config.json');
}

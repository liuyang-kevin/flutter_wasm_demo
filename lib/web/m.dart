@JS()
library f_wasm;

import 'package:js/js.dart';

@JS("window.Module")
class Module {
  @JS("_version")
  external static String version();
  @JS("_add")
  external static int add(int a, int b);
}

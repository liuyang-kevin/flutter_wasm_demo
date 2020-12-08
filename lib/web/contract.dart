// import 'package:wasm_interop/wasm_interop.dart';
// import 'package:flutter/services.dart' show rootBundle;

// abstract class WasmContract {
//   WasmContract.loadFromAsset(String path);
//   Future<bool> initialized();

//   Object callfunc(String name, List<int> input);

//   bool get isLoaded;
// }

// class WasmLoader extends WasmContract {
//   Instance _wasmInstance;
//   String _path;

//   WasmLoader.loadFromAsset(String path)
//       : _path = path,
//         super.loadFromAsset(path);

//   @override
//   Future<bool> initialized() async {
//     assert(_path != null);
//     // rootBundle.load("packages/f_wasm/web/cmake-emscripten-explore.wasm");
//     // rootBundle.load("cmake-emscripten-explore.wasm");

//     // try {
//     //   print(_path);
//     //   final bytes = await rootBundle.load(_path);
//     //   print(bytes);
//     //   _wasmInstance = await Instance.fromBufferAsync(bytes.buffer);

//     //   return isLoaded;
//     // } catch (exc) {
//     //   print('ERROR WHILE INITIALIZING ${exc.toString()}');
//     // }

//     return false;
//   }

//   @override
//   bool get isLoaded => _wasmInstance != null;

//   @override
//   Object callfunc(String name, List<int> input) {
//     final _func = _wasmInstance.functions[name];
//     return _func.call(input.first, input.last);
//   }
// }

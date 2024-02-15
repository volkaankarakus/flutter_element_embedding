import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:html';
import 'package:js/js.dart' as js;
import 'package:js/js_util.dart' as js_util;

class ElementEmbeddingView extends StatefulWidget {
  const ElementEmbeddingView({super.key});

  @override
  State<ElementEmbeddingView> createState() => _ElementEmbeddingViewState();
}

@js.JSExport() // this annotation creates a JS Object
class _ElementEmbeddingViewState extends State<ElementEmbeddingView> {
  int _counter = 0;

  final _streamController = StreamController<void>.broadcast();

  @override
  void initState() {
    super.initState();
    final export = js_util.createDartExport(this);
    // These two are used inside the [js/js-interop.js]
    js_util.setProperty(js_util.globalThis, '_appState', export);
    js_util.callMethod<void>(js_util.globalThis, '_stateSet', []);
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @js.JSExport()
  void increment() {
    setState(() {
      _counter++;
      _streamController.add(null);
    });
  }

  @js.JSExport()
  void addHandler(void Function() handler) {
    _streamController.stream.listen((event) {
      handler();
    });
  }

  @js.JSExport()
  int get count => _counter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(_counter.toString()),
          IconButton(onPressed: increment, icon: Icon(Icons.add))
        ],
      ),
    );
  }
}

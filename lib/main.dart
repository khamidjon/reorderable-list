import 'dart:ui';

import 'package:flutter/material.dart';

// For more: https://api.flutter.dev/flutter/material/ReorderableListView-class.html

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Reorderable list'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _items = List<int>.generate(50, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ReorderableListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final int item = _items.removeAt(oldIndex);
            _items.insert(newIndex, item);
          });
        },
        proxyDecorator: (Widget child, int index, Animation<double> animation) {
          return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, _) {
              final animValue = Curves.easeInOut.transform(animation.value);
              final scale = lerpDouble(1, 1.05, animValue);
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
          );
        },
        children: [
          for (int index = 0; index < _items.length; index += 1)
            Card(
              key: ValueKey(index),
              color: Colors.primaries[_items[index] % Colors.primaries.length],
              child: SizedBox(
                height: 80,
                child: Center(
                  child: Text('Card ${_items[index]}'),
                ),
              ),
            )
        ],
      ),
    );
  }
}

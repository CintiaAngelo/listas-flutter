import 'package:flutter/material.dart';
 
void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}
 
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
 
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
  double iconSize = 200; // Tamanho inicial (M)
  int red = 0;
  int green = 0;
  int blue = 0;
 
  static const double minSize = 100;
  static const double maxSize = 300;
 
  void increaseSize() {
    setState(() {
      if (iconSize + 10 <= maxSize) {
        iconSize += 10;
      }
    });
  }
 
  void decreaseSize() {
    setState(() {
      if (iconSize - 10 >= minSize) {
        iconSize -= 10;
      }
    });
  }
 
  void setSize(double size) {
    setState(() {
      iconSize = size.clamp(minSize, maxSize);
    });
  }
 
  void updateColor(String channel, double value) {
    setState(() {
      int v = value.toInt();
      switch (channel) {
        case 'r':
          red = v;
          break;
        case 'g':
          green = v;
          break;
        case 'b':
          blue = v;
          break;
      }
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter State'),
        actions: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: decreaseSize,
          ),
          IconButton(
            icon: const Text('S'),
            onPressed: () => setSize(100),
          ),
          IconButton(
            icon: const Text('M'),
            onPressed: () => setSize(200),
          ),
          IconButton(
            icon: const Text('L'),
            onPressed: () => setSize(300),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: increaseSize,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Icon(
                Icons.lock_clock,
                size: iconSize,
                color: Color.fromARGB(255, red, green, blue),
              ),
            ),
          ),
          buildSlider('R', red, Colors.red, (value) => updateColor('r', value)),
          buildSlider('G', green, Colors.green, (value) => updateColor('g', value)),
          buildSlider('B', blue, Colors.blue, (value) => updateColor('b', value)),
        ],
      ),
    );
  }
 
  Widget buildSlider(String label, int value, Color color, ValueChanged<double> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Slider(
              activeColor: color,
              value: value.toDouble(),
              min: 0,
              max: 255,
              onChanged: onChanged,
            ),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
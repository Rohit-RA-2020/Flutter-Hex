import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  var cont = <Offset>[];

  final Map<Coordinates, String> _map = {
    const Coordinates.cube(0, 0, 0): "Pronunciation",
    const Coordinates.cube(1, 0, -1): "Grammar",
    const Coordinates.cube(1, -1, 0): "Emotion",
    const Coordinates.cube(0, -1, 1): "Intonation",
    const Coordinates.cube(-1, 1, 0): "Fluency",
    const Coordinates.cube(0, 1, -1): "Vocabulary",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF23264C),
      appBar: AppBar(
        title: const Text('My Hexagoan'),
      ),
      body: Center(child: _buildGrid(context)),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: SizedBox(
          width: double.infinity,
          height: 50.0,
          child: ElevatedButton(
            child: const Text('Continue'),
            onPressed: () {},
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildGrid(BuildContext context) {
    return InteractiveViewer(
      minScale: 0.2,
      maxScale: 4.0,
      child: HexagonGrid(
        hexType: HexagonType.FLAT,
        color: const Color(0xFF23264C),
        depth: 1,
        buildTile: (coordinates) =>
            coordinates != const Coordinates.cube(-1, 0, 1)
                ? HexagonWidgetBuilder(
                    padding: 2.0,
                    cornerRadius: 8.0,
                    color: cont.contains(Offset(
                            coordinates.x.toDouble(), coordinates.y.toDouble()))
                        ? const Color(0xFF6B72FE)
                        : const Color(0xFF0D0B16),
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            cont = [];
                            cont.add(Offset(coordinates.x.toDouble(),
                                coordinates.y.toDouble()));
                          });
                        },
                        child: Center(
                          child: Text(
                            _map[coordinates] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Text('${coordinates.x}, ${coordinates.y}, ${coordinates.z}\n  ${coordinates.q}, ${coordinates.r}'),
                  )
                : HexagonWidgetBuilder(color: Colors.transparent),
      ),
    );
  }
}

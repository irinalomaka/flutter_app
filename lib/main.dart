import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: HomePage(title: 'Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  List colors = [
    Colors.white,
    Colors.lightGreen[200],
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.blue[300],
    Colors.pink[200]
  ];

  Random random = new Random();

  void _getRandomIndex() {
    setState(() => index = random.nextInt(7));
  }

  _getToggleBoxDecoration() {
    return new BoxDecoration(color: colors[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: InkWell(
          onTap: _getRandomIndex,
          child: Container(
            decoration: _getToggleBoxDecoration(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Hey there!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    'It\'s my first Flutter App',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(_createRoute());
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SecondPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      });
}

class SecondPage extends StatefulWidget {
  SecondPage({Key key}) : super(key: key);

  @override
  _SecondPageWidgetState createState() => _SecondPageWidgetState();
}

class _SecondPageWidgetState extends State<SecondPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _getSelectedItem() {
    if (_selectedIndex == 0) {
      return new MyListStatelessWidget();
    } else {
      return new MyImageStatelessWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: _getSelectedItem(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('List'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            title: Text('Image'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}

class MyListStatelessWidget extends StatelessWidget {
  final List<String> items = List<String>.generate(100, (i) => "Message $i");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              ListTile(title: Text('${items[index]}')),
              Divider()
            ],
          );
        },
      ),
    );
  }
}

class MyImageStatelessWidget extends StatelessWidget {
  static var assetsImage = new AssetImage(
      'assets/cat_1.jpg'); //<- Creates an object that fetches an image.
  static var image = new Image(image: assetsImage, fit: BoxFit.cover);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(child: image),
      ),
    );
  }
}

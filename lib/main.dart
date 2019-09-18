import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Drag & Drop Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ItemModel> items;
  List<ItemModel> items2;
  int score;

  @override
  void initState() {
    super.initState();
    initGame();
    score = 0;
  }

  initGame() {
    items = [
      ItemModel(icon: FontAwesomeIcons.google, name: 'Google', value: 'google'),
      ItemModel(
          icon: FontAwesomeIcons.facebook, name: 'Facebook', value: 'facebook'),
      ItemModel(
          icon: FontAwesomeIcons.twitter, name: 'Twitter', value: 'twitter'),
      ItemModel(
          icon: FontAwesomeIcons.linkedin, name: 'LinkedIn', value: 'linkedin'),
      ItemModel(
          icon: FontAwesomeIcons.instagram,
          name: 'Instagram',
          value: 'instagram')
    ];
    items2 = List<ItemModel>.from(items);
    items.shuffle();
    items2.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text.rich(TextSpan(children: [
                TextSpan(text: 'Score: '),
                TextSpan(
                    text: '$score',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0))
              ])),
              Row(children: <Widget>[
                Column(
                  children: items.map((item) {
                    return Container(
                        margin: EdgeInsets.all(8.0),
                        child: Draggable<ItemModel>(
                            data: item,
                            childWhenDragging: Icon(
                              item.icon,
                              color: Colors.grey,
                              size: 50.0,
                            ),
                            feedback: Icon(
                              item.icon,
                              color: Colors.red,
                              size: 50.0,
                            ),
                            child: Icon(item.icon,
                                color: Colors.red, size: 50.0)));
                  }).toList(),
                ),
                Spacer(),
                Column(
                  children: items.map((item) {
                    return DragTarget<ItemModel>(
                      onWillAccept: (receivedItem) => true,
                      onAccept: (receivedItem) {
                        if (item.value == receivedItem.value) {
                          setState(() {
                            items.remove(receivedItem);
                            items2.remove(item);
                            score += 10;
                          });
                        } else {
                          setState(() {
                            score -= 5;
                          });
                        }
                      },
                      builder: (context, acceptedItems, rejectedItems) =>
                          Container(
                        color: Colors.red,
                        height: 50.0,
                        width: 100.0,
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(8.0),
                        child: Text(
                          item.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemModel {
  final String name;
  final String value;
  final IconData icon;
  ItemModel({this.name, this.value, this.icon});
}

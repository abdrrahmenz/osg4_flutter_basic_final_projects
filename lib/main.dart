import 'package:flutter/material.dart';
import 'package:osg4_tugas_akhir/model/card_model.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<CardModel>> future() async {
    http.Response response =
        await http.get('https://db.ygoprodeck.com/api/v5/cardinfo.php?num=14');
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((m) => new CardModel.fromJson(m)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('OSG 4 Flutter'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _showDialog();
              },
            ),
          ],
        ),
        body: Builder(builder: (BuildContext context) {
          return Center(
            child: FutureBuilder<List<CardModel>>(
                future: future(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<CardModel> cards = snapshot.data;
                    return ListView.builder(
                        itemCount: cards.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              child: Card(
                                child: ListTile(
                                  leading: Icon(Icons.collections),
                                  title: Text(cards[index].name),
                                  subtitle: Text(cards[index].type),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return DetailPage(
                                    card: cards[index],
                                  );
                                }));
                              });
                        });
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          );
        }),
      ),
    );
  }

  // user defined function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text('Peringatan'),
          content: Text('Apakah Anda yakin ingin keluar?'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text('TIDAK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('YA'),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        );
      },
    );
  }
}

class DetailPage extends StatefulWidget {
  final CardModel card;

  DetailPage({Key key, @required this.card}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ScaffoldState scaffold;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => showSnackBar());
  }

  // Display Snackbar
  void showSnackBar() {
    scaffold.showSnackBar(SnackBar(content: Text(widget.card.name)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail Card'),
        ),
        body: Builder(builder: (BuildContext context) {
          scaffold = Scaffold.of(context);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Card(
                  child: Column(
                    children: <Widget>[
                      Image.network(
                          '${widget.card.cardImages[0].imageUrlSmall}'),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          widget.card.name,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(widget.card.desc),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
  }
}

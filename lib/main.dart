import 'package:flutter/material.dart';
import 'package:km_store_top_up/Models/ModelFreeFire.dart';
import 'package:km_store_top_up/app_service.dart';
import 'package:km_store_top_up/freeFire/AddDataWidget.dart';
import 'package:km_store_top_up/freeFire/ListData.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TopupHome(),
      title: 'KM Store Topup',
      routes: <String, WidgetBuilder>{
        '/TopupHome': (BuildContext context) => TopupHome(),
        '/FreeFire': (BuildContext context) => FreeFire(),
      },
    ),
  );
}

class TopupHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Column(
                children: <Widget>[
                  Image.network(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                    width: 100,
                    height: 100,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        cardLayanan(
                          icon: Icons.school,
                          teks: 'Free Fire',
                          warna: Colors.orange,
                          url: '/FreeFire',
                        ),
                        cardLayanan(
                          icon: Icons.ac_unit,
                          teks: 'Bayar Kuliah',
                          warna: Colors.green,
                          url: '/BayarKuliah',
                        ),
                        cardLayanan(
                          icon: Icons.access_alarm,
                          teks: 'Bayar Donasi',
                          warna: Colors.orange.shade200,
                          url: '/BayarDonasi',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

class cardLayanan extends StatelessWidget {
  cardLayanan(
      {required this.icon,
      required this.teks,
      required this.warna,
      required this.url});
  final IconData icon;
  final String teks;
  final Color warna;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, url);
          },
          style: TextButton.styleFrom(
            primary: Colors.black,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(0),
                child: Icon(
                  icon,
                  color: warna,
                  size: 50,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(teks),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FreeFire extends StatefulWidget {
  @override
  _FreeFireState createState() => _FreeFireState();
}

class _FreeFireState extends State<FreeFire> {
  final ApiService api = ApiService();
  List<freefire> listItem = [];

  @override
  Widget build(BuildContext context) {
    if (listItem == null) {
      listItem = [];
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Free Fire'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddScreen(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      body: new Container(
        child: new Center(
            child: new FutureBuilder(
          future: loadList(),
          builder: (context, snapshot) {
            return listItem.length > 0
                ? new ListItem(freeFire: listItem)
                : new Center(
                    child: Text('Tidak ada data ditemukan, silakan tambahkan!'),
                  );
          },
        )),
      ),
    );
  }

  Future loadList() {
    Future<List<freefire>> futureCases = api.getCases();
    futureCases.then((casesList) {
      setState(() {
        this.listItem = casesList;
      });
    });
    return futureCases;
  }

  _navigateToAddScreen(BuildContext context) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => AddDataWidget(),
      ),
    );
  }
}

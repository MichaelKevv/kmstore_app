import 'package:flutter/material.dart';
import 'package:km_store_top_up/Models/ModelFreeFire.dart';
import 'package:km_store_top_up/app_service.dart';
import 'package:km_store_top_up/freeFire/BuyDataWidget.dart';
import 'package:km_store_top_up/main.dart';

class DetailWidget extends StatefulWidget {
  DetailWidget(this.freeFire);

  final freefire freeFire;

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  _DetailWidgetState();

  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Item ' + widget.freeFire.nama),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Card(
            child: Container(
              padding: EdgeInsets.all(10.0),
              width: 440,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Nama Item:',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                        Text(widget.freeFire.nama)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        Text('Harga Item:',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8))),
                        Text(widget.freeFire.price)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Row(
                      children: <Widget>[
                        Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.blue),
                          onPressed: () {
                            _navigateToEditScreen(context, widget.freeFire);
                          },
                          child: Text('Beli',
                              style: TextStyle(color: Colors.white)),
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        ElevatedButton(
                          onPressed: () {
                            _confirmDialog();
                          },
                          child: Text('Hapus',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _navigateToEditScreen(BuildContext context, freefire freeFire) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditDataWidget(freeFire),
      ),
    );
  }

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Yes'),
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                api.deleteCase(widget.freeFire.id);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => TopupHome(),
                  ),
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => FreeFire(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

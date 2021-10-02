import 'package:flutter/material.dart';
import 'package:km_store_top_up/Models/ModelFreeFire.dart';
import 'package:km_store_top_up/app_service.dart';
import 'package:url_launcher/url_launcher.dart';

class EditDataWidget extends StatefulWidget {
  EditDataWidget(this.freeFire);

  final freefire freeFire;

  @override
  _EditDataWidgetState createState() => _EditDataWidgetState();
}

class _EditDataWidgetState extends State<EditDataWidget> {
  _EditDataWidgetState();

  final ApiService api = ApiService();
  final _addFormKey = GlobalKey<FormState>();
  String id = '';
  final _namaController = TextEditingController();
  final _priceController = TextEditingController();
  final _idGameController = TextEditingController();
  final _nickGameController = TextEditingController();

  @override
  void initState() {
    id = widget.freeFire.id;
    _namaController.text = widget.freeFire.nama;
    _priceController.text = widget.freeFire.price;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beli ' + widget.freeFire.nama),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
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
                              Text('ID Game'),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _idGameController,
                                decoration: const InputDecoration(
                                  hintText: 'Masukkan ID Anda',
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Tolong masukkan id anda';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('Nick Game'),
                              TextFormField(
                                controller: _nickGameController,
                                decoration: const InputDecoration(
                                  hintText: 'Masukkan Nick Anda',
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Tolong masukkan nick anda';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
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
                          child: Column(
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  sendWhatsapp(
                                      "FREEFIRE",
                                      _idGameController.text,
                                      _nickGameController.text,
                                      _namaController.text,
                                      _priceController.text);
                                },
                                child: Text('Beli Sekarang',
                                    style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue),
                              )
                            ],
                          ),
                        ),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }
}

sendWhatsapp(String namaGame, String idGame, String nickGame, String orderGame,
    String priceGame) async {
  var whatsapp = "+6285156801702";
  var text = "*" +
      namaGame +
      " TOPUP" +
      "*" +
      "%0a" +
      "ID : " +
      idGame +
      "%0a" +
      "Nick : " +
      nickGame +
      "%0a" +
      "Order : " +
      orderGame +
      "%0a" +
      "Price : " +
      priceGame +
      "%0a" +
      "```Status Done✅" +
      "%0a" +
      "Terimakasih sudah belanja di @kmstoree.id(◍•ᴗ•◍)```";
  var whatsappURl = "whatsapp://send?phone=" + whatsapp + "&text=" + text;

  await launch(whatsappURl);
}

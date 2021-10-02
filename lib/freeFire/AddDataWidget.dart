import 'package:flutter/material.dart';
import 'package:km_store_top_up/Models/ModelFreeFire.dart';

import 'package:km_store_top_up/app_service.dart';
import 'package:km_store_top_up/main.dart';

class AddDataWidget extends StatefulWidget {
  AddDataWidget();

  @override
  _AddDataWidgetState createState() => _AddDataWidgetState();
}

class _AddDataWidgetState extends State<AddDataWidget> {
  final ApiService api = ApiService();
  final _addFormKey = GlobalKey<FormState>();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Tambah Kuliah'),
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
                          Text('Nama Item'),
                          TextFormField(
                            controller: _namaController,
                            decoration: const InputDecoration(
                              hintText: 'Masukkan Nama Item',
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Tolong masukkan nama item';
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
                          Text('Harga Item'),
                          TextFormField(
                            controller: _priceController,
                            decoration: const InputDecoration(
                              hintText: 'Masukkan Harga Item',
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Tolong masukkan harga item';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              if (_addFormKey.currentState!.validate()) {
                                _addFormKey.currentState!.save();
                                api.createCase(
                                  freefire(
                                    nama: _namaController.text,
                                    price: _priceController.text,
                                  ),
                                );
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        TopupHome(),
                                  ),
                                );
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        FreeFire(),
                                  ),
                                );
                              }
                            },
                            child: Text('Save',
                                style: TextStyle(color: Colors.white)),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

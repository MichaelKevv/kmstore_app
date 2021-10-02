import 'package:flutter/material.dart';

import 'package:km_store_top_up/Models/ModelFreeFire.dart';
import 'package:km_store_top_up/freeFire/DetailWidget.dart';

class ListItem extends StatelessWidget {
  final List<freefire> freeFire;
  ListItem({required this.freeFire});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: freeFire == null ? 0 : freeFire.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailWidget(freeFire[index])),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.person,
                size: 50.0,
              ),
              title: Text(freeFire[index].nama),
              subtitle: Text("Harga : " + freeFire[index].price),
            ),
          ),
        );
      },
    );
  }
}

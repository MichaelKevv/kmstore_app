import 'dart:convert';
import 'package:http/http.dart';
import 'package:km_store_top_up/Models/ModelFreeFire.dart';

class ApiService {
  Future<List<freefire>> getCases() async {
    Response res = await get(
      Uri.parse('https://613635f28700c50017ef5497.mockapi.io/freefire'),
    );
    // print("${res.statusCode}");
    // print("${res.body}");
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<freefire> freeFire =
          body.map((dynamic item) => freefire.fromJson(item)).toList();
      return freeFire;
    } else {
      throw "Gagal load data";
    }
  }

  Future<freefire> createCase(freefire freeFire) async {
    Map data = {'nama': freeFire.nama, 'price': freeFire.price};
    var body = json.encode(data);
    final Response response = await post(
      Uri.parse('https://613635f28700c50017ef5497.mockapi.io/freefire'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    print("${response.statusCode}");
    print("${response.body}");
    if (response.statusCode == 201) {
      return freefire.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal menambahkan data');
    }
  }

  Future<freefire> updateCases(freefire freeFire) async {
    Map data = {
      'id': freeFire.id,
      'nama': freeFire.nama,
      'price': freeFire.price,
    };
    var body = json.encode(data);
    final Response response = await put(
      Uri.parse('https://613635f28700c50017ef5497.mockapi.io/freefire'),
      body: body,
    );
    print("${response.statusCode}");
    print("${response.body}");
    if (response.statusCode == 200) {
      return freefire.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal update data');
    }
  }

  Future<void> deleteCase(String id) async {
    Response res = await delete(
      Uri.parse('https://613635f28700c50017ef5497.mockapi.io/freefire/' + id),
    );
    if (res.statusCode == 200) {
      print("${res.body}");
    } else {
      throw "Gagal menghapus data";
    }
  }
}

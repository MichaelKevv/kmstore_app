class freefire {
  final String id;
  final String nama;
  final String price;

  freefire({this.id = '', required this.nama, required this.price});

  factory freefire.fromJson(Map<String, dynamic> json) {
    return freefire(id: json['id'], nama: json['nama'], price: json['price']);
  }

  @override
  String toString() {
    return 'freefire{id: $id, nama: $nama, price: $price}';
  }
}

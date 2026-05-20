class LaporanModel {

  final String id;
  final String judul;
  final String deskripsi;
  final DateTime createdAt;

  LaporanModel({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.createdAt,
  });

  factory LaporanModel.fromJson(
    Map<String, dynamic> json,
    String documentId,
  ) {

    return LaporanModel(
      id: documentId,
      judul: json['judul'],
      deskripsi: json['deskripsi'],
      createdAt:
          json['createdAt'].toDate(),
    );
  }
}
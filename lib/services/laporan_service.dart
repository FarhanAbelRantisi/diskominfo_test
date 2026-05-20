import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LaporanService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  // tambah laporan
  Future<void> tambahLaporan({
    required String judul,
    required String deskripsi,
  }) async {

    final user =
        _auth.currentUser;

    if (user == null) return;

    await _firestore
        .collection('laporan')
        .add({

      'userId': user.uid,

      'judul': judul,

      'deskripsi': deskripsi,

      'createdAt':
          Timestamp.now(),
    });
  }

  // ambil laporan user
  Stream<QuerySnapshot> getLaporanUser() {
    final user = _auth.currentUser;

    return _firestore
        .collection('laporan')
        .where(
          'userId',
          isEqualTo: user?.uid,
        )
        // ← hapus .orderBy() di sini
        .snapshots();
  }
}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diskominfo_test/models/laporan_model.dart';
import 'package:diskominfo_test/services/laporan_service.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  final LaporanService _laporanService = LaporanService();
  
  // 1. Deklarasikan variabel stream di sini
  late Stream<QuerySnapshot> _laporanStream;

  @override
  void initState() {
    super.initState(); // Cukup panggil ini saja
    
    _laporanStream = _laporanService.getLaporanUser();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _laporanStream,
      builder: (context, snapshot) {
        
        if (snapshot.hasError) {
          return Center(
            child: Text("Terjadi kesalahan: ${snapshot.error}"),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("Belum ada laporan"),
          );
        }

        final laporanList = snapshot.data!.docs;

        return ListView.builder(
          itemCount: laporanList.length,
          itemBuilder: (context, index) {
            final data = laporanList[index];
            
            final laporan = LaporanModel.fromJson(
              data.data() as Map<String, dynamic>,
              data.id,
            );

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.report),
                ),
                title: Text(laporan.judul),
                subtitle: Text(
                  laporan.deskripsi,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
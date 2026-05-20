import 'package:flutter/material.dart';

import 'package:diskominfo_test/services/laporan_service.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen>
      createState() {

    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {

  final _judulController = TextEditingController();

  final _deskripsiController = TextEditingController();

  final LaporanService _laporanService = LaporanService();

  bool _isLoading = false;

  Future<void> _tambahLaporan()
  async {

    if (_judulController.text
            .isEmpty ||
        _deskripsiController
            .text
            .isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Semua field wajib diisi",
          ),
        ),
      );

      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {

      await _laporanService
          .tambahLaporan(
        judul:
            _judulController.text,
        deskripsi:
            _deskripsiController
                .text,
      );

      _judulController.clear();

      _deskripsiController
          .clear();

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Laporan berhasil dikirim",
          ),
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content:
              Text(e.toString()),
        ),
      );

    } finally {

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      padding:
          const EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Text(
            "Buat Laporan",
            style: TextStyle(
              fontSize: 24,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller:
                _judulController,

            decoration:
                const InputDecoration(
              labelText:
                  "Judul Laporan",

              border:
                  OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller:
                _deskripsiController,

            maxLines: 5,

            decoration:
                const InputDecoration(
              labelText:
                  "Deskripsi",

              border:
                  OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width:
                double.infinity,

            child: ElevatedButton(

              onPressed:
                  _isLoading
                      ? null
                      : _tambahLaporan,

              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text(
                      "Kirim Laporan",
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
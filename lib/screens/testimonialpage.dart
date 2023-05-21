import 'package:flutter/material.dart';

class TestimonialPage extends StatelessWidget {
  const TestimonialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text('Testimony'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            SizedBox(
              height: 250,
              width: 250,
              child: Image.asset('assets/images/study.png'),
            ),
            SizedBox(height: 20),
            Text(
              'Kesan',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Pembelajaran Mata Kuliah TPM mudah dimengerti dan santai',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 20),
            Text(
              'Pesan',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Mungkin alokasi waktu kuliah untuk presentasi dikurangi, karena bisa',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'mencapai 3x pertemuan',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

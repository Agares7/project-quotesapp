import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 150,
              backgroundImage: AssetImage('assets/images/ardhian.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              'Ardhian Kusumayuda',
              style: TextStyle(fontSize: 26),
            ),
            SizedBox(height: 10),
            Text(
              'TPM IF-D / 123200144',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

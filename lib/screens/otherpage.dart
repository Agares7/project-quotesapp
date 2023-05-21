import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/quote.dart';
import 'login.dart';
import 'profilepage.dart';
import 'conversion_currency.dart';
import 'conversion_time.dart';
import 'testimonialpage.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  Future<void> _handleLogout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    // Clear the Hive box
    final quoteBox = Hive.box<Quote>('quotes');
    await quoteBox.clear();

    // Close and open the Hive box again
    await Hive.close();
    await Hive.openBox<Quote>('quotes');

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  'Profile',
                  style: TextStyle(fontSize: 16),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: ListTile(
                leading: Icon(Icons.money),
                title: Text(
                  'Currency Conversion',
                  style: TextStyle(fontSize: 16),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConversionCurrency()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: ListTile(
                leading: Icon(Icons.lock_clock),
                title: Text(
                  'Time Conversion',
                  style: TextStyle(fontSize: 16),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalendarPage()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: ListTile(
                leading: Icon(Icons.textsms),
                title: Text(
                  'Testimony',
                  style: TextStyle(fontSize: 16),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TestimonialPage()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 16),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                onTap: () => _handleLogout(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

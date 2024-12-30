import 'package:flutter/material.dart';
import 'dart:convert'; // JSON ma'lumotni parse qilish uchun
import 'package:http/http.dart' as http; // HTTP so'rov uchun

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BankHolidaysPage(),
    );
  }
}

class BankHolidaysPage extends StatefulWidget {
  @override
  _BankHolidaysPageState createState() => _BankHolidaysPageState();
}

class _BankHolidaysPageState extends State<BankHolidaysPage> {
  List<Map<String, dynamic>> holidays = [];

  @override
  void initState() {
    super.initState();
    fetchHolidays();
  }

  Future<void> fetchHolidays() async {
    final url = Uri.parse("https://www.gov.uk/bank-holidays.json");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final englandHolidays = data["england-and-wales"]["events"];
        setState(() {
          holidays = List<Map<String, dynamic>>.from(englandHolidays);
        });
      } else {
        throw Exception("Failed to fetch holidays");
      }
    } catch (e) {
      print("Error fetching holidays: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Bank Holidays"),
      ),
      body: holidays.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Ikki ustunli grid
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: holidays.length,
              itemBuilder: (context, index) {
                final holiday = holidays[index];
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: index % 2 == 0 ? Colors.blue : Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          holiday['title'], // Bayram nomi
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20), // Bayram nomidan keyin bo'shliq
                        Divider(
                          color: Colors.black,
                        ),
                        Text(
                          holiday['date'], // Sana pastda
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

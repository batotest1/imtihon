import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimationScreen(),
    );
  }
}

class AnimationScreen extends StatefulWidget {
  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  @override
  void initState() {
    super.initState();
    // 5 seconds delay to navigate to RegistrationPage
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegistrationPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.network(
          'https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExdXY3NXhjaDNqdXFycTJod2s2eDBuMXprNjhqdHd6Z2FuendxODR3NyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/7E2LEeDOuUj7d3rnLR/giphy.webp',
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  void _saveCredentials(String login, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('login', login);
  await prefs.setString('password', password);
}
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ro'yxatdan o'tish"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.pink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExdXY3NXhjaDNqdXFycTJod2s2eDBuMXprNjhqdHd6Z2FuendxODR3NyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/7E2LEeDOuUj7d3rnLR/giphy.webp',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildGlassTextField("Ism", surnameController, false),
                SizedBox(height: 15),
                _buildGlassTextField("Ism", nameController, false),
                SizedBox(height: 15),
                _buildGlassTextField("Login", loginController, false),
                SizedBox(height: 15),
                _buildPasswordField("Parol", passwordController),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    if (_validateInputs()) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Ma'lumotlar muvaffaqiyatli saqlandi!"),
                      ));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage(
                                login: loginController.text,
                                password: passwordController.text)),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Noto'g'ri ma'lumot! Iltimos, qaytadan kiriting."),
                      ));
                    }
                  },
                  child: Text(
                    "Saqlash",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassTextField(
      String label, TextEditingController controller, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.4),
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.4),
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
          child: Text(
            isPasswordVisible ? "🙈" : "🙉",
            style: TextStyle(
              fontSize: 30,
              color: Colors.brown,
            ),
          ),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  bool _validateInputs() {
    return nameController.text.isNotEmpty &&
        surnameController.text.isNotEmpty &&
        loginController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }
}

class LoginPage extends StatelessWidget {
  final String login;
  final String password;

  LoginPage({required this.login, required this.password});

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.pink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildGlassTextField("Login", loginController),
                  SizedBox(height: 15),
                  _buildGlassTextField("Parol", passwordController),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (loginController.text == login &&
                          passwordController.text == password) {
                       Navigator.push(context,MaterialPageRoute(builder: (context) => CurrencyRatesPage(),));
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Kirish"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.4),
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
class CurrencyRatesPage extends StatefulWidget {
  @override
  _CurrencyRatesPageState createState() => _CurrencyRatesPageState();
}

class _CurrencyRatesPageState extends State<CurrencyRatesPage> {
  String time = "";
  String date = "";
  List<dynamic> currencyRates = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchCurrencyRates();
    updateTime();
  }

  Future<void> fetchCurrencyRates() async {
    final response = await http.get(Uri.parse('https://cbu.uz/uz/arkhiv-kursov-valyut/json/'));
    if (response.statusCode == 200) {
      setState(() {
        currencyRates = jsonDecode(response.body);
        loading = false;
      });
    } else {
      throw Exception('Failed to load currency rates');
    }
  }

  void updateTime() {
    setState(() {
      DateTime now = DateTime.now();
      date = "${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}";
      time = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    });
    Future.delayed(Duration(seconds: 1), () {
      updateTime();
    });
  }

  void showCurrencyDialog(dynamic currency) {
  TextEditingController amountController = TextEditingController();
  String convertedValue = "";
  bool isFromSumToCurrency = true; // Boshlang'ich holat: So'mni valyutaga aylantirish

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("${currency['CcyNm_UZ']} ma'lumoti"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Qiymati: ${currency['Rate']} UZS"),
                Text("Valyuta kodi: ${currency['Ccy']}"),
                SizedBox(height: 10),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: isFromSumToCurrency
                        ? "So'mni kiriting"
                        : "Valyutani kiriting",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    double amount = double.tryParse(amountController.text) ?? 0;
                    double rate = double.parse(currency['Rate']);
                    setState(() {
                      if (isFromSumToCurrency) {
                        // So'mni valyutaga aylantirish
                        convertedValue =
                            (amount / rate).toStringAsFixed(2) + " ${currency['Ccy']}";
                      } else {
                        // Valyutani so'mga aylantirish
                        convertedValue =
                            (amount * rate).toStringAsFixed(2) + " UZS";
                      }
                    });
                  },
                  child: Text("Hisoblash"),
                ),
                if (convertedValue.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "Natija: $convertedValue",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isFromSumToCurrency = !isFromSumToCurrency; // Holatni o'zgartirish
                        });
                      },
                      child: Text(
                        isFromSumToCurrency
                            ? "Valyutani so'mga aylantirish"
                            : "So'mni valyutaga aylantirish",
                      ),
                    ),
                     ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dialogni yopish
                },
                child: Text("Qaytish"),
              ),
                  ],
                ),
              ],
            ),
            actions: [
             
            ],
          );
        },
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  automaticallyImplyLeading: false, // Chap tomonidagi orqaga qaytish tugmasini yo'q qilish
  actions: [
    Text("$time"),
    IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegistrationPage()),
        );
      },
      icon: Icon(Icons.exit_to_app,color: Colors.white,),
    ),
  ],
  backgroundColor: Colors.blue,
  title: Text("Aliyev Vali"), // Faqat title bo'lsin,
),


      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: currencyRates.length,
              itemBuilder: (context, index) {
                final currency = currencyRates[index];
                return GestureDetector(
                  onTap: () {
                    showCurrencyDialog(currency);
                  },
                  child: SizedBox(
                    height: 200,
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Yagilangan kun $date",
                              style: TextStyle(fontSize: 12, color: Colors.black),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "1 ${currency['Ccy']} ",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                                ),
                                SizedBox(height: 20,),
                                Column(
                                  children: [
                                                                    SizedBox(height: 20,),

                                    Text(
                                      "${currency['CcyNm_UZ']} (${currency['Code']})",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                                    ),
                                                                    SizedBox(height: 20,),

                                    Text(
                                      "${currency['Rate']} UZS",
                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  "+${currency['Diff']}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: currency['Diff'].toString().startsWith('-') ? Colors.red : Colors.green),
                                ),
                              ],
                            ),
                                                                             Divider(color: Colors.black),

                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

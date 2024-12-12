import 'package:flutter/material.dart';

 void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PrayerAppUI(),
    );
  }
}

class PrayerAppUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.teal],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Assalomu alaykum",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/previews/029/572/086/non_2x/boy-wearing-muslim-dress-ai-generative-free-png.png'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.timer_sharp, color: Colors.yellow),
                              SizedBox(width: 8),
                              Text("Dhuhr time", style: TextStyle(fontSize: 16,color: Colors.grey),),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.yellow),
                              SizedBox(width: 8),
                              Text("Uzbekistan", style: TextStyle(fontSize: 25,color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            "12:10",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            
                            ),
                          ),
                          SizedBox(width: 250,),
                           Text(
                            "Kokand",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.black,),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Icon(Icons.mosque, color: Colors.green, size: 32),
                              SizedBox(height: 8),
                              Text("Mosque"),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.book, color: Colors.green, size: 32),
                              SizedBox(height: 8),
                              Text("Al-Qur'an"),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.takeout_dining_outlined, color: Colors.green, size: 32),
                              SizedBox(height: 8),
                              Text("Tasbeeh"),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.kebab_dining, color: Colors.green, size: 32),
                              SizedBox(height: 8),
                              Text("Kaaba"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: Icon(Icons.star, color: Colors.white),
                  title: Text(
                    "The last surah you read.",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "No surah read yet",
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "MAKKAH LIVE",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ClipRRect(
                      
                      borderRadius: BorderRadius.circular(16),
                    
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJkykVMxQneNdVGTnJUY5NBrIW2PDexcL8ZQ&s',
                        fit: BoxFit.cover,
                        height: 270,
                        width: 380,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '',
          ),
        ],
        selectedItemColor: Colors.green,
      ),
    );
  }
}
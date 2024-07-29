import 'package:flutter/material.dart';
import 'custom_transition.dart';
import 'pet_selection_screen.dart';
import 'view_appointment_screen.dart';
import 'info_screen.dart';
import 'login_register_select_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedLabelStyle: const TextStyle(
            fontSize: 14.0,
            fontFamily: 'Josefin-Sans',
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12.0,
            fontFamily: 'Josefin-Sans',
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const ViewAppointmentsScreen(),
    const InfoScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'CREATE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'VIEW',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'ABOUT',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromARGB(255, 247, 120, 36),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 8.0,
        iconSize: 30.0,
        showSelectedLabels: true,
        showUnselectedLabels: false, // Hide labels for unselected items
        selectedLabelStyle: TextStyle(
          fontFamily: 'Josefin-Sans',
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Josefin-Sans',
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Positioned(
              top: 200,
              child: Text(
                'Welcome to',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 247, 120, 36),
                  fontSize: 60.0,
                  fontFamily: 'JosefinSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Positioned(
              top: 262.0, // Adjusted position
              child: Text(
                'EMG',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 247, 120, 36),
                  fontSize: 60.0,
                  fontFamily: 'JosefinSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Positioned(
              top: 340.0, // Increased space from EMG
              child: Text(
                'ANIMAL CLINIC &',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 247, 120, 36),
                  fontSize: 15.0,
                  fontFamily: 'JosefinSans',
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            const Positioned(
              top: 355.0, // Adjusted position
              child: Text(
                'VETERINARY SUPPLY',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 247, 120, 36),
                  fontSize: 15.0,
                  fontFamily: 'JosefinSans',
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            const Positioned(
              top: 375.0, // Adjusted position
              child: Text(
                '___________',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 15.0,
                  fontFamily: 'JosefinSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Positioned(
              top: 405.0,
              child: Text(
                'Pets are a part of a family.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 15.0,
                  fontFamily: 'JosefinSans',
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            const Positioned(
              top: 420.0, // Adjusted position
              child: Text(
                'Your pets are our family too.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 15.0,
                  fontFamily: 'JosefinSans',
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            Positioned(
              top: 510.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CustomPageRoute(builder: (context) => PetSelectionScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 247, 120, 36),
                  minimumSize: const Size(200, 50),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  elevation: 5,
                ),
                child: const Text(
                  'CREATE APPOINTMENT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 15.0,
                    fontFamily: 'JosefinSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 565.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginRegisterSelect(title: '',)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 247, 120, 36),
                  minimumSize: const Size(200, 50),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  elevation: 5,
                ),
                child: const Text(
                  'BACK TO LOGIN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 15.0,
                    fontFamily: 'JosefinSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
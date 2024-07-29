import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_transition.dart';
import 'service_selection_screen.dart';
import 'home_screen.dart';

class PetSelectionScreen extends StatefulWidget {
  @override
  _PetSelectionScreenState createState() => _PetSelectionScreenState();
}

class _PetSelectionScreenState extends State<PetSelectionScreen> {
  String selectedPet = '';
  List<String> selectedServices = [];
  String details = '';
  DateTime? selectedDate;
  String? selectedTimeSlot;

  // Define a map for pet images
  final Map<String, String> petImages = {
    'Cat': 'assets/cat.png',
    'Dog': 'assets/dog.png',
    'Bird': 'assets/bird.png',
    'Rabbit': 'assets/rabbit.png',
    'Horse': 'assets/horse.png',
    'Ferret': 'assets/ferret.png',
    'Fish': 'assets/fish.png',
    'Snake': 'assets/snake.png',
    'Other': 'assets/other.png',
  };

  Future<void> navigateToNextScreen(BuildContext context) async {
    if (selectedPet.isEmpty) {
      // Show SnackBar if no pet is selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a type of pet before proceeding.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final result = await Navigator.push(
      context,
      CustomPageRoute(
        builder: (context) => ServiceSelectionScreen(
          selectedPet: selectedPet,
          selectedServices: selectedServices,
          initialDetails: details,
          selectedDate: selectedDate,
          selectedTimeSlot: selectedTimeSlot,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        details = result['details'] ?? '';
        selectedDate = result['selectedDate'];
        selectedTimeSlot = result['selectedTimeSlot'];
      });
    }
  }

  void togglePetSelection(String pet) {
    setState(() {
      if (selectedPet == pet) {
        // Unselect the pet if it's already selected
        selectedPet = '';
      } else {
        // Select the new pet
        selectedPet = pet;
      }
    });
  }

  void _showCancelConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are you sure?',
            style: GoogleFonts.josefinSans(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Do you really want to cancel the creation of your appointment?',
            style: GoogleFonts.josefinSans(
              fontSize: 16.0,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'No',
                style: GoogleFonts.josefinSans(
                  fontSize: 16.0,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                ); // Navigate back to the home page
              },
              child: Text(
                'Yes',
                style: GoogleFonts.josefinSans(
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildPetCard(String petName, String imagePath) {
    bool isSelected = selectedPet == petName;
    return GestureDetector(
      onTap: () => togglePetSelection(petName),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 120.0,
        height: 150.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? Color.fromRGBO(226, 124, 51, 1) : Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: isSelected ? 1.0 : 0.7,
              duration: Duration(milliseconds: 300),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              petName,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine the image for the selected pet
    String imagePath = petImages[selectedPet] ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(226, 124, 51, 1),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: Color.fromRGBO(226, 124, 51, 1),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EMG',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 72.0,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(2, 2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 0.0),
                    Text(
                      'ANIMAL CLINIC &\nVETERINARY SUPPLY',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(2, 2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: 40.0),
                    Text(
                      'SELECT TYPE OF PET:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // Horizontal scrollable area for pet buttons
                    Container(
                      height: 200.0, // Adjust the height as needed
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            buildPetCard('Cat', 'assets/cat.png'),
                            buildPetCard('Dog', 'assets/dog.png'),
                            buildPetCard('Bird', 'assets/bird.png'),
                            buildPetCard('Rabbit', 'assets/rabbit.png'),
                            buildPetCard('Horse', 'assets/horse.png'),
                            buildPetCard('Ferret', 'assets/ferret.png'),
                            buildPetCard('Fish', 'assets/fish.png'),
                            buildPetCard('Snake', 'assets/snake.png'),
                            buildPetCard('Other', 'assets/other.png'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Swipe and Select',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ],
          ),
          if (selectedPet.isNotEmpty) // Only show the image if a pet is selected
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                imagePath,
                width: 300,
                height: 300.0,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () => _showCancelConfirmationDialog(context),
            backgroundColor: Color.fromARGB(255, 209, 64, 53),
            foregroundColor: Colors.white,
            elevation: 8.0,
            highlightElevation: 12.0,
            child: Icon(Icons.close),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => navigateToNextScreen(context),
            backgroundColor: Color.fromRGBO(11, 167, 76, 1),
            foregroundColor: Colors.white,
            elevation: 8.0,
            highlightElevation: 12.0,
            child: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}

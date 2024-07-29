import 'package:flutter/material.dart';
import 'custom_transition.dart';
import 'date_time_selection_screen.dart';

class DetailsScreen extends StatefulWidget {
  final String selectedPet;
  final List<String> selectedServices;
  final String initialDetails;
  final DateTime? selectedDate;
  final String? selectedTimeSlot;

  DetailsScreen({
    required this.selectedPet,
    required this.selectedServices,
    this.initialDetails = '',
    this.selectedDate,
    this.selectedTimeSlot,
  });

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late TextEditingController detailsController;
  DateTime? _selectedDate;
  String? _selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    detailsController = TextEditingController(text: widget.initialDetails);
    _selectedDate = widget.selectedDate;
    _selectedTimeSlot = widget.selectedTimeSlot;
  }

  void navigateToNextScreen(BuildContext context) {
    if (detailsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter details to proceed.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      Navigator.push(
        context,
        CustomPageRoute(
          builder: (context) => AppointmentSelectionScreen(
            selectedPet: widget.selectedPet,
            selectedServices: widget.selectedServices,
            details: detailsController.text,
            selectedDate: _selectedDate,
            selectedTimeSlot: _selectedTimeSlot,
          ),
        ),
      ).then((result) {
        if (result != null) {
          setState(() {
            _selectedDate = result['selectedDate'];
            _selectedTimeSlot = result['selectedTimeSlot'];
          });
        }
      });
    }
  }

  void navigateToPreviousScreen(BuildContext context) {
    Navigator.pop(
      context,
      {
        'details': detailsController.text,
        'selectedDate': _selectedDate,
        'selectedTimeSlot': _selectedTimeSlot,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40.0),
                      Text(
                        'INFORMATION ABOUT YOUR PET:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: TextField(
                            controller: detailsController,
                            maxLines: 8,
                            maxLength: 200,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter details here...',
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelText: 'Details',
                              labelStyle: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: ClipOval(
              child: Image.asset(
                'assets/details.png', // Dynamic pet image
                width: 300,
                height: 300.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () => navigateToPreviousScreen(context),
            backgroundColor: Color.fromARGB(255, 209, 64, 53),
            foregroundColor: Colors.white,
            elevation: 8.0,
            highlightElevation: 12.0,
            child: Icon(Icons.arrow_back),
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

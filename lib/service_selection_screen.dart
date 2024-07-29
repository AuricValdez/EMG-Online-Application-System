import 'package:flutter/material.dart';
import 'custom_transition.dart';
import 'details_screen.dart';

class ServiceSelectionScreen extends StatefulWidget {
  final String selectedPet;
  final List<String> selectedServices;
  final String initialDetails;
  final DateTime? selectedDate;
  final String? selectedTimeSlot;

  ServiceSelectionScreen({
    required this.selectedPet,
    required this.selectedServices,
    this.initialDetails = '',
    this.selectedDate,
    this.selectedTimeSlot,
  });

  @override
  _ServiceSelectionScreenState createState() => _ServiceSelectionScreenState();
}

class _ServiceSelectionScreenState extends State<ServiceSelectionScreen> {
  late List<String> selectedServices;
  late String currentDetails;
  DateTime? _selectedDate;
  String? _selectedTimeSlot;
  String? _currentImage; // Track the current service image

  @override
  void initState() {
    super.initState();
    selectedServices = widget.selectedServices;
    currentDetails = widget.initialDetails;
    _selectedDate = widget.selectedDate;
    _selectedTimeSlot = widget.selectedTimeSlot;
    // Initialize _currentImage based on initial selectedServices
    _currentImage = _getImageForService(
        selectedServices.isNotEmpty ? selectedServices[0] : null);
  }

  void toggleServiceSelection(String service) {
    setState(() {
      if (selectedServices.contains(service)) {
        selectedServices.clear();
        _currentImage = null; // Clear image if no services are selected
      } else {
        selectedServices.clear();
        selectedServices.add(service);
        _currentImage = _getImageForService(service);
      }
    });
  }

  String? _getImageForService(String? service) {
    final serviceImages = {
      'Consultation': 'assets/consultation.png',
      'Vaccination': 'assets/vaccination.png',
      'Grooming': 'assets/grooming.png',
      'Other': 'assets/other.png',
    };
    return serviceImages[service];
  }

  Widget buildServiceRow(List<Map<String, String>> services) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: services.map((service) {
        final serviceName = service['name']!;
        final imagePath = service['image']!;
        final isSelected = selectedServices.contains(serviceName);

        return GestureDetector(
          onTap: () => toggleServiceSelection(serviceName),
          child: AnimatedScale(
            scale: isSelected ? 1.05 : 1.0,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Container(
              width: 150.0, // Increased size
              height: 150.0, // Increased size
              margin: EdgeInsets.symmetric(horizontal: 8.0), // Increased margin
              child: Card(
                elevation: isSelected ? 8 : 4, // Increased elevation
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color.fromRGBO(226, 124, 51, 1)
                        : Colors.white, // Change color based on selection
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(
                              8.0), // Padding to zoom in the image
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit
                                  .cover, // Ensure the image covers the container
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.0), // Increased space
                      Text(
                        serviceName,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Colors
                                  .black, // Set text color based on selection
                          fontSize: 16.0, // Increased font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Future<void> navigateToNextScreen(BuildContext context) async {
    if (selectedServices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a type of service before proceeding.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final result = await Navigator.push(
      context,
      CustomPageRoute(
        builder: (context) => DetailsScreen(
          selectedPet: widget.selectedPet,
          selectedServices: selectedServices,
          initialDetails: currentDetails,
          selectedDate: _selectedDate,
          selectedTimeSlot: _selectedTimeSlot,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        currentDetails = result['details'] ?? '';
        _selectedDate = result['selectedDate'];
        _selectedTimeSlot = result['selectedTimeSlot'];
      });
    }
  }

  void navigateToPreviousScreen(BuildContext context) {
    Navigator.pop(
      context,
      {
        'details': currentDetails,
        'selectedDate': _selectedDate,
        'selectedTimeSlot': _selectedTimeSlot,
      },
    );
  }

  final List<Map<String, String>> serviceList = [
    {
      'name': 'Consultation',
      'image': 'assets/consultation.png',
    },
    {
      'name': 'Vaccination',
      'image': 'assets/vaccination.png',
    },
    {
      'name': 'Grooming',
      'image': 'assets/grooming.png',
    },
    {
      'name': 'Other',
      'image': 'assets/other.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Split the serviceList into rows
    List<List<Map<String, String>>> rows = [];
    for (int i = 0; i < serviceList.length; i += 2) {
      rows.add(serviceList.sublist(i, i + 2));
    }

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
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 40.0),
                      Text(
                        'SELECT TYPE OF SERVICE:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                          height:
                              16.0), // Increased space between title and cards
                      Expanded(
                        child: Column(
                          children:
                              rows.map((row) => buildServiceRow(row)).toList(),
                        ),
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
            child: _currentImage != null
                ? Image.asset(
                    _currentImage!,
                    width: 250,
                    height: 250.0,
                    fit: BoxFit.cover,
                  )
                : SizedBox(
                    width: 300,
                    height: 300.0,
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

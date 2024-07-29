import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'custom_transition.dart';
import 'confirm_info_screen.dart';

class AppointmentSelectionScreen extends StatefulWidget {
  final String selectedPet;
  final List<String> selectedServices;
  final String details;
  final DateTime? selectedDate;
  final String? selectedTimeSlot;

  AppointmentSelectionScreen({
    required this.selectedPet,
    required this.selectedServices,
    required this.details,
    this.selectedDate,
    this.selectedTimeSlot,
  });

  @override
  _AppointmentSelectionScreenState createState() =>
      _AppointmentSelectionScreenState();
}

class _AppointmentSelectionScreenState
    extends State<AppointmentSelectionScreen> {
  DateTime? _selectedDate;
  String? _selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _selectedTimeSlot = widget.selectedTimeSlot;
  }

  void _selectDate() async {
    DateTime now = DateTime.now();
    DateTime tomorrow = now.add(Duration(days: 1)); // Set earliest date to tomorrow

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? tomorrow,
      firstDate: tomorrow,
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color.fromRGBO(226, 124, 51, 1),
            hintColor: Color.fromRGBO(226, 124, 51, 1),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _selectTime(String time) {
    setState(() {
      if (_selectedTimeSlot == time) {
        _selectedTimeSlot = null; // Deselect if already selected
      } else {
        _selectedTimeSlot = time;
      }
    });
  }

  void navigateToNextScreen(BuildContext context) async {
    if (_selectedDate != null && _selectedTimeSlot != null) {
      Navigator.push(
        context,
        CustomPageRoute(
          builder: (context) => ConfirmInfoScreen(
            selectedDate: _selectedDate!,
            selectedTime: TimeOfDay(
              hour: int.parse(_selectedTimeSlot!.split(':')[0]),
              minute: int.parse(_selectedTimeSlot!.split(':')[1]),
            ),
            selectedPet: widget.selectedPet,
            selectedServices: widget.selectedServices,
            details: widget.details,
          ),
        ),
      ).then((result) {
        if (result != null) {
          // Handle result if needed
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select both date and time'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void navigateToPreviousScreen(BuildContext context) {
    Navigator.pop(
      context,
      {
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                color: Color.fromRGBO(226, 124, 51, 1),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EMG',
                      style: TextStyle(
                        fontFamily: 'Josefin-Sans',
                        color: Colors.white,
                        fontSize: 72.0,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'ANIMAL CLINIC &\nVETERINARY SUPPLY',
                      style: TextStyle(
                        fontFamily: 'Josefin-Sans',
                        color: Colors.white,
                        fontSize: 14.0,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        'SELECT DATE AND TIME\nOF APPOINTMENT:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Josefin-Sans',
                          fontSize: 18.0,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _selectDate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(226, 124, 51, 1),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 4.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today, color: Colors.white),
                          SizedBox(width: 8.0),
                          Text(
                            _selectedDate == null
                                ? 'Select Date'
                                : 'Date: ${DateFormat.yMMMd().format(_selectedDate!)}',
                            style: TextStyle(
                              fontFamily: 'Josefin-Sans',
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 2,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: ['08:00', '10:00', '12:00', '14:00', '16:00', '18:00'].length,
                      itemBuilder: (context, index) {
                        final time = ['08:00', '10:00', '12:00', '14:00', '16:00', '18:00'][index];
                        return buildTimeButton(time);
                      },
                    ),
                    SizedBox(
                      height: 100.0,
                      width: 325.0,
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
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
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Image.asset(
              'assets/calendar.png',
              width: 300,
              height: 300,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimeButton(String time) {
    bool isSelected = _selectedTimeSlot == time;

    return GestureDetector(
      onTap: () => _selectTime(time),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromRGBO(150, 60, 10, 1)
              : Color.fromRGBO(226, 124, 51, 1),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            time,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Josefin-Sans',
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}

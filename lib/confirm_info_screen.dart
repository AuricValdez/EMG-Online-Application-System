import 'home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'custom_transition.dart';
import 'finish_screen.dart';
import 'appointment_data.dart'; // data manager
import 'appointment_model.dart'; // model

class ConfirmInfoScreen extends StatefulWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final String selectedPet;
  final List<String> selectedServices;
  final String details;

  ConfirmInfoScreen({
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedPet,
    required this.selectedServices,
    required this.details,
  });

  @override
  _ConfirmInfoScreenState createState() => _ConfirmInfoScreenState();
}

class _ConfirmInfoScreenState extends State<ConfirmInfoScreen> {
  void navigateToNextScreen(BuildContext context) {
    // Save the appointment
    Appointment newAppointment = Appointment(
      date: widget.selectedDate,
      time: widget.selectedTime,
      pet: widget.selectedPet,
      services: widget.selectedServices,
      details: widget.details,
    );
    AppointmentData().addAppointment(newAppointment);

    Navigator.push(
      context,
      CustomPageRoute(
        builder: (context) => FinishScreen(),
      ),
    );
  }

  void navigateToPreviousScreen(BuildContext context) {
    Navigator.pop(
      context,
      {
        'selectedDate': widget.selectedDate,
        'selectedTime': widget.selectedTime,
        'selectedPet': widget.selectedPet,
        'selectedServices': widget.selectedServices,
        'details': widget.details,
      },
    );
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

  void _showCreateConfirmationDialog(BuildContext context) {
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
            'Do you want to create this appointment?',
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
                navigateToNextScreen(context); // Proceed with appointment creation
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[100], // Ensure consistent color
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              width: double.infinity,
              color: Colors.grey[100], // Matching the background color
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'EMG',
                    style: TextStyle(
                      color: Color.fromRGBO(226, 124, 51, 1),
                      fontSize: 72.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'ANIMAL CLINIC &\nVETERINARY SUPPLY',
                    style: TextStyle(
                      color: Color.fromRGBO(226, 124, 51, 1),
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Divider(
              color: Color.fromRGBO(226, 124, 51, 1),
              thickness: 3.0,
            ),
            SizedBox(height: 20.0),
            // Appointment Details
            Text(
              'Create Appointment?',
              style: GoogleFonts.josefinSans(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView(
                children: [
                  buildDetailCard('Pet', widget.selectedPet),
                  SizedBox(height: 16.0),
                  buildDetailCard('Service', widget.selectedServices.join(', ')),
                  SizedBox(height: 16.0),
                  buildDetailCard('Details', widget.details),
                  SizedBox(height: 16.0),
                  buildDetailCard('Date', DateFormat.yMMMd().format(widget.selectedDate)),
                  SizedBox(height: 16.0),
                  buildDetailCard('Time', widget.selectedTime.format(context)),
                ],
              ),
            ),
            // Action Buttons
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        navigateToPreviousScreen(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(226, 124, 51, 1),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        'EDIT',
                        style: GoogleFonts.josefinSans(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _showCreateConfirmationDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(11, 167, 76, 1),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        'CREATE',
                        style: GoogleFonts.josefinSans(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            // Cancel Button
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showCancelConfirmationDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 209, 64, 53),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'CANCEL',
                  style: GoogleFonts.josefinSans(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailCard(String title, String content) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title:',
              style: GoogleFonts.josefinSans(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(226, 124, 51, 1),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              content,
              style: GoogleFonts.josefinSans(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

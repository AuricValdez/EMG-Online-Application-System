import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'appointment_data.dart'; // Import the data manager
import 'appointment_model.dart';
import 'custom_transition.dart';
import 'pet_selection_screen.dart';

class ViewAppointmentsScreen extends StatefulWidget {
  const ViewAppointmentsScreen({super.key});

  @override
  _ViewAppointmentsScreenState createState() => _ViewAppointmentsScreenState();
}

class _ViewAppointmentsScreenState extends State<ViewAppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    final appointments = AppointmentData().appointments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: appointments.isNotEmpty
            ? Text(
                'YOUR APPOINTMENTS',
                style: GoogleFonts.josefinSans(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(226, 124, 51, 1), // Set the title color to match the theme
                ),
              )
            : null,
      ),
      backgroundColor: Colors.white, // Set background color to white
      body: appointments.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 80.0,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'NO APPOINTMENTS YET',
                    style: GoogleFonts.josefinSans(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CustomPageRoute(
                            builder: (context) => PetSelectionScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 247, 120, 36),
                      minimumSize: const Size(200, 50),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
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
                ],
              ),
            )
          : ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(12.0), // Add padding for better visual appeal
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(226, 124, 51, 1), // Set card color to orange
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.pets, color: Colors.white), // Add an icon
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              '${DateFormat.yMMMd().format(appointment.date)} at ${DateFormat.jm().format(appointment.date)}',
                              style: GoogleFonts.josefinSans(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Pet: ${appointment.pet}',
                        style: GoogleFonts.josefinSans(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        'Services: ${appointment.services.join(', ')}',
                        style: GoogleFonts.josefinSans(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextButton(
                        onPressed: () {
                          _showAppointmentDetails(context, appointment, index);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'View Details',
                          style: GoogleFonts.josefinSans(
                            fontSize: 16.0,
                            color: const Color.fromRGBO(226, 124, 51, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  void _showAppointmentDetails(
      BuildContext context, Appointment appointment, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  'Appointment Details',
                  style: GoogleFonts.josefinSans(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(226, 124, 51, 1),
                  ),
                ),
                const SizedBox(height: 16.0),
                // Pet and Date
                Row(
                  children: [
                    Icon(Icons.pets, color: Color.fromRGBO(226, 124, 51, 1)),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        '${DateFormat.yMMMd().format(appointment.date)} at ${DateFormat.jm().format(appointment.date)}',
                        style: GoogleFonts.josefinSans(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                // Details
                _buildDetailRow('Pet:', appointment.pet),
                _buildDetailRow('Services:', appointment.services.join(', ')),
                _buildDetailRow('Details:', appointment.details),
                _buildDetailRow('Date:', DateFormat.yMMMd().format(appointment.date)),
                _buildDetailRow('Time:', DateFormat.jm().format(appointment.date)),
                const SizedBox(height: 20.0),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text(
                        'Close',
                        style: GoogleFonts.josefinSans(
                          fontSize: 16.0,
                          color: Color.fromRGBO(226, 124, 51, 1),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    TextButton(
                      onPressed: () {
                        _showCancelConfirmationDialog(context, index);
                      },
                      child: Text(
                        'Cancel Appointment',
                        style: GoogleFonts.josefinSans(
                          fontSize: 16.0,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCancelConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Cancel Appointment',
            style: GoogleFonts.josefinSans(fontSize: 20.0),
          ),
          content: Text(
            'Are you sure you want to cancel this appointment?',
            style: GoogleFonts.josefinSans(fontSize: 16.0),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'No',
                style: GoogleFonts.josefinSans(fontSize: 16.0),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  AppointmentData().appointments.removeAt(index);
                });
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Close the details dialog
              },
              child: Text(
                'Yes',
                style: GoogleFonts.josefinSans(fontSize: 16.0),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title ',
            style: GoogleFonts.josefinSans(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: GoogleFonts.josefinSans(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}

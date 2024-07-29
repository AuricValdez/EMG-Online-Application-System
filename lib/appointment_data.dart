// appointment_data.dart
import 'appointment_model.dart';

class AppointmentData {
  static final AppointmentData _instance = AppointmentData._internal();
  factory AppointmentData() => _instance;
  AppointmentData._internal();

  List<Appointment> appointments = [];

  void addAppointment(Appointment appointment) {
    appointments.add(appointment);
  }
}

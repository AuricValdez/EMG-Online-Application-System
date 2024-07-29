import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'user_manager.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signupPressed() {
    if (_formKey.currentState!.validate()) {
      final username =
          _emailController.text; // Use email as username for simplicity
      final password = _passwordController.text;
      final confirmPassword = _confirmPasswordController.text;
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;

      if (password != confirmPassword) {
        _showErrorDialog('Passwords do not match');
        return;
      }

      final success = UserManager().registerUser(username, password, firstName, lastName);
      if (success) {
        _showSuccessDialog();
      } else {
        _showErrorDialog('Email already exists');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(
                fontFamily: 'JosefinSans',
                color: Color.fromRGBO(226, 124, 51, 1)),
          ),
          content: Text(
            message,
            style: TextStyle(fontFamily: 'JosefinSans'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(fontFamily: 'JosefinSans'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Success',
            style: TextStyle(
                fontFamily: 'JosefinSans',
                color: Color.fromRGBO(226, 124, 51, 1)),
          ),
          content: Text(
            'Your account has been successfully created.',
            style: TextStyle(fontFamily: 'JosefinSans'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(fontFamily: 'JosefinSans'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFA726), Color(0xFFFF7043)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: 20),
              Text(
                'EMG',
                style: TextStyle(
                  fontFamily: 'JosefinSans',
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
              Text(
                'ANIMAL CLINIC & \nVETERINARY SUPPLY',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'JosefinSans',
                  fontSize: 16,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Create your account!',
                style: TextStyle(
                  fontFamily: 'JosefinSans',
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField('First Name', _firstNameController),
                    SizedBox(height: 10),
                    _buildTextField('Last Name', _lastNameController),
                    SizedBox(height: 10),
                    _buildTextField('Email', _emailController,
                        email: true),
                    SizedBox(height: 10),
                    _buildTextField('Password', _passwordController,
                        obscureText: true, password: true),
                    SizedBox(height: 10),
                    _buildTextField(
                        'Confirm Password', _confirmPasswordController,
                        obscureText: true, password: true),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _signupPressed,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    backgroundColor: const Color(0xFFFFFFFF),
                    elevation: 5,
                  ),
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      color: Color.fromRGBO(226, 124, 51, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller,
      {bool obscureText = false, bool email = false, bool password = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'JosefinSans',
        ),
        filled: true,
        fillColor: Colors.white24,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'JosefinSans',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        if (email && !EmailValidator.validate(value)) {
          return 'Enter a valid email';
        }
        if (password && value.length < 8) {
          return 'Password must be at least 8 characters long';
        }
        if (password && !RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
          return 'Password must contain an uppercase letter, a lowercase letter, and a number';
        }
        return null;
      },
    );
  }
}

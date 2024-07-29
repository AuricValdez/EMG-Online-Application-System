import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For clipboard functionality

class PhonePage extends StatelessWidget {
  const PhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(226, 124, 51, 1), // AppBar background color
        iconTheme: const IconThemeData(
          color: Colors.white, // Ensures phone icon is white
        ),
      ),
      backgroundColor: Color.fromRGBO(226, 124, 51, 1), // Scaffold background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icons section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIconButton(
                  icon: Icons.phone,
                  color: Color.fromRGBO(226, 124, 51, 1),
                  backgroundColor: Colors.white,
                  onTap: () {
                    _showPopup(context, 'Contact Number', '09178812642');
                  },
                ),
                const SizedBox(width: 20),
                _buildIconButton(
                  icon: Icons.email,
                  color: Color.fromRGBO(226, 124, 51, 1),
                  backgroundColor: Colors.white,
                  onTap: () {
                    _showPopup(context, 'Email', 'emgveterinarysupply@gmail.com');
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Image at the bottom
            Image.asset(
              'assets/logo.png', // Path to your image asset
              width: 300, // Adjust the size as needed
              height: 300,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8.0,
              offset: Offset(0, 4), // Shadow position
            ),
          ],
        ),
        child: Icon(icon, color: color, size: 30),
      ),
    );
  }

  void _showPopup(BuildContext context, String title, String content) {
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
                  title,
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(226, 124, 51, 1),
                  ),
                ),
                const SizedBox(height: 16.0),
                // Content
                Text(
                  content,
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20.0),
                // Copy Button
                ElevatedButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: content));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Copied to clipboard'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(226, 124, 51, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Copy',
                    style: TextStyle(color: Colors.white), // Text color white
                  ),
                ),
                const SizedBox(height: 20.0),
                // Close Button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontFamily: 'JosefinSans',
                        fontSize: 16.0,
                        color: Color.fromRGBO(226, 124, 51, 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String name;
  final String vision;


  const DetailsPage({
    super.key,
    required this.name,
    required this.vision,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text(
          'Profile',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Added padding for overall spacing
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            // ClipOval(
            //   child: Image.asset(
            //     "assets/$photo", // Using the passed photo asset
            //     width: 120,
            //     height: 120,
            //     fit: BoxFit.cover, // Ensuring the image is properly cropped
            //   ),
            // ),
            const SizedBox(height: 20.0), // Added space between image and text

            // Name
            Text(
              name,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8.0), // Space between Name and Vision

            // Vision
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), // Padding for Vision
              child: Text(
                vision,
                textAlign: TextAlign.center, // Center aligned text
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54, // Slightly muted color for vision
                ),
              ),
            ),
            const SizedBox(height: 20.0), // Space at the bottom
          ],
        ),
      ),
    );
  }
}

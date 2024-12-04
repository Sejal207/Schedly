import 'package:flutter/material.dart';
import 'offer_ride_page.dart'; // Import the new page

class CarpoolPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Campus Carpool',
          style: TextStyle(color: Color(0xFFF88E20), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1E1E1E),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF121212),
              Color(0xFF1E1E1E),
              Color(0xFF2C2C2C),
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            _buildCarpoolRides(),
            SizedBox(height: 20),
            _buildOfferRideButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCarpoolRides() {
    final rides = [
      {'driver': 'Gaurav Ghosh', 'destination': 'Iffco Chowk', 'time': 'Tomorrow, 8:00 AM', 'seats': 3,'price':70},
      {'driver': 'Krishna Mundra', 'destination': 'Rajiv Chowk', 'time': 'Next Week, 5:30 PM', 'seats': 2,'price':60},
      {'driver': 'Khushi Goyal', 'destination': 'Nirman vihar', 'time': '5/12/24, 5:30 PM', 'seats': 1,'price':60},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Carpool Rides',
          style: TextStyle(
            color: Color(0xFFF88E20),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        ...rides.map((ride) {
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Color(0xFF2C2C2C),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(0, 4),
                  blurRadius: 5,
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                'Driver: ${ride['driver']!}',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Destination: ${ride['destination']!}\nTime: ${ride['time']!}\nAvailable Seats: ${ride['seats']!}\nPrice: ${ride['price']!}',
                style: TextStyle(color: Colors.white70),
              ),
              trailing: Icon(
                Icons.drive_eta,
                color: Color(0xFFF88E20),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildOfferRideButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OfferRidePage()), // Navigate to OfferRidePage
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFF88E20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        'Offer a Ride',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

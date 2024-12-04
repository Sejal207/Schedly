import 'package:flutter/material.dart';

class OfferRidePage extends StatefulWidget {
  @override
  _OfferRidePageState createState() => _OfferRidePageState();
}

class _OfferRidePageState extends State<OfferRidePage> {
  final _formKey = GlobalKey<FormState>();
  String driver = '';
  String destination = '';
  String time = '';
  int seats = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Offer a Ride',
          style: TextStyle(color: Color(0xFFF88E20), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1E1E1E),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                label: 'Driver Name',
                onChanged: (value) => driver = value,
              ),
              SizedBox(height: 10),
              _buildTextField(
                label: 'Destination',
                onChanged: (value) => destination = value,
              ),
              SizedBox(height: 10),
              _buildTextField(
                label: 'Time',
                onChanged: (value) => time = value,
              ),
              SizedBox(height: 10),
              _buildNumberField(
                label: 'Seats Available',
                onChanged: (value) => seats = int.tryParse(value) ?? 1,
              ),
              SizedBox(height: 10),
              _buildNumberField(
                label: 'Price',
                onChanged: (value) => seats = int.tryParse(value) ?? 1,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF88E20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required ValueChanged<String> onChanged,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Color(0xFF2C2C2C),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      style: TextStyle(color: Colors.white),
      validator: (value) => value == null || value.isEmpty ? 'This field is required' : null,
      onChanged: onChanged,
    );
  }

  Widget _buildNumberField({
    required String label,
    required ValueChanged<String> onChanged,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Color(0xFF2C2C2C),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) return 'This field is required';
        final number = int.tryParse(value);
        if (number == null || number < 1) return 'Enter a valid number';
        return null;
      },
      onChanged: onChanged,
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ride Offered Successfully')),
      );
      Navigator.pop(context); // Navigate back to CarpoolPage
    }
  }
}

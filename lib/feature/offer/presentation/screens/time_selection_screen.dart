import 'package:flutter/material.dart';

class TimeSelectionScreen extends StatefulWidget {
  @override
  _TimeSelectionScreenState createState() => _TimeSelectionScreenState();
}

class _TimeSelectionScreenState extends State<TimeSelectionScreen> {
  List<String> selectedTimes = [];
  bool selectAllTimes = false;
  
  final List<TimeSlot> morningSlots = [
    TimeSlot('6:00 AM'),
    TimeSlot('7:00 AM'),
    TimeSlot('8:00 AM'),
    TimeSlot('9:00 PM'),
    TimeSlot('10:00 PM'),
    TimeSlot('11:00 PM'),
  ];
  
  final List<TimeSlot> afternoonSlots = [
    TimeSlot('12:00 PM'),
    TimeSlot('1:00 PM'),
    TimeSlot('2:00 PM'),
    TimeSlot('3:00 PM'),
    TimeSlot('4:00 PM'),
    TimeSlot('5:00 PM'),
  ];
  
  final List<TimeSlot> eveningSlots = [
    TimeSlot('6:00 PM'),
    TimeSlot('7:00 PM'),
    TimeSlot('8:00 PM'),
    TimeSlot('9:00 PM'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Manage Availability',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Date Range Header
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manage Availability',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  '1 Dec 25 - 10 Dec 25',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Morning Section
                  _buildTimeSection('Morning', morningSlots),
                  SizedBox(height: 20),
                  
                  // Afternoon Section
                  _buildTimeSection('Afternoon', afternoonSlots),
                  SizedBox(height: 20),
                  
                  // Evening Section
                  _buildTimeSection('Evening', eveningSlots),
                  SizedBox(height: 20),
                  
                  // Select All Times Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: selectAllTimes,
                        onChanged: (bool? value) {
                          setState(() {
                            selectAllTimes = value!;
                            if (selectAllTimes) {
                              selectedTimes.clear();
                              selectedTimes.addAll(morningSlots.map((slot) => slot.time));
                              selectedTimes.addAll(afternoonSlots.map((slot) => slot.time));
                              selectedTimes.addAll(eveningSlots.map((slot) => slot.time));
                            } else {
                              selectedTimes.clear();
                            }
                          });
                        },
                        activeColor: Colors.red,
                      ),
                      Text(
                        'Select All Times',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: selectedTimes.isNotEmpty
                    ? () {
                        // Navigate to next screen or complete setup
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Service setup completed!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  disabledBackgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTimeSection(String title, List<TimeSlot> timeSlots) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: timeSlots.map((timeSlot) {
            final isSelected = selectedTimes.contains(timeSlot.time);
            
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedTimes.remove(timeSlot.time);
                  } else {
                    selectedTimes.add(timeSlot.time);
                  }
                  
                  // Update selectAllTimes checkbox
                  final allTimes = [
                    ...morningSlots.map((slot) => slot.time),
                    ...afternoonSlots.map((slot) => slot.time),
                    ...eveningSlots.map((slot) => slot.time),
                  ];
                  selectAllTimes = allTimes.every((time) => selectedTimes.contains(time));
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.grey[300]!,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: isSelected ? Colors.red.withOpacity(0.1) : Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: isSelected ? Colors.red : Colors.grey[600],
                    ),
                    SizedBox(width: 6),
                    Text(
                      timeSlot.time,
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected ? Colors.red : Colors.black,
                        fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class TimeSlot {
  final String time;
  
  TimeSlot(this.time);
}

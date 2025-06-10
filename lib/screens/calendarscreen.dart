import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // For DateFormat

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volunteer Service Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalendarScreen(),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // The currently selected and focused day.
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  // Map to hold the volunteer events.
  // Key: Date without time info; Value: List of volunteer event names.
  Map<DateTime, List<String>> _events = {};

  // This function will load the volunteer events for the logged-in user.
  Future<void> _loadVolunteerEvents() async {
    // Assume the logged-in user's email is known.
    String userEmail = 'auw@tsss.edu.hk';
    print('[DEBUG] Looking for user with email: $userEmail');

    try {
      
      // Query the 'User' collection to get the user's document.
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('Email', isEqualTo: userEmail)
          .get();

      if (userSnapshot.docs.isEmpty) {
        print('[DEBUG] No user found with email $userEmail');
        return;
      }

      // Assuming the email is unique, get the first document.
      var userDoc = userSnapshot.docs.first;
      print('[DEBUG] Found user document: ${userDoc.id}');

      // Extract the list of volunteer service names.
      List<dynamic> userVolunteerList = userDoc.get('volunteer') ?? [];
      print('[DEBUG] User volunteer list: $userVolunteerList');

      // Clear any existing events.
      _events.clear();

      // For each volunteer service name the user applied to,
      // query the 'volunteer' collection to get event details.
      for (var service in userVolunteerList) {
        print('[DEBUG] Querying volunteer details for service: $service');
        QuerySnapshot volunteerSnapshot = await FirebaseFirestore.instance
            .collection('volunteer')
            .where('name', isEqualTo: service)
            .get();

        if (volunteerSnapshot.docs.isEmpty) {
          print('[DEBUG] No volunteer details found for service: $service');
          continue;
        }

        for (var doc in volunteerSnapshot.docs) {
          print('[DEBUG] Processing volunteer doc: ${doc.id} for service: $service');
          
          // The 'date' field in Firestore is stored as a string in 'dd/MM/yyyy' format.
          String dateString = doc.get('date');
          print('[DEBUG] Service "$service" has date string: $dateString');
          DateTime? eventDate;
          try {
            // Parse the date string to DateTime.
            eventDate = DateFormat('dd/MM/yyyy').parse(dateString);
          } catch (e) {
            print('[DEBUG] Error parsing date for service "$service": $e');
            continue;
          }

          // Normalize the date to remove time part.
          DateTime normalizedDate = DateTime(eventDate.year, eventDate.month, eventDate.day);
          print('[DEBUG] Normalized date for service "$service": $normalizedDate');

          // Add the event to our map.
          if (_events.containsKey(normalizedDate)) {
            _events[normalizedDate]!.add(service);
          } else {
            _events[normalizedDate] = [service];
          }
          print('[DEBUG] Current events map: $_events');
        }
      }
      
      print('[DEBUG] Finished loading volunteer events. Events map: $_events');
      // Trigger a rebuild once events are loaded.
      setState(() {});
    } catch (e) {
      print('[DEBUG] Exception while loading volunteer events: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Load the volunteer events when the screen is initialized.
    _loadVolunteerEvents();
  }

  // Helper method to retrieve events for a given day.
  List<String> _getEventsForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return _events[normalizedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volunteer Calendar'),
      ),
      body: Column(
        children: [
          // The TableCalendar widget.
          TableCalendar<String>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            locale: 'en_US',
            eventLoader: _getEventsForDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarBuilders: CalendarBuilders(
              dowBuilder: (context, day) {
                if (day.weekday == DateTime.sunday) {
                  final text = MaterialLocalizations.of(context)
                      .narrowWeekdays[day.weekday % 7];
                  return Center(
                    child: Text(
                      text,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                return null;
              },
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    bottom: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: events
                          .map((e) => Container(
                                width: 6,
                                height: 6,
                                margin: const EdgeInsets.symmetric(horizontal: 0.5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent,
                                ),
                              ))
                          .toList(),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          const Divider(),
          // List view to display the events for the selected day.
          Expanded(
            child: ListView(
              children: _getEventsForDay(_selectedDay)
                  .map(
                    (event) => ListTile(
                      leading: const Icon(Icons.event),
                      title: Text(event),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tapped on "$event"')),
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
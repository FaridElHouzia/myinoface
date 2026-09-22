import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myinoface/core/model/all_gardes_model.dart';
import 'package:myinoface/core/notifier/model_notifier.dart';
import 'package:myinoface/core/usecases/constants.dart';
import 'package:myinoface/features/gardes/presentation/bloc/garde_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:myinoface/core/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';



class GardeCalendar extends StatefulWidget {
  const GardeCalendar({Key? key}) : super(key: key);

  @override
  _GardeCalendarState createState() => _GardeCalendarState();
}

class _GardeCalendarState extends State<GardeCalendar> with
    TickerProviderStateMixin {

  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  final dateFormatter = DateFormat('dd-MM-yyyy');
  // CalendarController _calendarController; // Removed in v3.x
  Map<DateTime, List> events = {};
  List _selectedEvents = [];
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;


  @override
  void initState() {
    super.initState();
    final model = context.read<ModelNotifier>();
    if (model.allGardesModel?.dates != null) {
      for (Date date in model.allGardesModel!.dates!) {
        if (date.dateGarde != null) {
          events[date.dateGarde!] = [date];
        }
      }
    }

    DateTime datePlan = dateFormatter.parse(formattedDate);
    _selectedEvents = events[datePlan] ?? [];
    _selectedDay = _focusedDay;
    // _calendarController = CalendarController(); // Removed in v3.x
  }

  @override
  void dispose() {
    // _calendarController?.dispose(); // Removed in v3.x
    super.dispose();
  }

  // Updated for v3.x API - signature changed
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents = events[selectedDay] ?? [];
      });
      context.read<GardeBloc>().add(GetPersonneGardeByDate(date: selectedDay));
    }
  }

  // Helper function for table_calendar v3.x
  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  // Updated for v3.x API - signature changed
  void _onPageChanged(DateTime focusedDay) {
    _focusedDay = focusedDay;
    logger.i('CALLBACK: _onPageChanged');
  }

  // Event loader for v3.x
  List _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'fr_FR',
      firstDay: DateTime.utc(2020, 1, 1), // Required in v3.x
      lastDay: DateTime.utc(2030, 12, 31), // Required in v3.x
      focusedDay: _focusedDay, // Required in v3.x
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day), // New in v3.x
      calendarFormat: _calendarFormat, // New in v3.x
      // calendarController: _calendarController, // Removed in v3.x
      eventLoader: _getEventsForDay, // Replaces events parameter in v3.x
      // holidays: holidays, // Commented out - needs to be implemented if required
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Mois',
        CalendarFormat.twoWeeks: '2 Semaines',
        CalendarFormat.week: 'Semaine',
      },
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Colors.pink[400],
          shape: BoxShape.circle,
        ), // Renamed from selectedColor in v3.x
        todayDecoration: BoxDecoration(
          color: Colors.pink[200],
          shape: BoxShape.circle,
        ), // Renamed from todayColor in v3.x
        markerDecoration: BoxDecoration(
          color: Colors.brown[700],
          shape: BoxShape.circle,
        ), // Renamed from markersColor in v3.x
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle: const TextStyle().copyWith(
            color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.pink[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected, // Updated signature
      onPageChanged: _onPageChanged, // Replaces onVisibleDaysChanged in v3.x
      onFormatChanged: (format) { // New in v3.x
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
    );
  }

}


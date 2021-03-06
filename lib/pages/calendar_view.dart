import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarViewPage extends StatefulWidget {
  @override
  _CalendarViewPageState createState() => _CalendarViewPageState();
}

class _CalendarViewPageState extends State<CalendarViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: SafeArea(
        child: SfCalendar(

          headerHeight: 55,
          viewHeaderHeight: -1,
          allowedViews: <CalendarView>[
            CalendarView.month,
            CalendarView.day,
            CalendarView.schedule,
            CalendarView.week

          ],



          todayTextStyle: TextStyle(fontSize: 20),

          
          headerStyle: CalendarHeaderStyle(

            backgroundColor: Colors.white,
              textAlign: TextAlign.start,
              textStyle: Theme.of(context).textTheme.headline2),
          viewHeaderStyle: ViewHeaderStyle(
              dayTextStyle: Theme.of(context).textTheme.headline4,
              dateTextStyle: TextStyle(color: Colors.grey, fontSize: 24)),
          view: CalendarView.month,
          dataSource: MeetingDataSource(_getDataSource()),
          monthViewSettings: MonthViewSettings(
              monthCellStyle: MonthCellStyle(
                textStyle: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(color: Colors.black54),
              ),
              showTrailingAndLeadingDates: true,
              dayFormat: "EEE",
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              showAgenda: false),
        ),
      ),
    );
  }

  List<Meeting> _getDataSource() {
    List meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(2021, DateTime.february, 1, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(days: 3));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0D98FF), false));
    meetings.add(Meeting(
        'Second', DateTime(2021, DateTime.february, 12, 9, 0, 0), DateTime(2021, DateTime.february, 18, 9, 0, 0), const Color(0xFF0D98FF), false));
    meetings.add(Meeting(
        '3rd', DateTime(2021, DateTime.february, 15, 9, 0, 0), DateTime(2021, DateTime.february, 21, 9, 0, 0), const Color(0xFFC9512C), false));
    meetings.add(Meeting(
        '4th', DateTime(2021, DateTime.february, 19, 9, 0, 0), DateTime(2021, DateTime.february, 25, 9, 0, 0), const Color(0xFF2BC51B), false));

    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

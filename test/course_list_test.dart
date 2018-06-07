import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:courses_in_english/ui/screens/course_list_screen.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/course/time_and_day.dart';

/*const Map<int, Department> MOCK_DEPARTMENTS = const <int, Department>{
  1: const Department(1, "Architecture", const Color(0xFF014085)),
  2: const Department(2, "Civil Engineering", const Color(0xFF008db8)),
  3: const Department(3, "Mechanical, Automotive and Aeronautical Engineering",
      const Color(0xFF018bc9)),
  4: const Department(4, "Electrical Engineering and Information Technology",
      const Color(0xFF0198ab)),
  5: const Department(
      5,
      "Building Services Engineering, Paper and Packaging Technology and Print and Media Technology",
      const Color(0xFF016fb2)),
  6: const Department(
      6, "Applied Sciences and Mechatronics", const Color(0xFF04539d)),
  7: const Department(
      7, "Computer Science and Mathematics", const Color(0xFF029fd0)),
  8: const Department(8, "Geoinformatics", const Color(0xFF018a8a)),
  9: const Department(9, "Engineering and Management", const Color(0xFF018e62)),
  10: const Department(10, "Business Administration", const Color(0xFF028d7c)),
  11: const Department(11, "Applied Social Sciences", const Color(0xFFed7406)),
  12: const Department(12, "Design", const Color(0xFF0f3647)),
  13: const Department(
      13, "General and Interdisciplinary Studies", const Color(0xFFbf0179)),
  14: const Department(14, "Tourism", const Color(0xFFa41948))
};

const List<Course> MOCK_COURSES = const <Course>[
  const Course(
      0,
      "Mobile Application Development",
      "Lothstraße",
      '''
This course studies selected, specific aspects of the functionality of mobile applications. The exact topics
including the type of application, the context of the application and the type of mobile devices will be
announced on the first day of class.
Topics include:
* Mobile applications and their platforms
* Examples of mobile applications and current developments
* Common development environments and programming languages ​for mobile devices
* Sensors in mobile devices (e.g., accelerometers, GPS, camera)
* Input options (touch screen, multi-touch)
* Use of mobile networks (Bluetooth, WLAN)
* Innovative human-machine interaction
        ''',
      7,
      0,
      "Socher",
      "R2.016",
      CourseStatus.GREEN,
      const [],
      30,
      5,
      4,
      const TimeAndDay(5, "15:15 - 16:45", 5)),
  const Course(
      1,
      "Marketing",
      "Pasing",
      '''
 By the end of the course students will:
 Know the basics of marketing for industrial goods and consumer goods
 Understand the need for market research
 Know the requirements of and procedures in the segmentation and positioning
of companies and products
 Be aware of the integrated product lifecycle
 Be able to apply their new marketing knowledge in a simulation game or project
work. As an outcome, students will have gained experience how to create a
product that meets customers’ needs, select sales channels, set the price and
use advertising to increase demand. They will have gained insights how
marketing influences the success of a company. Students will also have gained
experience in teamwork
    ''',
      9,
      1,
      "Schuckmann",
      "C2.001",
      CourseStatus.RED,
      const [],
      20,
      4,
      3,
      const TimeAndDay(3, "11:45 - 13:30", 3)),
  const Course(
      2,
      "Social Work In Theory and Practice",
      "Pasing",
      '''
Important Social Workers and scientist from different social science as much as their way of thinking and
working will be presented. To drop a few names: Alice Salomon, Jane Addams, Mary Ellen Richmond,
Ilse Arlt, Octavia Hill will be introduced. The aim of the course is to show how the social and political
setting influcend how people thought about poor people, illness, deseases etc. and how a scientific
approach helped to overcome prejudices. There will also be discussion on the methods that were used
and how much of these are still relevant for modern Social Work.
    ''',
      11,
      2,
      "Pötter",
      "B1.003",
      CourseStatus.YELLOW,
      const [],
      14,
      2.5,
      2,
      const TimeAndDay(4, "8:15 - 9:45", 1)),
  const Course(
      3,
      "Design of Digital Products and Services",
      "Pasing",
      '''
With the rise of digital and mobile technologies, development of digital products and
services has become a fundamental part of corporations of any size. This class is centered around the
execution of a real-world project – developing a product or service from idea through first pass prototype in
an inter-disciplinary team of students. Teams will be coached by faculty and designers from local firms. Inclass
time will be a mixture of lectures, project work, case discussions and guest lecturers.
    ''',
      12,
      3,
      "Koebler",
      "T5.056",
      CourseStatus.YELLOW,
      const [],
      20,
      6,
      4,
      const TimeAndDay(1, "10:00 - 11:30", 2)),
  const Course(
      4,
      "Dynamics for Engineers",
      "Pasing",
      '''
Review of underlying mathematical Priciples. Review of single degree of freedom systems. Kinetics and
Kinematics of 3D rigid bodies. Numerical Methods. Multiple degree of freedom systems.
Multidimensional Oscillations. Applications for engineering problems.
    ''',
      3,
      4,
      "Wolfsteiner",
      "T0.005",
      CourseStatus.GREEN,
      const [],
      45,
      5,
      4,
      const TimeAndDay(1, "8:15 - 9:45", 1))
];

void main() {
  testWidgets('Test Course List Item Informations',
      (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(
      home: new CourseListScreen(MOCK_COURSES, MOCK_DEPARTMENTS.values),
    ));

    for (var course in MOCK_COURSES) {
      expect(find.text(course.name), findsOneWidget);
      expect(find.text(course.timeAndDay.toDate()), findsOneWidget);
      expect(
          find.text(
              "Department " + course.department.toString().padLeft(2, '0')),
          findsOneWidget);
    }
  });

  testWidgets('Test Course List Item favorite mechanism',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      new MaterialApp(
        home: new CourseListScreen(MOCK_COURSES, MOCK_DEPARTMENTS.values),
      ),
    );

    expect(
        find.byIcon(Icons.favorite_border), findsNWidgets(MOCK_COURSES.length));
    expect(find.byIcon(Icons.favorite), findsNothing);
    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump();
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border),
        findsNWidgets(MOCK_COURSES.length - 1));
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();
    expect(
        find.byIcon(Icons.favorite_border), findsNWidgets(MOCK_COURSES.length));
    expect(find.byIcon(Icons.favorite), findsNothing);
  });
}*/
void main() {

}

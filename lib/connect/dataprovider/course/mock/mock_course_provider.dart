import 'dart:async';

import 'package:courses_in_english/connect/dataprovider/course/course_provider.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/course/course_status.dart';

class MockCourseProvider implements CourseProvider {
  static const List<Course> MOCK_COURSES = const <Course>[
    const Course(
        0,
        "Mobile Application Development",
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
        "R2.016",
        CourseStatus.GREEN,
        const [],
        30,
        5,
        4),
    const Course(
        1,
        "Marketing",
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
        "",
        CourseStatus.RED,
        const [],
        20,
        4,
        3),
    const Course(
        2,
        "Social Work In Theory and Practice",
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
        "",
        CourseStatus.YELLOW,
        const [],
        14,
        2.5,
        2),
    const Course(
        3,
        "Design of Digital Products and Services",
        '''
With the rise of digital and mobile technologies, development of digital products and
services has become a fundamental part of corporations of any size. This class is centered around the
execution of a real-world project – developing a product or service from idea through first pass prototype in
an inter-disciplinary team of students. Teams will be coached by faculty and designers from local firms. Inclass
time will be a mixture of lectures, project work, case discussions and guest lecturers.
    ''',
        12,
        3,
        "",
        CourseStatus.YELLOW,
        const [],
        20,
        6,
        4),
    const Course(
        4,
        "Dynamics for Engineers",
        '''
Review of underlying mathematical Priciples. Review of single degree of freedom systems. Kinetics and
Kinematics of 3D rigid bodies. Numerical Methods. Multiple degree of freedom systems.
Multidimensional Oscillations. Applications for engineering problems.
    ''',
        3,
        4,
        "",
        CourseStatus.GREEN,
        const [],
        45,
        5,
        4)
  ];

  @override
  Future<Course> getCourse(int courseId) async {
    return new Future.delayed(
        const Duration(milliseconds: 300), () => MOCK_COURSES[courseId]);
  }

  @override
  Future<List<Course>> getCourses() async {
    return new Future.delayed(
        const Duration(milliseconds: 700), () => MOCK_COURSES);
  }

  @override
  Future<Iterable<Course>> getCoursesByDepartment(int department) async {
    return new Future.delayed(const Duration(milliseconds: 500),
        () => MOCK_COURSES.where((course) => course.department == department));
  }

  @override
  Future<Iterable<Course>> getCoursesByDepartments(
      List<int> departments) async {
    return new Future.delayed(
        const Duration(milliseconds: 600),
        () => MOCK_COURSES
            .where((course) => departments.contains(course.department)));
  }
}

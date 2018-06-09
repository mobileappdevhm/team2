import 'package:courses_in_english/model/campus/campus.dart';
import 'package:courses_in_english/model/course/course.dart';
import 'package:courses_in_english/model/course/time_and_day.dart';
import 'package:courses_in_english/model/department/department.dart';
import 'package:courses_in_english/model/lecturer/lecturer.dart';

const department01 = const Department(
  1,
  1,
  "Architecture",
  0xFF014085,
);
const department02 = const Department(
  2,
  2,
  "Civil Engineering",
  0xFF008db8,
);
const department03 = const Department(
  3,
  3,
  "Mechanical, Automotive and Aeronautical Engineering",
  0xFF018bc9,
);
const department04 = const Department(
  4,
  4,
  "Electrical Engineering and Information Technology",
  0xFF0198ab,
);
const department05 = const Department(
  5,
  5,
  "Building Services Engineering, Paper and Packaging Technology "
      "and Print and Media Technology",
  0xFF016fb2,
);
const department06 = const Department(
  6,
  6,
  "Applied Sciences and Mechatronics",
  0xFF04539d,
);
const department07 = const Department(
  7,
  7,
  "Computer Science and Mathematics",
  0xFF029fd0,
);
const department08 = const Department(
  8,
  8,
  "Geoinformatics",
  0xFF018a8a,
);
const department09 = const Department(
  9,
  9,
  "Engineering and Management",
  0xFF018e62,
);
const department10 = const Department(
  10,
  10,
  "Business Administration",
  0xFF028d7c,
);
const department11 = const Department(
  11,
  11,
  "Applied Social Sciences",
  0xFFed7406,
);
const department12 = const Department(
  12,
  12,
  "Design",
  0xFF0f3647,
);
const department13 = const Department(
  13,
  13,
  "General and Interdisciplinary Studies",
  0xFFbf0179,
);
const department14 = const Department(
  14,
  14,
  "Tourism",
  0xFFa41948,
);

const lecturer01 = const Lecturer(0, "Socher", "test@hm.edu");
const lecturer02 = const Lecturer(1, "Schuckmann", "test@hm.edu");
const lecturer03 = const Lecturer(2, "Pötter", "test@hm.edu");
const lecturer04 = const Lecturer(3, "Koebler", "test@hm.edu");
const lecturer05 = const Lecturer(4, "Wolfsteiner", "test@hm.edu");

const campus01 = const Campus(
    0,
    "Lothstraße",
    "res/location/campus_lothstr.png",
    'https://www.google.com/maps/place/University+of+Applied+Science+Munich/@48.1542311,11.5570298,17.62z/data=!4m8!1m2!2m1!1shochschule+m%C3%BCnchen!3m4!1s0x0:0x18bfe7f8741350da!8m2!3d48.1548088!4d11.5561071');
const campus02 = const Campus(
    1,
    "Karlstraße",
    "res/location/campus_karlstr.png",
    'https://www.google.com/maps/place/University+of+Applied+Science+Munich/@48.1542311,11.5570298,17.62z/data=!4m8!1m2!2m1!1shochschule+m%C3%BCnchen!3m4!1s0x0:0x18bfe7f8741350da!8m2!3d48.1548088!4d11.5561071');
const campus03 = const Campus(2, "Pasing", "res/location/campus_pasing.png",
    'https://www.google.com/maps/place/University+of+Applied+Science+Munich/@48.1542311,11.5570298,17.62z/data=!4m8!1m2!2m1!1shochschule+m%C3%BCnchen!3m4!1s0x0:0x18bfe7f8741350da!8m2!3d48.1548088!4d11.5561071');

const course01 = const Course(
  0,
  //id
  "Mobile Application Development",
  //name
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
  //description
  "R2.016",
  //room
  30,
  //availableSlots
  5.0,
  //ects
  4.0,
  //us credits
  4.0,
  //semester week hours
  CourseStatus.GREEN,
  //status
  lecturer01,
  //lecturer
  department07,
  //department
  campus01, //location
  [
    const TimeAndDay(1, 5, 15, 15, 90, 0),
  ],
  //timeandday
);
const course02 = const Course(
  1,
  //id
  "Marketing",
  //name
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
  //description
  "C2.001",
  //room
  20,
  //availableSlots
  .0,
  //ects
  4.0,
  //us credits
  3.0,
  //semester week hours

  //timeandday
  CourseStatus.RED,
  //status
  lecturer02,
  //lecturer
  department09,
  //department
  campus03, //location
  [
    const TimeAndDay(2, 3, 11, 45, 90, 1),
  ],
);
const course03 = const Course(
  2,
  //id
  "Social Work In Theory and Practice",
  //name
  '''
Important Social Workers and scientist from different social science as much as their way of thinking and
working will be presented. To drop a few names: Alice Salomon, Jane Addams, Mary Ellen Richmond,
Ilse Arlt, Octavia Hill will be introduced. The aim of the course is to show how the social and political
setting influcend how people thought about poor people, illness, deseases etc. and how a scientific
approach helped to overcome prejudices. There will also be discussion on the methods that were used
and how much of these are still relevant for modern Social Work.
       ''',
  //description
  "B1.003",
  //room
  14,
  //availableSlots
  2.5,
  //ects
  2.5,
  //us credits
  2.0,
  //semester week hours
  CourseStatus.YELLOW,
  //status
  lecturer03,
  //lecturer
  department11,
  //department
  campus03, //location
  [
    const TimeAndDay(2, 4, 8, 15, 90, 2),
  ],
  //timeandday
);
const course04 = const Course(
  3,
  //id
  "Design of Digital Products and Services",
  //name
  '''
With the rise of digital and mobile technologies, development of digital products and
services has become a fundamental part of corporations of any size. This class is centered around the
execution of a real-world project – developing a product or service from idea through first pass prototype in
an inter-disciplinary team of students. Teams will be coached by faculty and designers from local firms. Inclass
time will be a mixture of lectures, project work, case discussions and guest lecturers.
      ''',
  //description
  "T5.056",
  //room
  20,
  //availableSlots
  6.0,
  //ects
  4.5,
  //us credits
  4.0,
  //semester week hours

  CourseStatus.YELLOW,
  //status
  lecturer04,
  //lecturer
  department12,
  //department
  campus03, //location
  [
    const TimeAndDay(3, 1, 10, 0, 90, 3),
  ],
  //timeandday
);
const course05 = const Course(
  4,
  //id
  "Dynamics for Engineers",
  //name
  '''
Review of underlying mathematical Priciples. Review of single degree of freedom systems. Kinetics and
Kinematics of 3D rigid bodies. Numerical Methods. Multiple degree of freedom systems.
Multidimensional Oscillations. Applications for engineering problems.
     ''',
  //description
  "T0.005",
  //room
  45,
  //availableSlots
  5.0,
  //ects
  4.0,
  //us credits
  4.0,
  //semester week hours

  //timeandday
  CourseStatus.GREEN,
  //status
  lecturer05,
  //lecturer
  department03,
  //department
  campus02, //location
  [
    const TimeAndDay(4, 1, 8, 15, 90, 4),
  ],
);

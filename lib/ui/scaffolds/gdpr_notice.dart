import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GdprNotice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Gdpr Notice"),
        ),
        body: new Row(children: [
          new Expanded(child:
          new SingleChildScrollView(
            reverse: true,
            controller: new ScrollController(),
            padding: new EdgeInsets.all(15.0),
            child: new Text(
              "Privacy Policy\n\n" +
                  "1. Introduction\n" +
                  "\tThis privacy policy informs you about the way the CiE-App \nhandles personal data.\n" +
                  "2. Controller\n" +
                  "\tHochschule für angewandte Wissenschaften München\n" +
                  "\tKörperschaft des öffentlichen Rechts, vertreten durch den\nPräsidenten Prof. Dr. Martin Leitner\n" +
                  "\tLothstraße 34\n" +
                  "\tD-80335 München\n" +
                  "\tTel.: +49 (0) 89 12 65 - 0\n" +
                  "\tEmail: presse@hm.edu\n" +
                  "\tInternet: www.hm.edu\n" +
                  "3. Contact\n" +
                  "\tProf. Dr. Gudrun Socher\n" +
                  "\tFakultät für Informatik und Mathematik\n" +
                  "\tLothstraße 64\n" +
                  "\tD-80335 München\n" +
                  "\tEmail: gudrun.socher@hm.edu\n" +
                  "4. Data we store about you\n" +
                  "\tTo provide you with our service, we need to store some of your\ndata. In following, we specify exactly what we store about you:\n"
                  "\t•	\tYour e-mail address\n" +
                  "\t•	\tYour selected courses\n" +
                  "\t•	\tYour favorized courses\n" +
                  "\t•	\tThe courses you take\n" +
                  "\t•\tA unique ID\n"
                  "\tSpecifically, we store this data to provide you with a better \nservice. You will be able to change devices and keep your data intact. You can opt-out of storage of these data using the settings in this app.\n" +
                  "\tAdditionally, we use Firebase products in our app. Firebase is a\ncompany of Alphabet Inc. and is situated in the USA, which means data might be transmitted outside the EU, these don't include any personally identifiable data.\n" +
                  "\tWe do not share data with other Google services.\nYou can opt-out of our collection of anonymous analytics data by signing into the app and toggling the setting for it.\n"
                  "5.	Affected Persons\n" +
                  "\tIf you use this app, you consent to our data storage. \nWe do not collect or store personally identifiable data if you are not logged in.\n" +
                  "6.	Purpose\n" +
                  "\tWe process your data to provide you with information \nabout the Courses in English as well as providing you with the information allocated to you.\n" +
                  "7.	Duration of Storage\n" +
                  "\tAll our data is stored as long as the user uses the CiE services. \nAnalytical data is deleted after 14 days.\n" +
                  "8. Right of Objection\n" +
                  "\tYou can stop further processing of you data according to Art. 21\nDSGVO by contacting the CiE contact person. (see 3.)\n",
              style: new TextStyle(
                fontSize: 12.0,
                color: Colors.black,
              ),
            textAlign: TextAlign.start,),
          )),
        ]));
  }
}

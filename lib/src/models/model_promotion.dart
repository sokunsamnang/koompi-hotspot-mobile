
import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/src/models/model_activity.dart';
import 'package:url_launcher/url_launcher.dart';

class Promotion {
  String imageUrl;
  String city;
  String country;
  RichText description;
  List<Activity> activities;

  Promotion({
    this.imageUrl,
    this.city,
    this.country,
    this.description,
    this.activities,
  });
}

List<Activity> activities = [
  Activity(
    imageUrl: 'assets/images/onboarding0.png',
    name: 'St. Mark\'s Basilica',
    type: 'Sightseeing Tour',
    startTimes: ['9:00 am', '11:00 am'],
    rating: 5,
    price: 30,
  ),
  Activity(
    imageUrl: 'assets/images/onboarding1.png',
    name: 'Walking Tour and Gonadola Ride',
    type: 'Sightseeing Tour',
    startTimes: ['11:00 pm', '1:00 pm'],
    rating: 4,
    price: 210,
  ),
  Activity(
    imageUrl: 'assets/images/onboarding2.png',
    name: 'Murano and Burano Tour',
    type: 'Sightseeing Tour',
    startTimes: ['12:30 pm', '2:00 pm'],
    rating: 3,
    price: 125,
  ),
];

List<Promotion> promotions = [
  Promotion(
    imageUrl: 'assets/images/promotion0.jpg',
    city: 'Tote Bag',
    country: 'Pre-Order',
    description: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "ទែន ទែន.....KOOMPI ក៏មាន tote bag ដែរ!​ 🤩 ✨​Pre-order now!! ដើមី្បបានតម្លៃពិសេស! ✨ទទួល pre-order រហូតដល់ថ្ងៃទី 10 ខែកុម្ភៈ ✨​​Inbox or call us: ",
            style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Medium')
          ),
          TextSpan(
            style: TextStyle(color: Colors.blue, fontSize: 18, fontFamily: 'Medium'),
              text: "077 990 887",
              recognizer: TapGestureRecognizer()..onTap =  () async{
                var url = "tel://077 990 887";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
              }
          ),
          TextSpan(
            text: "/ ",
            style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Medium')
          ),
          TextSpan(
            style: TextStyle(color: Colors.blue, fontSize: 18, fontFamily: 'Medium'),
              text: "069 551 651",
              recognizer: TapGestureRecognizer()..onTap =  () async{
                var url = "tel://069 551 651";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
              }
          ),
        ]
      ),
    ),
    activities: activities,
  ),
  Promotion(
    imageUrl: 'assets/images/promotion1.jpg',
    city: 'KOOMPI E11',
    country: 'Upgrade SSD',
    description: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "KOOMPI E11 អាចថែម SSD Sata M2 បាន! 👉​ 128 GB = 30\$ 👉 Buy now: ",
            style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Medium')
          ),
          TextSpan(
            style: TextStyle(color: Colors.blue, fontSize: 18, fontFamily: 'Medium'),
              text: "https://koompi.com/koompi/e11/",
              recognizer: TapGestureRecognizer()..onTap =  () async{
                var url = "https://koompi.com/koompi/e11/";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
              }
          ),
          TextSpan(
            text: " 📞 Or Call for more information: ",
            style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Medium')
          ),
          TextSpan(
            style: TextStyle(color: Colors.blue, fontSize: 18, fontFamily: 'Medium'),
              text: "077 990 887",
              recognizer: TapGestureRecognizer()..onTap =  () async{
                var url = "tel://077 990 887";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
              }
          ),
          TextSpan(
            text: "/ ",
            style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Medium')
          ),
          TextSpan(
            style: TextStyle(color: Colors.blue, fontSize: 18, fontFamily: 'Medium'),
              text: "069 551 651",
              recognizer: TapGestureRecognizer()..onTap =  () async{
                var url = "tel://069 551 651";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
              }
          ),
        ]
      ),
    ),
    activities: activities,
  ),
  Promotion(
    imageUrl: 'assets/images/promotion2.png',
    city: 'KOOMPI E13',
    country: 'Upgrade SSD',
    description: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "📣កាន់តែពិសេស! អ្នកចង់បានទំហំផ្ទុកប៉ុន្មានក៏បានដែរ ហើយថែមទាំងមានប្រូម៉ូសិនទៀត! 👉 Buy now: ",
            style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Medium')
          ),
          TextSpan(
            style: TextStyle(color: Colors.blue, fontSize: 18, fontFamily: 'Medium'),
              text: "https://koompi.com/koompi/e13/",
              recognizer: TapGestureRecognizer()..onTap =  () async{
                var url = "https://koompi.com/koompi/e13/";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
              }
          ),
          TextSpan(
            text: " 📞 Or Call for more information: ",
            style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Medium')
          ),
          TextSpan(
            text: " 📞 Or Call for more information: ",
            style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Medium')
          ),
          TextSpan(
            style: TextStyle(color: Colors.blue, fontSize: 18, fontFamily: 'Medium'),
              text: "077 990 887",
              recognizer: TapGestureRecognizer()..onTap =  () async{
                var url = "tel://077 990 887";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
              }
          ),
          TextSpan(
            text: "/ ",
            style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Medium')
          ),
          TextSpan(
            style: TextStyle(color: Colors.blue, fontSize: 18, fontFamily: 'Medium'),
              text: "069 551 651",
              recognizer: TapGestureRecognizer()..onTap =  () async{
                var url = "tel://069 551 651";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
              }
          ),
        ]
      ),
    ),
    activities: activities,
  ),
];

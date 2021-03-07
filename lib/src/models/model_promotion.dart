import 'package:koompi_hotspot/all_export.dart';
import 'package:url_launcher/url_launcher.dart';

class Promotion {
  String imageUrl;
  String title;
  String category;
  RichText description;

  Promotion({
    this.imageUrl,
    this.title,
    this.category,
    this.description,
  });
}

List<Promotion> promotions = [
  Promotion(
    imageUrl: 'assets/images/promotion3.jpg',
    title: 'Think!Think! x KOOMPI Duo!',
    category: 'News',
    description: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "ដំណឹងល្អ!!! ឥឡូវនេះ​ Think!Think! មាននៅលើកុំព្យូទ័រយួរដៃ KOOMPI E11 ហើយ! សម្រាប់អតិថិជនប្រើប្រាស់ KOOMPI OS អាច install >> pix -i ThinkThink-SchoolEdition \n\nThink!Think! គឺជាកម្មវិធីសិក្សាជាប់ចំណាត់ថ្នាក់លេខ ១ មកពីប្រទេសជប៉ុននិងផ្តល់ជូននូវល្បែងប្រាជ្ញាដ៏រីករាយដែលមានគោលបំណងដើម្បីអភិវឌ្ឍជំនាញការគិតរបស់កុមារនិង non-cognitive skill។ វាពិតជាសប្បាយខ្លាំងសម្រាប់កុមារ​ដោយពុំមានអារម្មណ៍ថាពួកគេកំពុងតែរៀនឡើយ!​ \n\nKOOMPI ផ្តល់ជូននូវកុំព្យូទ័រយួរដៃដែលមានគុណភាពល្អនិងមានតម្លៃសមរម្យសម្រាប់តម្រូវការប្រចាំថ្ងៃរបស់មនុស្សគ្រប់គ្នា! ទទួលយកបទពិសោធន៍ថ្មីឥឡូវនេះ! \n\nGreat news! Think!Think! App is now available on KOOMPI E-11 laptop!!! For KOOMPI OS user can install >>pix -i ThinkThink-SchoolEdition \n\nThink!Think! is Japans No.1 learning app packed with fun educational games that aim to develop childrens thinking skills and non-cognitive skills. It’s too fun for children to know they are actually learning! \n\nKOOMPI offers good quality and affordable laptops for everyone everyday needs!Experience the duo NOW!",
            style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Medium')
          ),
        ]
      ),
    ),
  ),
  Promotion(
    imageUrl: 'assets/images/promotion4.png',
    title: 'KOOMPI Releases New ISO (version 2.6)',
    category: 'News',
    description: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "🤩 Finally, KOOMPI has released new ISO (Version 2.6)! You can check for more detailed on how to install KOOMPI new ISO on KOOMPI telegram channel. ",
            style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Medium')
          ),
          TextSpan(
            style: TextStyle(color: Colors.blue, fontSize: 18, fontFamily: 'Medium'),
              text: "https://t.me/koompi",
              recognizer: TapGestureRecognizer()..onTap =  () async{
                var url = "https://t.me/koompi";
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
  ),
  Promotion(
    imageUrl: 'assets/images/promotion5.jpg',
    title: 'Come and test, KOOMPI',
    category: 'News',
    description: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "អ្នកទាំងអស់គ្នាអាចមកធ្វើការតេស កុំព្យូទ័រ KOOMPI បាន ទោះបីមិនមានការជាវក៏ដោយ នៅ KOOMPI Boran House 📍",
            style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Medium')
          ),
          TextSpan(
            style: TextStyle(color: Colors.blue, fontSize: 18, fontFamily: 'Medium'),
              text: "https://goo.gl/maps/tSiXiHkdQX3SB7RP9",
              recognizer: TapGestureRecognizer()..onTap =  () async{
                var url = "https://goo.gl/maps/tSiXiHkdQX3SB7RP9";
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
  ),
  Promotion(
    imageUrl: 'assets/images/promotion0.jpg',
    title: 'Tote Bag',
    category: 'Pre-Order',
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
  ),
  Promotion(
    imageUrl: 'assets/images/promotion1.jpg',
    title: 'KOOMPI E11',
    category: 'Upgrade SSD',
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
  ),
  Promotion(
    imageUrl: 'assets/images/promotion2.png',
    title: 'KOOMPI E13',
    category: 'Upgrade SSD',
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
  ),
];

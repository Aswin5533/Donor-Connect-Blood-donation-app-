import 'package:blood_app/providerClass/providerClass.dart';
import 'package:blood_app/screens/homeScreen.dart';
import 'package:blood_app/utils/appColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Textscreen extends StatelessWidget {
  final String? docId;
  final String? names;
  final String? blood;
  final String? numbers;

  Textscreen({super.key, this.names, this.blood, this.numbers, this.docId});

  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(
      text: names ?? "",
    );
    TextEditingController numberController = TextEditingController(
      text: numbers ?? "",
    );
    TextEditingController bloodController = TextEditingController(
      text: blood ?? "",
    );
    return Consumer<ListProvider>(
      builder:
          (context, providerList, child) => Scaffold(
            backgroundColor: AppColor.primaryColor,
            appBar: AppBar(
              backgroundColor: AppColor.secondaryColor,
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Homescreen()),
                  );
                },
                icon: Icon(CupertinoIcons.back, color: AppColor.whiteColor),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    String names = nameController.text;
                    String blood = bloodController.text;
                    String numbers = numberController.text;
                    if (docId != null) {
                      providerList.updateBlood(docId!, names, blood, numbers);
                    } else {
                      providerList.saveBlood(names, blood, numbers);
                    }
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Homescreen()),
                    );
                  },
                  icon: Icon(Icons.check, color: AppColor.whiteColor),
                ),
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: TextField(
                    style: TextStyle(color: AppColor.textColor),
                    maxLength: 20,
                    controller: nameController,
                    cursorColor: AppColor.textColor,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.secondaryColor),
                      ),
                      hintText: "Name",
                      hintStyle: TextStyle(color: AppColor.textColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: TextField(
                    maxLength: 3,
                    controller: bloodController,
                    style: TextStyle(color: AppColor.textColor),
                    decoration: InputDecoration(
                      hintText: "Blood Group",
                      hintStyle: TextStyle(color: AppColor.textColor),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.secondaryColor),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: TextField(
                    controller: numberController,
                    style: TextStyle(color: AppColor.textColor),
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      hintStyle: TextStyle(color: AppColor.textColor),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColor.secondaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}

import 'package:blood_app/providerClass/providerClass.dart';
import 'package:blood_app/textScreen.dart';
import 'package:blood_app/widgets/drawerWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../utils/appColor.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Consumer<ListProvider>(
      builder:
          (context, ProviderList, child) => Scaffold(
            backgroundColor: AppColor.primaryColor,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Textscreen()),
                );
              },
              backgroundColor: AppColor.secondaryColor,
              child: Icon(Icons.add, color: AppColor.primaryColor),
            ),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColor.secondaryColor,
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(user?.photoURL ?? " "),
                    ),
                  );
                },
              ),
            ),
            drawer: Drawerwidget(),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColor.blackColor,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          onChanged: (value) {
                            ProviderList.updateSearchBlood(value);
                          },
                          cursorColor: AppColor.secondaryColor,
                          style: TextStyle(color: AppColor.secondaryColor),
                          decoration: InputDecoration(
                            hintText: "Search Blood...",
                            hintStyle: TextStyle(color: AppColor.blackColor),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: ProviderList.blood,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 1.2,
                          child: Center(
                            child: LoadingAnimationWidget.threeArchedCircle(
                              color: AppColor.secondaryColor,
                              size: 40,
                            ),
                          ),
                        );
                      }
                      final docs = snapshot.data!.docs;
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Center(
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: docs.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  final doc = docs[index];
                                  final data =
                                      doc.data() as Map<String, dynamic>;
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      child: Material(
                                        elevation: 30,
                                        borderRadius: BorderRadius.circular(25),
                                        child: SizedBox(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) => Textscreen(
                                                        docId: doc.id,
                                                        names:
                                                            data['name']
                                                                .toString(),
                                                        blood:
                                                            data['bloodGroup']
                                                                .toString(),
                                                        numbers:
                                                            data['phoneNumber']
                                                                .toString(),
                                                      ),
                                                ),
                                              );
                                            },
                                            child: Dismissible(
                                              background: Container(
                                                color: Colors.transparent,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        right: 300,
                                                      ),
                                                  child: Icon(
                                                    Icons.delete,
                                                    color:
                                                        AppColor.secondaryColor,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                              key: UniqueKey(),
                                              direction:
                                                  DismissDirection.startToEnd,
                                              onDismissed: (direction) {
                                                ProviderList.deleteblood(
                                                  doc.id,
                                                );
                                                DismissDirection.startToEnd;
                                              },
                                              child: Container(
                                                height:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.height /
                                                    11.5,
                                                width:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width,
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColor.secondaryColor,
                                                  border: Border.all(
                                                    color:
                                                        AppColor.secondaryColor,
                                                    width: 3,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(25),
                                                        bottomRight:
                                                            Radius.circular(25),
                                                        topRight:
                                                            Radius.circular(25),
                                                      ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top: 6,
                                                        left: 10,
                                                      ),
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            data['name'],
                                                            style: GoogleFonts.alatsi(
                                                              textStyle: TextStyle(
                                                                color:
                                                                    AppColor
                                                                        .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 22,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            data['phoneNumber'],
                                                            style: GoogleFonts.alatsi(
                                                              textStyle: TextStyle(
                                                                color:
                                                                    AppColor
                                                                        .primaryColor,
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacer(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                              bottom: 10,
                                                            ),
                                                        child: CircleAvatar(
                                                          radius: 20,
                                                          backgroundColor:
                                                              AppColor
                                                                  .primaryColor,
                                                          child: Center(
                                                            child: Text(
                                                              data['bloodGroup'],
                                                              style: GoogleFonts.alatsi(
                                                                textStyle: TextStyle(
                                                                  color:
                                                                      AppColor
                                                                          .secondaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 20),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );

                      // } else {
                      // return Center(
                      // child: Text(
                      // "No Bloods",
                      // style: TextStyle(
                      // color: AppColor.textColor,
                      // fontSize: 30,
                      // fontWeight: FontWeight.bold,
                      // ),
                      // ),
                      // );
                      // }
                    },
                  ),
                ],
              ),
            ),
          ),
    );
  }
}

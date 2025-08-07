import 'package:blood_app/googleAuth/authLogin.dart';
import 'package:blood_app/screens/homeScreen.dart';
import 'package:blood_app/utils/appColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Signinpage extends StatelessWidget {
  const Signinpage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FirebaseAuth.instance.currentUser == null) {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: 350,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColor.secondaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/typebloods.png"),fit: BoxFit.cover
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: () async {
                        var user = await signInWithGoogle();
                        if (user != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Homescreen(),
                            ),
                          );
                        } else {
                          print("Failed");
                        }
                      },
                      child: Container(
                        width: 300,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                "assets/images/googlelogo.png",
                              ),
                            ),
                            Text(
                              " Continue with google  ",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Homescreen()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 250,
              width: 250,
              child: Lottie.asset(
                'assets/animations/appanimation.json',
                fit: BoxFit.contain,
              ),
            ),
            Center(
              child: Text(
                "Donor Connect",
                style: GoogleFonts.allerta(
                  textStyle: TextStyle(
                    color: AppColor.secondaryColor,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 10),
          ],
        ),
      ),
    );
  }
}

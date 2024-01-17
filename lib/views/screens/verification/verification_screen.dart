import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ecommerce/views/router/route_imports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../data/constants/material_data.dart';
import '../../widgets/background_image/background_image.dart';
import '../../widgets/custom_text/custom_text.dart';

class VerificationScreen extends StatefulWidget {
  VerificationScreen({Key key}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  User user;
  int counter = 30;
  bool viewButton = false;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    user.reload();
    user.sendEmailVerification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomText(
          text: 'Verification',
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              NavigationServices.navigateToWithReplacementRemovedUntil(
                  LoginScreenRoute),
        ),
      ),
      backgroundColor: Colors.white,
      body: Countdown(
          seconds: counter,
          onFinished: () async {
            print('finished');
            setState(() {
              viewButton = true;
            });
            await user.reload();
            user = await FirebaseAuth.instance.currentUser;

            if (FirebaseAuth.instance.currentUser.emailVerified) {
              NavigationServices.navigateToWithReplacementRemovedUntil(
                  MainScreenRoute);
            }
          },
          interval: Duration(seconds: 1),
          build: (context, double time) {
            return Background(
              image: 'assets/images/verify.png',
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Container(
                        alignment: Alignment.center,
                        child: RichText(
                            textDirection: TextDirection.ltr, //TODO:;local
                            textAlign: TextAlign.center,
                            text: textSpanWidget(
                                'Email Verification has been sent to ',
                                Colors.deepPurpleAccent, [
                              textSpanWidget(user.email, Colors.blue.shade600),
                              textSpanWidget(' please verify it. ',
                                  Colors.deepPurpleAccent),
                            ])),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        child: CustomText(
                          text: 'Incorrect email address?',
                          textColor: Colors.red,
                          fontSize: 17,
                        ),
                        onTap: () async {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid)
                              .delete();
                          user.delete().then((value) {
                            NavigationServices
                                .navigateToWithReplacementRemovedUntil(
                                    RegisterScreenRoute);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Visibility(
                          visible: viewButton,
                          child: Column(
                            children: [
                              //resend verification "text"
                              GestureDetector(
                                child: CustomText(
                                  text: 'Resend verification link',
                                  textColor: Colors.red,
                                  fontSize: 17,
                                ),
                                onTap: () {
                                  FirebaseAuth.instance.currentUser
                                      .sendEmailVerification()
                                      .then((value) {
                                    ScaffoldMessenger.of(context)
                                      ..clearSnackBars()
                                      ..showSnackBar(SnackBar(
                                          content: Container(
                                        height: 100,
                                        child: CustomText(
                                          text: ' link sent',
                                        ),
                                      )));
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CupertinoButton(
                                  borderRadius: BorderRadius.circular(45),
                                  color: MaterialData.kPrimaryColor,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        .05,
                                    width:
                                        MediaQuery.of(context).size.width * .5,
                                    alignment: Alignment.center,
                                    child: CustomText(
                                      text: 'check validation',
                                      textColor:
                                          MaterialData.kPrimaryLightColor,
                                    ),
                                  ),
                                  onPressed: () async {
                                    await user.reload();
                                    user =
                                        await FirebaseAuth.instance.currentUser;

                                    print(user.emailVerified);
                                    if (user.emailVerified) {
                                      NavigationServices
                                          .navigateToWithReplacementRemovedUntil(
                                              MainScreenRoute);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          replacement: CustomText(
                            text: time.toInt().toString(),
                            textColor: MaterialData.kPrimaryColor,
                          ),
                        ),
                      ),
                    ])),
              ),
            );
          }),
    );
  }

  TextSpan textSpanWidget(String text, Color color, [List<TextSpan> children]) {
    return TextSpan(
        text: text,
        children: children ?? [],
        style: TextStyle(
          fontSize: 20,
          color: color ?? Colors.red[700],
        ));
  }
}

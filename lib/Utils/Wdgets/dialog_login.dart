import '../Constants/constants_colors.dart';
import '../Constants/global_data.dart';
import 'custom_alert_dialog.dart';
import 'drawer_menu_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Constants/routes.dart';

class DialogLogin {
  dialog(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (ctx) => CustomAlertDialog(
              title: "SignIn/SignUp required to access full app features !",
              description: "Are you want to SignIn/SignUp ?",
              buttons: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 20.0),
                  child: ButtonTheme(
                      height: 35.0,
                      minWidth: 90.0,
                      child: MaterialButton(
                          color: ColorConst.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          splashColor: Colors.white.withAlpha(40),
                          child: const Text("Cancel",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                          onPressed: () {
                            Navigator.pop(context, "");
                          })),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 20.0),
                  child: ButtonTheme(
                    height: 35.0,
                    minWidth: 90.0,
                    child: MaterialButton(
                      color: ColorConst.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      splashColor: Colors.white.withAlpha(40),
                      child: const Text("Yes",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                      onPressed: () async {
                        Navigator.pop(context, "");
                        box.remove(RoutesName.token);
                        box.remove(RoutesName.id);
                        box.erase();
                        try {
                          await FirebaseAuth.instance.signOut();
                          await GoogleSignIn().signOut();
                        } catch (e) {}
                        Get.offAndToNamed(RoutesName.loginInPageEmail);
                        isSkippedButtonPressed =
                            false; // reset skipped button to default
                        GetStorage().write("skip", isSkippedButtonPressed);
                      },
                    ),
                  ),
                )
              ],
            ));
  }
}

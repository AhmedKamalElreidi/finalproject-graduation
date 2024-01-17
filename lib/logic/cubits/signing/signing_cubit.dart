import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ecommerce/data/models/user/user_data_model.dart';
import 'package:final_project_ecommerce/views/router/route_imports.dart';
import 'package:final_project_ecommerce/views/widgets/custom_dialog/custom_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'signing_state.dart';

class SigningCubit extends Cubit<SigningState> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static Map<String, TextEditingController> controllers =
      <String, TextEditingController>{
    'first name': TextEditingController(text: ''),
    'last name': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
    'confirm password': TextEditingController(),
  };

  static TextEditingController get firstName => controllers['first name'];

  static TextEditingController get lastName => controllers['last name'];

  static TextEditingController get email => controllers['email'];

  static TextEditingController get password => controllers['password'];

  static TextEditingController get confirmPassword =>
      controllers['confirm password'];

  SigningCubit() : super(SigningInitial());

  Future<String> loginWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    emit(SigningLoading());
    Future.delayed(
      Duration(seconds: 5),
    );
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      emit(SigningDone(userCredential.user));
      return null;
    } catch (error) {
      var _error = error.toString().replaceRange(error.toString().indexOf('['),
          error.toString().indexOf(']') + 1, ' ');
      // print(_error + 'occurs at $stackTrace');
      CustomDialog.showAlertDialog(context, _error);
      emit(SigningFailed(_error));
      return _error;
    }
  }

  Future<String> registerWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    emit(SigningLoading());
    Future.delayed(Duration(seconds: 5));
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      UserDataModel user = UserDataModel(
        email: email.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        image: '',
        phone: '',
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user.uid)
          .set(user.toJson());
      // firebaseAuth.currentUser.sendEmailVerification();
      emit(SigningDone(userCredential.user));
      return null;
    } catch (error) {
      var _error = error.toString().replaceRange(error.toString().indexOf('['),
          error.toString().indexOf(']') + 1, ' ');
      CustomDialog.showAlertDialog(context, _error);
      emit(SigningFailed(_error));
      // print('error occurs in ===> $stacktrace');
      return _error;
    }
  }

  void logout() async {
    clearControllers();
    await firebaseAuth.signOut();
    NavigationServices.navigateToWithReplacementRemovedUntil(LoginScreenRoute);
  }

  String emailValidation(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (email.isEmpty)
      return 'email cannot be empty';
    else {
      if (!emailValid) {
        return 'enter a valid email ';
      } else {
        //email valid
        if (passwordValidation(password.text) == null) {
          return null;
        } else
          return null;
      }
    }
  }

  String passwordValidation(String password) {
    if (password.isEmpty)
      return 'password cannot be empty';
    else {
      if (password.length < 8)
        return 'password must be at least 8 bits';
      else
        return null;
    }
  }

  String nameValidation(String name, String type) {
    if (name.isEmpty)
      return '$type cannot be empty';
    else {
      return null;
    }
  }

  String defaultValidation(String value) {
    if (value.isEmpty)
      return 'field cannot be empty';
    else {
      return null;
    }
  }

  static void clearControllers() {
    controllers.values.forEach((element) {
      element.clear();
    });
  }

  Future<void> sendResetPasswordMail(
      {String email, BuildContext context}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(
        email: email,
      );
      CustomDialog.showAlertDialog(
          context, 'Link has been sent check your inbox',
          isReset: true);

      emit(SigningDone(firebaseAuth.currentUser));
    } catch (error) {
      var _error = error.toString().replaceRange(error.toString().indexOf('['),
          error.toString().indexOf(']') + 1, ' ');
      CustomDialog.showAlertDialog(context, _error);
      emit(SigningFailed(_error));
    }
  }

  @override
  Future<Function> close() {
    controllers.values.map((controller) => controller.dispose()).toList();
    // monitorUserVerification().cancel();
    return super.close();
  }

  String validateMobile(String value) {
    String pattern = r"^(?:[+0]9)?[0-9]{10,12}$";
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Enter phone number";
    } else if (!regExp.hasMatch(value)) {
      return "Enter a valid phone number";
    }
    return null;
  }

/*  StreamSubscription<User> monitorUserVerification() {
    return FirebaseAuth.instance.authStateChanges().listen((User user) {
      if(user ==null) {
        emit(NoSignedAccount());
      } else
      {
        if (user.emailVerified) {
          emit(EmailVerified());
        } else {
          emit(EmailNotVerified());
        }
      }
    });
  */

}

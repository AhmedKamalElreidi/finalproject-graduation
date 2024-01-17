import 'package:bloc/bloc.dart';
import 'package:final_project_ecommerce/views/widgets/custom_dialog/custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:meta/meta.dart';

part 'urls_state.dart';

class UrlsCubit extends Cubit<UrlsState> {
  UrlsCubit() : super(UrlsInitial());

  static void makingPhoneCall(BuildContext context,
      {@required String phoneNumber}) async {
    final url = 'tel:$phoneNumber';
    // 'tel:9876543210';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      }
    } catch (e) {
      CustomDialog.showAlertDialog(context, 'حدث خطأ');

      throw 'Could not launch $url';
    }
  }

  static void sendAnEmail(
    BuildContext context,
    String email,
    String productTitle,
  ) async {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: email.trim(),
        queryParameters: {'subject': 'Ask for product ( $productTitle )'});
    try {
      if (await canLaunch(_emailLaunchUri.toString()))
        await launch(_emailLaunchUri.toString());
    } catch (e) {
      CustomDialog.showAlertDialog(context, 'حدث خطأ');
      throw 'Could not launch $email';
    }
  }

  static void launchMaps(double latitude, double longitude,
      {String label = ''}) {
    MapsLauncher.launchCoordinates(latitude, longitude, label);
  }
}

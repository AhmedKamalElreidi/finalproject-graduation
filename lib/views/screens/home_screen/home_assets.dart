import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ecommerce/data/constants/enums.dart';
import 'package:final_project_ecommerce/data/models/user/user_data_model.dart';
import 'package:final_project_ecommerce/logic/cubits/signing/signing_cubit.dart';
import 'package:final_project_ecommerce/views/router/route_imports.dart';
import 'package:final_project_ecommerce/views/widgets/custom_appbar.dart';
import 'package:final_project_ecommerce/views/widgets/custom_text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:icon_shadow/icon_shadow.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

part 'Loaded_List_images.dart';

part 'HomeScreen.dart';

class HomeAssets {
  static final List<String> imageListAssets = [
    'assets/images/scroll_image1.png',
    'assets/images/scroll_image2.png',
    'assets/images/scroll_image3.png',
    'assets/images/scroll_image4.jpg',
  ];
  static final List<String> titlesList = [
    "What Is the New Administrative Capital of Egypt?",
    "What Are the Property Types Available in New Capital City?",
    "The New Capital Consists of:",
    "What Are the Conditions for Booking an Apartment in New Capital City If You Are Living Abroad?"
  ];
  static final List<String> detailsList = [
    "It is a smart administrative capital for urban development that introduces a modern concept of residence and is expected to accommodate 18 million people to 40 million people by 2050. Egypt is switching its capital city from Cairo to a brand-new constructed city “New Administrative Capital.”",
    ////
    "The residential district in New Capital is about 67% of its total area. It consists of 4000 villas and townhouses divided as follows:\n • Phase I: An area of 10,000 acres and will include 190 villas and 71 townhouses.\n • Phase II: An area of 15,000 acres and will include 139 villas and 50 townhouses.",
    ////////
    "• North Mohammed Bin Zabid settlement "
        "• Residential districts in New Capital. • Government administrative district • Business district • Cultural district.",

    ///
    "• Must be at least 21 years of age • Should provide a valid Egyptian passport • Should provide a valid residence document from abroad • Can’t book more than one unit "
        "• Should not have been allocated any unit within the social housing program "
        "• The applicant may not apply at the later stages of the project if a unit is allocated to them."
  ];

  HomeAssets._();
}

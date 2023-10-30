import 'dart:io';

import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/snack_bar.dart';
import 'package:untitled1/features/update_profile/update_profile.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_button.dart';
import 'navigation.dart';

class CardHomeActive extends StatelessWidget {
  const CardHomeActive({
    super.key,
    required this.name,
    required this.image,
    required this.phone,
    required this.timeSubscription,
    required this.long,
    required this.weight,
    required this.documentId,
    required this.index,
  });

  final String name;
  final String image;
  final String phone;
  final String timeSubscription;
  final String long;
  final String weight;
  final int documentId;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 14,
        ),
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).backgroundColor,
                offset: const Offset(0, 2),
                blurRadius: 6,
                spreadRadius: 0,
              ),
            ],
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 10,),
                  Text('$index'),
                  const Spacer(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            name,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            '$phone',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            '$long',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:18),
                          ),
                          Text(
                            '$weight K',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            '$timeSubscription',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 130,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(0.0),
                      ),
                      color: Theme.of(context).cardColor,
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(0.0),
                      ),
                      child: Image.file(
                        File(image),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomBottom(
                        onTap: () {
                          navigateTo(
                              context,
                              UpdateProfileScreen(
                                  name: name,
                                  imagee: image,
                                  phone: phone,
                                  timeSubscription: timeSubscription,
                                  long: long,
                                  weight: weight,
                                  documentId: documentId,
                              ),);
                        },
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(14.0),
                          bottomLeft: Radius.circular(14.0),
                        ),
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            ),
                        text: 'تعديل المعلومات',
                        colorBottom: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: CustomBottom(
                        onTap: () async {
                          // try {
                          final phoneNumber = phone.trim();
                          print(phoneNumber);
                          final url =
                              'https://wa.me/+964$phoneNumber?text=انتهى الاشتراك الخاص بالصالة الرياضية';
                          await launch(
                            url,
                            enableJavaScript: true,
                            // forceWebView: true,
                          ).catchError((e) {
                            showSnackBar(context, e.toString(), Colors.red);
                          });
                        },
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(14.0),
                          bottomRight: Radius.circular(14.0),
                        ),
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        text: 'واتس اب',
                        colorBottom: const Color(0xFF00A62E),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}

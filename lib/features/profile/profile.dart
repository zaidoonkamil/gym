import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/core/cubit/cubit.dart';
import 'package:untitled1/core/cubit/states.dart';
import 'package:untitled1/core/widgets/arrow_back.dart';
import 'package:untitled1/core/widgets/custom_button.dart';
import 'package:untitled1/core/widgets/custom_form_field.dart';
import 'package:untitled1/core/widgets/navigation.dart';
import 'package:untitled1/core/widgets/snack_bar.dart';
import 'package:untitled1/features/tapbar/tapbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController userNameController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController subsecribeController = TextEditingController();
  static TextEditingController widghthController = TextEditingController();
  static TextEditingController longController = TextEditingController();
  static String image = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) {
            userNameController.text = '';
            phoneController.text = '';
            subsecribeController.text = '';
            widghthController.text = '';
            longController.text = '';
            image = '';
            navigateAndFinish(context, const TapBar());
          }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Stack(
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: 240,
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor!,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(220),
                            bottomLeft: Radius.circular(220),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 32),
                        child: Container(
                            alignment: Alignment.topCenter,
                            child: Text(
                              'تسجيل لاعب جديد',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  navigateBack(context);
                                },
                                child: ArrowBack(
                                  iconData: Icons.arrow_back_ios,
                                  colorIcon:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final picker = ImagePicker();
                              final imagee = await picker.pickImage(
                                  source: ImageSource.gallery);
                              image = imagee!.path;
                              print('/////////////');
                              print(image);
                              cubit.emitt();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ClipOval(
                                  child: image.isNotEmpty
                                      ? Image.file(
                                          File(image),
                                          width: 140.0,
                                          height: 140.0,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/images/Untitled_logo_4_free-file (5).jpg',
                                          width: 140.0,
                                          // Adjust the width as needed
                                          height: 140.0,
                                          // Adjust the height as needed
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 19.0, vertical: 21),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'الاسم   ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      CustomFormField(
                                        textStyleHint: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                        controller: userNameController,
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'رجائا ادخل الاسم';
                                          }
                                        },
                                        hintText: 'محمد احمد علي',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'رقم الهاتف   ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      CustomFormField(
                                        textStyleHint: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                        textInputType: TextInputType.phone,
                                        controller: phoneController,
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'رجائا ادخل رقم الهاتف';
                                          }
                                        },
                                        hintText: '07x xxxx xxx',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'الاشتراك   ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      CustomFormField(
                                        textInputType: TextInputType.none,
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2023),
                                            cancelText: null,
                                            lastDate: DateTime(2044),
                                          ).then((value) {
                                            value ??= DateTime.now();
                                            subsecribeController.text =
                                                DateFormat.yMd().format(value);
                                            var x =
                                                DateFormat.y().format(value);
                                            var z =
                                                DateFormat.M().format(value);
                                            var y =
                                                DateFormat.d().format(value);
                                            var c = '$x-$z-$y';
                                            subsecribeController.text = c;
                                          });
                                        },
                                        textStyleHint: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                        controller: subsecribeController,
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'رجائا ادخل الاشتراك';
                                          }
                                        },
                                        hintText: '2023/2/2',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'مبلغ الاشتراك   ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            CustomFormField(
                                              textInputType:
                                                  TextInputType.phone,
                                              textStyleHint: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                              controller: longController,
                                              validate: (String? value) {
                                                if (value!.isEmpty) {
                                                  return 'رجائا ادخل مبلغ الاشتراك';
                                                }
                                              },
                                              hintText: '20',
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 14,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'الوزن   ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            CustomFormField(
                                              textStyleHint: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                              textInputType:
                                                  TextInputType.phone,
                                              controller: widghthController,
                                              validate: (String? value) {
                                                if (value!.isEmpty) {
                                                  return 'رجائا ادخل الوزن';
                                                }
                                              },
                                              hintText: 'k 80 ',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 42,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomBottom(
                                        onTap: () async {
                                          if (formKey.currentState!.validate()) {
                                            if (image.isNotEmpty) {
                                              cubit.insertToDatabase(
                                                context: context,
                                                name: userNameController.text
                                                    .trim(),
                                                phone: phoneController.text,
                                                subTime:
                                                    subsecribeController.text,
                                                subPrice: longController.text,
                                                weight: widghthController.text,
                                                imagePath: image,
                                              );
                                            } else {
                                              showSnackBar(
                                                  context,
                                                  'قم بأختيار صورة',
                                                  Colors.red);
                                            }
                                          }
                                        },
                                        horizontal: 38,
                                        borderRadius: BorderRadius.circular(14),
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        text: 'تسجيل اللاعب',
                                        colorBottom: Theme.of(context)
                                            .bottomNavigationBarTheme
                                            .backgroundColor!,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

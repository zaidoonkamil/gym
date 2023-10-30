import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/core/cubit/cubit.dart';
import 'package:untitled1/core/cubit/states.dart';
import 'package:untitled1/core/styles/colors.dart';
import 'package:untitled1/core/widgets/card_home_active.dart';
import 'package:untitled1/core/widgets/custom_button.dart';
import 'package:untitled1/core/widgets/custom_form_field.dart';
import 'package:untitled1/core/widgets/navigation.dart';
import 'package:untitled1/features/profile/profile.dart';

class TapBar extends StatelessWidget {
  const TapBar({super.key});

  static TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return DefaultTabController(
            length: 5,
            child: SafeArea(
              child: Scaffold(
                body: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/Untitled_logo_4_free-file (5).jpg',
                                  height: 60,
                                ),
                                Text(
                                  'الماس',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 22),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomBottom(
                                    onTap: () {
                                      navigateTo(context, const ProfileScreen());
                                    },
                                    borderRadius: BorderRadius.circular(14),
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    text: 'اضافة مشترك جديد',
                                    colorBottom: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(width: 10,),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomBottom(
                                    height: 50,
                                    onTap: () {
                                        cubit.searchByName(searchController.text);
                                        cubit.searchByName2(searchController.text);
                                        if(searchController.text.isEmpty){
                                          cubit.createDatabase();
                                        }
                                        },
                                    borderRadius: BorderRadius.circular(14),
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    text: 'بحث',
                                    colorBottom: Theme.of(context).primaryColor,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  flex: 3,
                                  child: CustomFormField(
                                    width: double.maxFinite,
                                    textStyleHint: Theme.of(context).textTheme.headline3,
                                    textInputType: TextInputType.text,
                                    controller: searchController,
                                    hintText: 'بحث',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      ButtonsTabBar(
                        backgroundColor: primaryColor,
                        unselectedBackgroundColor: Colors.grey[300],
                        unselectedLabelStyle:
                            const TextStyle(color: Colors.black),
                        labelStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        tabs: const [
                          Tab(
                            text: "الاشتراكات الجارية",
                          ),
                          Tab(
                            text: "الاشتراكات المنتهية",
                          ),
                        ],
                      ),
                      ConditionalBuilder(
                        condition: state is! AppHomeGetDataLoadingState,
                          builder: (context){
                            return Expanded(
                              child: TabBarView(
                                children: [
                                  ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: cubit.newTasks.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                          child: CardHomeActive(
                                            name: cubit.newTasks[index]['name'],
                                            image: cubit.newTasks[index]['image'],
                                            phone: cubit.newTasks[index]['phone'],
                                            timeSubscription: cubit.newTasks[index]['subTime'],
                                            long: cubit.newTasks[index]['subPrice'],
                                            weight: cubit.newTasks[index]['weight'],
                                            documentId: cubit.newTasks[index]['id'],
                                            index: index+1,
                                          ),
                                        );
                                      }),
                                  ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: cubit.newTasks2.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                          child: CardHomeActive(
                                            name: cubit.newTasks2[index]['name'],
                                            image: cubit.newTasks2[index]['image'],
                                            phone: cubit.newTasks2[index]['phone'],
                                            timeSubscription: cubit.newTasks2[index]['subTime'],
                                            long: cubit.newTasks2[index]['subPrice'],
                                            weight: cubit.newTasks2[index]['weight'],
                                            documentId: cubit.newTasks2[index]['id'],
                                            index: index+1,
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            );
                          },
                        fallback: (context)=> Center(child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        )),),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

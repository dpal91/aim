import '../Widgets/category_details_widgets.dart';

import '../../../../Utils/Constants/constants_colors.dart';

import '../../../../Utils/Wdgets/appbar.dart';
import '../../../../Utils/Wdgets/elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryDetailsPage extends StatefulWidget {
  const CategoryDetailsPage({Key? key}) : super(key: key);

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  bool isChecked = false;
  bool status = false;
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Health & Fitness',
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_header(), _body(), _footer(context)],
            ),
          ),
        ),
      ),
    );
  }

  Widget _footer(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SizedBox(
            width: 270,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 95,
                        width: 180,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              "https://img.freepik.com/free-photo/successful-businesswoman-working-laptop-computer-her-office-dressed-up-white-clothes_231208-4809.jpg",
                              fit: BoxFit.fill,
                            )),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          // height: 30,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: const Center(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                Text(
                                  "5.0 ",
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Learn Phython\nProgramming",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 70,
                        child: Row(children: [
                          Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 19,
                          ),
                          Expanded(
                            child: Text(
                              "Linda Address",
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10),
                            ),
                          )
                        ]),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 70,
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: Colors.grey,
                              size: 15,
                            ),
                            Expanded(
                              child: Text(
                                "35 Minutes",
                                overflow: TextOverflow.ellipsis,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Free",
                        style: TextStyle(color: Colors.green, fontSize: 17),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                          child: Text(
                            "Text course",
                            style: TextStyle(fontSize: 11, color: Colors.green),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        itemCount: 5,
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                _modalBottomSheetMenuOptions(context);
              },
              child: const MyElevatedButton(
                label: 'Options',
              )),
          GestureDetector(
              onTap: () {
                _modalBottomSheetMenuFilter(context);
              },
              child: const MyElevatedButton(
                label: 'Filter',
              )),
        ],
      ),
    );
  }

  Widget _body() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(
        'Featured Courses',
        style: TextStyle(
            color: Colors.black,
            fontFamily: "Nunito",
            fontSize: 20,
            letterSpacing: 1,
            fontWeight: FontWeight.w900),
      ),
    );
  }

  void _modalBottomSheetMenuFilter(context) {
    _botomSheet(
      context,
      children: [
        reusableTitleTwo('Level'),
        reusableCheckBoxes('Begginer'),
        reusableCheckBoxes('Intermediate'),
        reusableCheckBoxes('Expert'),
        reusableTitleTwo('Language'),
        reusableCheckBoxes('English'),
        reusableCheckBoxes('Espanol'),
        reusableCheckBoxes('Hindi'),
        reusableCheckBoxes('Urdu'),
        reusableTitleTwo('PhotoShop'),
        reusableCheckBoxes('Adobe Illustrator'),
        reusableCheckBoxes('Blender'),
        reusableCheckBoxes('After effects'),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: MyElevatedButton(
            label: 'Filter Items',
          ),
        )
      ],
    );
  }

  void _modalBottomSheetMenuOptions(context) {
    _botomSheet(
      context,
      children: [
        reusableTitleTwo('Type'),
        reusableCheckBoxes('Live Classes'),
        reusableCheckBoxes('Course'),
        reusableCheckBoxes('Text course'),
        reusableTitleTwo('Options'),
        reusableToggleChoices('UpComing Live Classes'),
        reusableToggleChoices('Free Courses'),
        reusableToggleChoices('Discounted Courses'),
        reusableToggleChoices('Downloadable Content'),
        reusableTitleTwo('Sort By'),
        reusableRadioOptions('All'),
        reusableRadioOptions('Newest'),
        reusableRadioOptions('Highest Prices'),
        reusableRadioOptions('Lowest Prices'),
        reusableRadioOptions('Best Sellers'),
        const SizedBox(
          height: 10,
        ),
        const MyElevatedButton(label: 'Apply Options'),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Future<dynamic> _botomSheet(context,
      {List<Widget> children = const <Widget>[]}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        )),
        builder: (builder) {
          return DraggableScrollableSheet(
            initialChildSize: 0.75,
            minChildSize: 0.2,
            maxChildSize: 0.75,
            expand: false,
            builder: (context, s) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                    physics: const BouncingScrollPhysics(),
                    controller: s,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    children: children),
              );
            },
          );
        });
  }

  Widget reusableCheckBoxes(String type) {
    return SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type,
                style: TextStyle(
                    color: ColorConst.buttonColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = true;
                    });
                  }) //
            ],
          ),
        ));
  }

  Widget reusableToggleChoices(String category) {
    return SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: TextStyle(
                    color: ColorConst.buttonColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              CupertinoSwitch(
                  trackColor: Colors.grey,
                  activeColor: ColorConst.buttonColor,
                  value: false,
                  onChanged: (value) {})
            ],
          ),
        ));
  }

  Widget reusableRadioOptions(String type) {
    return SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type,
                style: TextStyle(
                    color: ColorConst.buttonColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              Radio(
                  value: 1,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = 1;
                      value = _value;
                    });
                  })
            ],
          ),
        ));
  }
}

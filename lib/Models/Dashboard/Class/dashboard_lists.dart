import 'package:flutter/material.dart';

import '../../../Utils/Constants/constants_colors.dart';
import 'dashboard_classes.dart';

List<CommonCard> commonCard = [
  CommonCard(
      iconData: Icons.videocam_sharp,
      number: '9',
      courses: "Upcoming Live Sessions",
      color: Colors.green),
  CommonCard(
      iconData: Icons.mail,
      number: '1',
      courses: "Support Messages",
      color: Colors.red),
  CommonCard(
      iconData: Icons.account_balance_wallet,
      number: '0',
      courses: "Meetings",
      color: Colors.blue),
  CommonCard(
      iconData: Icons.chat_bubble,
      number: '2',
      courses: "Comments",
      color: Colors.green),
];
List<CarouselBalance> carouselBalance = [
  CarouselBalance(
      title: '₹ 5000000000',
      subtitle: 'Account balance',
      iconData: Icons.account_balance_wallet,
      colors: ColorConst.primaryColor),
  CarouselBalance(
      title: '4260',
      subtitle: 'Reward Points',
      iconData: Icons.card_giftcard,
      colors: Colors.brown)
];

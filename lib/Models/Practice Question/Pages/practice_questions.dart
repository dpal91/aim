import 'package:flutter/material.dart';

import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Wdgets/appbar.dart';
import '../../Practice%20Question/Class/practice_classes.dart';
import '../../Practice%20Question/Class/practice_lists.dart';

class PracticeQuestionsPage extends StatelessWidget {
  const PracticeQuestionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Practice Questions'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (BuildContext context, index) {
            return ExpansionPanelList.radio(
              children: [
                ...expandedTileTwo
                    .map((tile) => ExpansionPanelRadio(
                        value: tile.title,
                        headerBuilder: (context, isExpanded) => InkWell(
                            onTap: () {}, child: buildAdvanceTile(tile)),
                        body: Column(
                          children: [
                            ...tile.tiles.map(buildAdvanceTile).toList(),
                          ],
                        )))
                    .toList(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildAdvanceTile(ExpndAdvancedTile tile) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        color: Colors.grey.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 10, bottom: 10),
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: ColorConst.buttonColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Icon(
                        tile.iconData,
                        color: Colors.white,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tile.title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      tile.subtitle,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 9,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

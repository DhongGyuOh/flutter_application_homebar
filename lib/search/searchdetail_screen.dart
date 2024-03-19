import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_homebar/constants/device_size.dart';
import 'package:flutter_application_homebar/models/cocktail.dart';
import 'package:flutter_application_homebar/models/whisky.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchDetailScreen extends ConsumerStatefulWidget {
  static String routeName = "searchdetails";
  static String routeURL = "searchdetails";
  final Cocktail cocktail;
  const SearchDetailScreen({super.key, required this.cocktail});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchDetailScreenState();
}

class _SearchDetailScreenState extends ConsumerState<SearchDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final cocktailInfo = widget.cocktail;
    return Scaffold(
      body: Hero(
        tag: cocktailInfo,
        child: Material(
          type: MaterialType.transparency,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: DeviceSize.deviceHeight / 2,
                      width: DeviceSize.deviceWidth,
                      child: Image.network(
                        "https://source.unsplash.com/featured/?{cocktail},{wisky}",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cocktailInfo.name,
                              style: const TextStyle(fontSize: 40),
                            ),
                            Text(
                              cocktailInfo.proof.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(cocktailInfo.detail),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 10),
                  child: Text(
                    "Whisky List",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: DeviceSize.deviceWidth,
                  height: DeviceSize.deviceHeight / 6,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemCount: cocktailInfo.whisky.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final whiskyList = cocktailInfo.whisky;
                      final whisky = whiskyList.elementAt(index);
                      final whiskyName = whisky.keys.first.name;
                      return Container(
                        padding: const EdgeInsets.all(10),
                        width: 100,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          color: Colors.pink,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://source.unsplash.com/featured/?{bottle'$index'}{whisky'$index'}",
                            ),
                          ),
                        ),
                        child: Text(whiskyName),
                      );
                    },
                    separatorBuilder: (context, index) => Container(
                      width: 5,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    "Ingredient List",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: DeviceSize.deviceWidth,
                  height: DeviceSize.deviceHeight / 6,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemCount: cocktailInfo.ingredient.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final whiskyList = cocktailInfo.ingredient;
                      final ingredients = whiskyList.elementAt(index);
                      final ingredientName = ingredients.keys.first.name;
                      return Container(
                        padding: const EdgeInsets.all(10),
                        width: 100,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://source.unsplash.com/featured/?{ingredient},{recipe'$index'}",
                            ),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          color: Colors.orange,
                        ),
                        child: Text(ingredientName),
                      );
                    },
                    separatorBuilder: (context, index) => Container(width: 5),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

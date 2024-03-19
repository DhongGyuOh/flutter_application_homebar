import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_homebar/constants/device_size.dart';
import 'package:flutter_application_homebar/search/search_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CocktailDetailScreen extends ConsumerStatefulWidget {
  static String routeName = "searchdetails";
  static String routeURL = "searchdetails";
  final String cocktailname;
  const CocktailDetailScreen({super.key, required this.cocktailname});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchDetailScreenState();
}

class _SearchDetailScreenState extends ConsumerState<CocktailDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final cocktailInfo =
        ref.read(searchProvider.notifier).getCocktail(widget.cocktailname)!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Cocktail Recipe"),
      ),
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
                    Container(
                      color: Colors.black.withOpacity(0.3),
                      width: DeviceSize.deviceWidth,
                      height: DeviceSize.deviceHeight / 2,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              cocktailInfo.name,
                              style: const TextStyle(fontSize: 40),
                            ),
                            Text(
                              cocktailInfo.proof.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 80, left: 30, right: 30),
                              child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15))),
                                  padding: const EdgeInsets.all(10),
                                  child: Text(cocktailInfo.detail)),
                            ),
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

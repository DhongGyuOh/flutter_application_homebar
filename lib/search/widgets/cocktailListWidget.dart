import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_homebar/models/cocktail.dart';
import 'package:flutter_application_homebar/search/search_vm.dart';
import 'package:flutter_application_homebar/search/widgets/cocktailsDetailScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CocktailListWidget extends ConsumerStatefulWidget {
  const CocktailListWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CocktailListWidgetState();
}

class _CocktailListWidgetState extends ConsumerState<CocktailListWidget> {
  late Future<List<CocktailsInfo>> cocktailList =
      ref.read(searchProvider.notifier).getCocktailList();

  void _onTap(int cocktailId) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CocktailsDetailScreen(cocktailId: cocktailId),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink,
        body: Center(
          child: FutureBuilder(
            future: cocktailList,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return GestureDetector(
                    onTap: () {
                      ref.read(searchProvider.notifier).getCocktailList();
                    },
                    child: const CircularProgressIndicator());
              } else {
                return GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 9 / 16,
                      crossAxisSpacing: 5,
                      mainAxisExtent: 250,
                      mainAxisSpacing: 0),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _onTap(snapshot.data![index].cocktailId),
                      child: Container(
                        height: 350,
                        width: 200,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: Stack(
                          children: [
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Image.network(
                                  fit: BoxFit.fill,
                                  "https://loremflickr.com/200/35${index % 9}/whisky,glass"),
                            ),
                            Positioned.fill(
                              top: 200,
                              right: 35,
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data![index].name,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.5)),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}

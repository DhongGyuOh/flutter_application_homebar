import 'package:flutter/material.dart';
import 'package:flutter_application_homebar/models/cocktail.dart';
import 'package:flutter_application_homebar/search/search_view_model.dart';
import 'package:flutter_application_homebar/search/searchdetail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static String routeName = "search";
  static String routeURL = "/search";
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  void _onTap(Cocktail cocktail) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SearchDetailScreen(cocktail: cocktail),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final cocktails = ref.watch(searchProvider).value!;
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Center(
          child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1 / 1.5,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemCount: cocktails.length,
        itemBuilder: (context, index) {
          for (int i = 0; i < cocktails.length;) {
            return GestureDetector(
              onTap: () => _onTap(cocktails[index]),
              child: Hero(
                tag: cocktails[index],
                child: Material(
                  type: MaterialType.transparency,
                  child: Stack(children: [
                    Opacity(
                      opacity: 0.8,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(13))),
                        child: Image.network(
                          "https://source.unsplash.com/featured/?{cocktail'$index'},{wisky'$index'}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                        top: 180,
                        left: 5,
                        child: Text(
                          cocktails[index].name,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ))
                  ]),
                ),
              ),
            );
          }
          return null;
        },
      )),
    );
  }
}

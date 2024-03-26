import 'package:flutter/material.dart';
import 'package:flutter_application_homebar/models/cocktail.dart';
import 'package:flutter_application_homebar/search/cocktaildetail_screen.dart';
import 'package:flutter_application_homebar/search/search_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static String routeName = "search";
  static String routeURL = "/search";
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  void _onTap(BuildContext context, String cocktailName) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CocktailDetailScreen(cocktailname: cocktailName),
    ));
  }

  late List<Cocktail> cocktails = [];
  late List<Cocktail> filterdCocktails = [];
  final TextEditingController _textEditingController = TextEditingController();

  void _onChanged(String text) {
    setState(() {
      filterdCocktails = cocktails
          .where((cocktail) =>
              cocktail.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  void _onBodyTap() {
    FocusScope.of(context).unfocus();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    filterdCocktails = List.from(cocktails);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    cocktails = ref.watch(searchProvider).value!;
    _textEditingController.text == ''
        ? filterdCocktails = cocktails
        : filterdCocktails;
    return GestureDetector(
      onTap: _onBodyTap,
      child: Scaffold(
        backgroundColor: Colors.pink,
        appBar: AppBar(
          title: TextField(
            onChanged: _onChanged,
            controller: _textEditingController,
            decoration: const InputDecoration(hintText: "Search Cocktail"),
          ),
        ),
        body: Center(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1 / 1.5,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: filterdCocktails.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _onTap(context, filterdCocktails[index].name),
                    child: Hero(
                      tag: filterdCocktails[index],
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
                                filterdCocktails[index].name,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ))
                        ]),
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}

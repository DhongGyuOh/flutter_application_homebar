import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_homebar/models/cocktail.dart';
import 'package:flutter_application_homebar/models/ingredient.dart';
import 'package:flutter_application_homebar/models/whisky.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final searchProvider = AsyncNotifierProvider<SearchViewModel, List<Cocktail>>(
    () => SearchViewModel());

class SearchViewModel extends AsyncNotifier<List<Cocktail>> {
  final List<Cocktail> _listCocktail = [
    Cocktail(
        name: "Midori Shour",
        detail:
            "This is a refreshing cocktail made with Midori, tonic, lemon juice, and ice. It has a sweet and tangy flavor profile with a hint of citrus.",
        proof: 80.00,
        whisky: [
          {
            Whisky(
                name: "Midori",
                proof: 80.00,
                detail:
                    "Midori is a melon-flavored liqueur with a vibrant green color."): 20
          },
        ],
        ingredient: [
          {
            Ingredients(
                name: "Tonic",
                detail:
                    "Tonic water adds fizz and a slight bitterness to the cocktail."): 80
          },
          {
            Ingredients(
                    name: "Lemon Juice",
                    detail:
                        "Freshly squeezed lemon juice provides tartness and acidity."):
                10.00
          },
          {
            Ingredients(
                name: "Ice",
                detail: "Ice cubes are added to chill the cocktail."): 50.00
          },
        ]),
    Cocktail(
        name: "Old Fashioned",
        detail:
            "This classic cocktail features bourbon, syrup, Angostura bitters, and an orange peel. It has a rich and smooth taste with a hint of sweetness.",
        proof: 80.00,
        whisky: [
          {
            Whisky(
                name: "Bourbon",
                proof: 80.00,
                detail:
                    "Bourbon is a type of American whiskey known for its distinctive sweet flavor profile."): 80
          },
          {
            Whisky(
                name: "Angostura bitters",
                proof: 80.00,
                detail:
                    "Angostura bitters are a concentrated flavoring agent made from a variety of herbs and spices."): 20
          },
        ],
        ingredient: [
          {
            Ingredients(
                    name: "Syrup",
                    detail:
                        "Simple syrup is used to add sweetness to the cocktail."):
                1.00
          },
          {
            Ingredients(
                    name: "Orange Peel",
                    detail:
                        "A twist of orange peel is used as a garnish, adding citrus oils to the drink."):
                1.00
          },
          {
            Ingredients(
                name: "Ice",
                detail: "Ice cubes are added to chill the cocktail."): 50.00
          },
        ]),
    Cocktail(
        name: "Manhattan",
        detail:
            "The Manhattan is a classic cocktail made with rye whiskey, sweet vermouth, and Angostura bitters. It has a bold and complex flavor profile with hints of spice and sweetness.",
        proof: 80.00,
        whisky: [
          {
            Whisky(
                name: "Rye Whiskey",
                proof: 80.00,
                detail:
                    "Rye whiskey has a spicy and robust flavor profile, making it a perfect base for cocktails."): 80
          },
          {
            Whisky(
                name: "Sweet Vermouth",
                proof: 80.00,
                detail:
                    "Sweet vermouth is a fortified wine with a sweet and herbal flavor."): 20
          },
          {
            Whisky(
                name: "Angostura bitters",
                proof: 80.00,
                detail:
                    "Angostura bitters add depth and complexity to the cocktail with their aromatic and bitter flavors."): 20
          },
        ],
        ingredient: [
          {
            Ingredients(
                    name: "Cherry",
                    detail:
                        "A maraschino cherry is used as a garnish, adding a pop of color and sweetness to the drink."):
                1.00
          },
          {
            Ingredients(
                name: "Ice",
                detail: "Ice cubes are added to chill the cocktail."): 50.00
          },
        ]),
    Cocktail(
        name: "Whiskey Collins",
        detail:
            "The Whiskey Collins is a refreshing cocktail made with bourbon, Midori, lemon juice, syrup, tonic, and ice. It has a balanced flavor profile with notes of citrus and sweetness.",
        proof: 80.00,
        whisky: [
          {
            Whisky(
                name: "Bourbon ",
                proof: 80.00,
                detail:
                    "Bourbon provides a rich and smooth base for the cocktail."): 80
          },
          {
            Whisky(
                name: "Midori",
                proof: 80.00,
                detail:
                    "Midori adds a unique melon flavor and vibrant green color to the cocktail."): 20
          },
        ],
        ingredient: [
          {
            Ingredients(
                    name: "Lemon Juice",
                    detail:
                        "Freshly squeezed lemon juice provides tartness and acidity."):
                10.00
          },
          {
            Ingredients(
                    name: "Syrup",
                    detail:
                        "Simple syrup is used to add sweetness to the cocktail."):
                1.00
          },
          {
            Ingredients(
                    name: "Tonic",
                    detail:
                        "Tonic water adds fizz and a slight bitterness to the cocktail."):
                1.00
          },
          {
            Ingredients(
                name: "Ice",
                detail: "Ice cubes are added to chill the cocktail."): 50.00
          },
        ]),
    Cocktail(
        name: "Scotch Highball",
        detail:
            "The Scotch Highball is a simple yet refreshing cocktail made with Scotch whiskey, tonic, lemon wedge, and ice. It has a crisp and slightly smoky flavor profile.",
        proof: 80.00,
        whisky: [
          {
            Whisky(
                name: "Scotch whiskey",
                proof: 80.00,
                detail:
                    "Scotch whiskey is a type of whiskey made in Scotland, known for its distinctive smoky and peaty flavor profile."): 80
          },
          {
            Whisky(
                name: "Tonic",
                proof: 80.00,
                detail:
                    "Tonic water adds fizz and a slight bitterness to the cocktail."): 20
          },
        ],
        ingredient: [
          {
            Ingredients(
                    name: "Lemon Wedge",
                    detail:
                        "A lemon wedge is used as a garnish, adding a citrusy aroma to the drink."):
                1.00
          },
          {
            Ingredients(
                name: "Ice",
                detail: "Ice cubes are added to chill the cocktail."): 50.00
          },
        ]),
  ];

  final String baseUrl = "http://172.17.7.232:8080/cocktails";

  @override
  FutureOr<List<Cocktail>> build() {
    return _listCocktail;
  }

  Cocktail? getCocktail(String cocktailName) {
    // 주어진 칵테일 이름과 일치하는 칵테일을 찾습니다.
    for (Cocktail cocktail in _listCocktail) {
      if (cocktail.name == cocktailName) {
        return cocktail;
      }
    }
    return null;
  }

  Future<List<CocktailsInfo>> getCocktailList() async {
    Response response = await get(Uri.parse('$baseUrl/all'));
    if (response.statusCode == 200) {
      final List cocktails = jsonDecode(utf8.decode(response.bodyBytes));
      return cocktails.map((e) => CocktailsInfo.fromJson(e)).toList();
    } else {
      throw Exception();
    }
  }
}

import 'dart:async';
import 'package:flutter_application_homebar/models/cocktail.dart';
import 'package:flutter_application_homebar/models/ingredient.dart';
import 'package:flutter_application_homebar/models/whisky.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider = AsyncNotifierProvider<SearchViewModel, List<Cocktail>>(
    () => SearchViewModel());

class SearchViewModel extends AsyncNotifier<List<Cocktail>> {
  final List<Cocktail> _listCocktail = [
    Cocktail(
        name: "Midori Shour",
        detail: "Cocktail Detail",
        proof: 80.00,
        whisky: [
          {Whisky(name: "Midori", proof: 80.00, detail: "Whisky Detail"): 20},
        ],
        ingredient: [
          {Ingredient(name: "Tonic", detail: "Whisky Detail"): 80},
          {Ingredient(name: "Lemon Juice", detail: "Ingredient Detail"): 10.00},
          {Ingredient(name: "Ice", detail: "Ingredient Detail"): 50.00},
        ]),
    Cocktail(
        name: "Old Fashioned",
        detail: "Cocktail Detail",
        proof: 80.00,
        whisky: [
          {Whisky(name: "Bourbon", proof: 80.00, detail: "Whisky Detail"): 80},
          {
            Whisky(
                name: "Angostura bitters",
                proof: 80.00,
                detail: "Whisky Detail"): 20
          },
        ],
        ingredient: [
          {Ingredient(name: "Syrup", detail: "Ingredient Detail"): 1.00},
          {Ingredient(name: "Orange Peel", detail: "Ingredient Detail"): 1.00},
          {Ingredient(name: "Ice", detail: "Ingredient Detail"): 50.00},
        ]),
    Cocktail(
        name: "Manhattan",
        detail: "Cocktail Detail",
        proof: 80.00,
        whisky: [
          {
            Whisky(name: "Rye Whiskey", proof: 80.00, detail: "Whisky Detail"):
                80
          },
          {
            Whisky(
                name: "Sweet Vermouth",
                proof: 80.00,
                detail: "Whisky Detail"): 20
          },
          {
            Whisky(
                name: "Angostura bitters",
                proof: 80.00,
                detail: "Whisky Detail"): 20
          },
        ],
        ingredient: [
          {Ingredient(name: "Cherry", detail: "Ingredient Detail"): 1.00},
          {Ingredient(name: "Ice", detail: "Ingredient Detail"): 50.00},
        ]),
    Cocktail(
        name: "Whiskey Collins",
        detail: "Cocktail Detail",
        proof: 80.00,
        whisky: [
          {Whisky(name: "Bourbon ", proof: 80.00, detail: "Whisky Detail"): 80},
          {Whisky(name: "Midori", proof: 80.00, detail: "Whisky Detail"): 20},
        ],
        ingredient: [
          {Ingredient(name: "Lemon Juice", detail: "Ingredient Detail"): 10.00},
          {Ingredient(name: "Syrup", detail: "Ingredient Detail"): 1.00},
          {Ingredient(name: "Tonic", detail: "Ingredient Detail"): 1.00},
          {Ingredient(name: "Ice", detail: "Ingredient Detail"): 50.00},
        ]),
    Cocktail(
        name: "Scotch Highball",
        detail: "Cocktail Detail",
        proof: 80.00,
        whisky: [
          {
            Whisky(
                name: "Scotch whiskey",
                proof: 80.00,
                detail: "Whisky Detail"): 80
          },
          {Whisky(name: "Tonic", proof: 80.00, detail: "Whisky Detail"): 20},
        ],
        ingredient: [
          {Ingredient(name: "Lemon Wedge", detail: "Ingredient Detail"): 1.00},
          {Ingredient(name: "Ice", detail: "Ingredient Detail"): 50.00},
        ]),
  ];
  @override
  FutureOr<List<Cocktail>> build() {
    return _listCocktail;
  }
}

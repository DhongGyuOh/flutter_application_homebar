import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_homebar/home/screens/ingredients_vm.dart';
import 'package:flutter_application_homebar/models/ingredient.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IngredientScreen extends ConsumerStatefulWidget {
  static String routeName = "ingredient";
  static String routeURL = "/ingredient";
  const IngredientScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IngredientScreenState();
}

class _IngredientScreenState extends ConsumerState<IngredientScreen> {
  late Future<List<Ingredient>> ingredients;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController detailTextEditingController = TextEditingController();

  @override
  void initState() {
    ingredients = ref.read(ingredientProvider.notifier).getIngredientList();
    super.initState();
  }

  void _onAddIngredient(BuildContext context) {
    ingBottomSheet(context, 0);
  }

  Future<dynamic> ingBottomSheet(BuildContext context, int? id) async {
    if (id != 0) {
      Future<Ingredient> selectedIng =
          ref.read(ingredientProvider.notifier).getIngredient(id);
      Ingredient ing = await selectedIng;
      nameTextEditingController.text = ing.name;
      detailTextEditingController.text = ing.detail;
    } else {
      nameTextEditingController.text = "";
      detailTextEditingController.text = "";
    }

    if (!context.mounted) return;
    return showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _globalKey,
                child: Container(
                  height: 500,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.pink),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: "삭자재명:",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          cursorColor: Colors.pink,
                          controller: nameTextEditingController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.lime)),
                              enabledBorder: OutlineInputBorder(),
                              hintText: "식자재 설명:",
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.normal)),
                          controller: detailTextEditingController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CupertinoButton(
                            color: Colors.lime,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 155),
                            onPressed: _onTapInsert,
                            child: const Text("입력하기"))
                      ],
                    ),
                  ),
                )));
      },
    );
  }

  void _onTapInsert() {
    String ingredientName = nameTextEditingController.value.text;
    String ingredientDetail = detailTextEditingController.value.text;
    Ingredient ingredient = Ingredient(
        //ingredientId: 21,
        categoryId: 3,
        name: ingredientName,
        detail: ingredientDetail,
        state: '1',
        createdAt: DateTime.now());
    ref.read(ingredientProvider.notifier).upsertIngredient(ingredient);
    setState(() {});
  }

  void _onTapListTile(int? ingredientId) {
    ingBottomSheet(context, ingredientId);
  }

  void _longPressListTile(int? ingredientId) {
    ref.read(ingredientProvider.notifier).deleteIngredient(ingredientId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ingredients,
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                appBar: AppBar(
                  title: const Text("재료들"),
                  centerTitle: true,
                  actions: [
                    IconButton(
                        onPressed: () => _onAddIngredient(context),
                        icon: const Icon(
                          Icons.add_box_rounded,
                          size: 35,
                        ))
                  ],
                ),
                body: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final ingredient = snapshot.data![index];
                    return GestureDetector(
                      onTap: () => _onTapListTile(ingredient.ingredientId),
                      onLongPress: () =>
                          _longPressListTile(ingredient.ingredientId),
                      child: ListTile(
                        title: Text(
                            '${ingredient.ingredientId}.${ingredient.name}'),
                        subtitle: Text(ingredient.detail),
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_homebar/constants/device_size.dart';
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
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _detailEditingController =
      TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  void _onAddPressed() {
    _nameEditingController.text = "";
    _detailEditingController.text = "";
    ingredientBottomSheet(null);
  }

  Future<dynamic> ingredientBottomSheet(int? id) {
    return showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return Container(
          width: DeviceSize.deviceWidth / 1.1,
          height: DeviceSize.deviceHeight / 1.1,
          decoration: const BoxDecoration(color: Colors.pink),
          child: Form(
              key: _globalKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameEditingController,
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "빈칸입니다.";
                        } else {
                          return null;
                        }
                      },
                      style: const TextStyle(fontSize: 24),
                      decoration: const InputDecoration(
                          hintText: "재료명을 입력해주세요.", border: InputBorder.none),
                    ),
                    TextFormField(
                      controller: _detailEditingController,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "빈칸입니다.";
                        } else {
                          return null;
                        }
                      },
                      maxLines: 5,
                      decoration: const InputDecoration(
                          hintText: "설명을 작성해주세요.",
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CupertinoButton(
                        color: Colors.orange,
                        onPressed: () => _onTapUpsert(id),
                        child: Text(
                          id == null ? "Insert" : "Update",
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white),
                        ))
                  ],
                ),
              )),
        );
      },
    );
  }

  void _onTapDelete(int? ingredientId) {
    ref.read(ingredientProvider.notifier).deleteIngredient(ingredientId);
    setState(() {});
  }

  void _onTapUpsert(int? id) {
    if (_globalKey.currentState!.validate()) {
      Ingredient ingredient = Ingredient(
          ingredientId: id,
          categoryId: 3,
          name: _nameEditingController.text,
          detail: _detailEditingController.text,
          state: '1',
          createdAt: DateTime.now());
      ref.read(ingredientProvider.notifier).upsertIngredient(ingredient);
      Navigator.pop(context);
    }
  }

  void _onTapFindById(int? ingredientId) async {
    Ingredient selectedIng =
        await ref.read(ingredientProvider.notifier).getIngredient(ingredientId);
    _nameEditingController.text = selectedIng.name;
    _detailEditingController.text = selectedIng.detail;
    ingredientBottomSheet(selectedIng.ingredientId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("재료 리스트"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box, size: 40),
            onPressed: _onAddPressed,
          )
        ],
      ),
      body: Center(
        child: Consumer(
          builder: (context, watch, child) {
            final asyncValue = ref.watch(ingredientProvider);
            return asyncValue.when(
              data: (data) {
                // 데이터가 있는 경우 ListView.separated를 반환
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final ingredient = data[index];
                    return GestureDetector(
                      onTap: () => _onTapFindById(ingredient.ingredientId),
                      onLongPress: () => _onTapDelete(ingredient.ingredientId),
                      child: ListTile(
                        title: Text(
                            '${ingredient.ingredientId}.${ingredient.name}'),
                        subtitle: Text(ingredient.detail),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: data.length,
                );
              },
              error: (error, stackTrace) {
                // 에러가 있는 경우 에러를 보여줌
                return Text(error.toString());
              },
              loading: () {
                // 로딩 중일 때 CircularProgressIndicator를 반환
                return const CircularProgressIndicator();
              },
            );
          },
        ),
      ),
    );
  }
}

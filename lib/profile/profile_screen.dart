import 'package:flutter/material.dart';
import 'package:flutter_application_homebar/auth/login_screen.dart';
import 'package:flutter_application_homebar/auth/login_vm.dart';
import 'package:flutter_application_homebar/search/search_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static String routeName = "profile";
  static String routeURL = "/profile";
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final tabs = ["Profile, Settings"];
  final Map<String, IconData> settings = {
    "Profile Edit": Icons.edit,
    "Your Favorites": Icons.favorite,
    "Recent HomeBar": Icons.local_bar,
    "Share": Icons.share,
    "Info": Icons.info_outline_rounded,
    "Log Out": Icons.logout_sharp
  };
  void _onTapSettings(String settingsName) {
    switch (settingsName) {
      case "Log Out":
        ref.read(loginProvider.notifier).userLogout();
        context.goNamed(LoginScreen.routeName);
        break;

      case "Your Favorites":
        ref.read(searchProvider.notifier).getCocktailList();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  centerTitle: true,
                  expandedHeight: 200,
                  collapsedHeight: 60,
                  title: const Text("Profile"),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      "https://source.unsplash.com/featured/?{music},{instruments}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: CustomDelegate(),
                )
              ];
            },
            body: TabBarView(children: [
              GridView.builder(
                itemCount: 13,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1 / 1.5,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5),
                scrollDirection: Axis.vertical,
                clipBehavior: Clip.hardEdge,
                addSemanticIndexes: true,
                itemBuilder: (context, index) {
                  for (int i = 0; i < 13;) {
                    return Image.network(
                      "https://source.unsplash.com/featured/?{music'$index'},{guitar'$index'}",
                      fit: BoxFit.cover,
                    );
                  }
                  return null;
                },
              ),
              ListView.builder(
                itemCount: settings.length,
                itemBuilder: (context, index) {
                  final settingsName = settings.keys.elementAt(index);
                  final settingsIcon = settings[settingsName];
                  return GestureDetector(
                    onTap: () => _onTapSettings(settingsName),
                    child: ListTile(
                      title: Text(settingsName),
                      leading: Icon(settingsIcon),
                    ),
                  );
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class CustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: const BoxDecoration(color: Colors.lime),
      child: const TabBar(tabs: [
        Icon(
          Icons.person,
          color: Colors.pink,
          size: 40,
        ),
        Icon(
          Icons.settings,
          color: Colors.pink,
          size: 40,
        ),
      ]),
    );
  }

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:task1/constants/theme/theme.dart';
import 'package:badges/badges.dart' as badges;
import 'package:task1/cubits/addCart/add_cart_cubit.dart';

import 'package:task1/screens/cart.dart';
import 'package:task1/screens/fav_product.dart';
import 'package:task1/widgets/best_selling_product.dart';
import 'package:task1/widgets/explore_items.dart';

List<String> products = [
  "Minimal Chair",
  "Vintage Chair",
  "Elegant Chair",
];

class Home extends StatefulWidget {
  Home({super.key});
  static const String routeName = "/";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.sort,
                    size: 35,
                    color: MyThemeData.primaryColor,
                  ),
                  Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                        color: MyThemeData.second,
                        borderRadius: BorderRadius.circular(15)),
                    child: InkWell(
                        onTap: () {
                          Get.toNamed(FavoriteProduct.routeName);
                        },
                        child: Icon(Icons.favorite,
                            color: Colors.white, size: 22)),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 250,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 5,
                              spreadRadius: 3,
                              offset: Offset(0, 3))
                        ]),
                    child: TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {
                                showSearch(
                                    context: context, delegate: ShowSearch());
                              },
                              child: Icon(Icons.search,
                                  color: MyThemeData.primaryColor, size: 30),
                            ),
                            hintText: "Search",
                            border: InputBorder.none)),
                  ),
                  badges.Badge(
                    badgeContent: Text(
                      "${BlocProvider.of<AddCartCubit>(context).counter}",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                    badgeStyle:
                        badges.BadgeStyle(badgeColor: MyThemeData.second),
                    position: badges.BadgePosition.topEnd(top: -3, end: 2),
                    child: IconButton(
                        onPressed: () {
                          Get.toNamed(
                            Cart.routeName,
                          );
                        },
                        icon: Icon(
                          CupertinoIcons.cart,
                          size: 30,
                          color: MyThemeData.primaryColor,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Explore",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: 10,
              ),

              // widget for explore items
              ExploreItems(),

              SizedBox(
                height: 16,
              ),
              Text(
                "Best Selling",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: 14,
              ),
              // widget for best selling products
              BestSellingProduct(),
            ]),
          ),
        ),
      ),
    );
  }
}

// search delegate
class ShowSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("${query}");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> filterProducts = [];

    if (query.isNotEmpty) {
      filterProducts =
          products.where((element) => element.startsWith(query)).toList();
    }

    return ListView.builder(
      itemCount: filterProducts.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filterProducts[index]),
          onTap: () {
            // Get.toNamed(ItemDetails.routeName);
          },
        );
      },
    );
  }
}

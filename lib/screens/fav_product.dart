import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:task1/constants/app_images/assets.dart';

import 'package:task1/constants/theme/theme.dart';
import 'package:task1/cubits/addCart/add_cart_cubit.dart';
import 'package:task1/cubits/addFavCart/add_fav_product_cubit.dart';
import 'package:task1/screens/home.dart';

class FavoriteProduct extends StatefulWidget {
  const FavoriteProduct({super.key});
  static const String routeName = "/favProduct";

  @override
  State<FavoriteProduct> createState() => _FavoriteProductState();
}

class _FavoriteProductState extends State<FavoriteProduct> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AddFavCartCubit, AddFavCartState>(
          builder: (context, state) {
        if (state is AddFavCartSuccess &&
            BlocProvider.of<AddFavCartCubit>(context).favCart.isNotEmpty) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: MyThemeData.primaryColor,
                          ),
                          onPressed: () {
                            Get.toNamed(Home.routeName);
                          },
                        ),
                        Text(
                          "Favorite Products",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        badges.Badge(
                          badgeContent: Text(
                            "${BlocProvider.of<AddCartCubit>(context).counter}",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                          badgeStyle:
                              badges.BadgeStyle(badgeColor: MyThemeData.second),
                          position:
                              badges.BadgePosition.topEnd(top: -8, end: -3),
                          child: Icon(
                            CupertinoIcons.cart,
                            size: 30,
                            color: MyThemeData.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: Get.width,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: BlocProvider.of<AddFavCartCubit>(context)
                              .favCart
                              .length,
                          itemBuilder: (context, index) {
                            return Column(children: [
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                width: Get.width,
                                height: 120,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 2,
                                          spreadRadius: 2,
                                          offset: Offset(0, 2)),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Container(
                                        width: 120,
                                        height: 120,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                                "${BlocProvider.of<AddFavCartCubit>(context).favCart[index].image}",
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    Container(
                                      width: Get.width - 208,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "${BlocProvider.of<AddFavCartCubit>(context).favCart[index].name}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          Text(
                                            "${BlocProvider.of<AddFavCartCubit>(context).favCart[index].description1}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$${BlocProvider.of<AddFavCartCubit>(context).favCart[index].price}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color:
                                                            MyThemeData.second),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            title: Text(
                                                                "Delete Product?"),
                                                            content: Text(
                                                                "Are you sure that you want delete this product?"),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      "No")),
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    BlocProvider.of<AddFavCartCubit>(
                                                                            context)
                                                                        .removeProduct(
                                                                            index);
                                                                    setState(
                                                                        () {});
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      "Yes")),
                                                            ],
                                                          );
                                                        });
                                                  },
                                                  child: Icon(Icons.delete,
                                                      color:
                                                          MyThemeData.second))
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            ]);
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Container(
              width: Get.width,
              height: Get.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("${Assets.imagesEmpty}"),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: Get.width,
                    child: Text(
                      "You don't have any favorite products yet",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black, fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Home.routeName);
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                          color: MyThemeData.primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text("Shop Now",
                            style:
                                TextStyle(fontSize: 22, color: Colors.white)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}

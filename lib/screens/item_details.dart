import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:task1/constants/models/models.dart';
import 'package:task1/constants/theme/theme.dart';
import 'package:badges/badges.dart' as badges;
import 'package:task1/cubits/addCart/add_cart_cubit.dart';
import 'package:task1/screens/cart.dart';
import 'package:task1/screens/home.dart';

class ItemDetails extends StatelessWidget {
  ItemDetails({super.key});
  static const String routeName = "/itemDetails";
  String? image = Get.arguments['image'];
  String? name = Get.arguments['name'];
  double? price = Get.arguments['price'];
  String? description2 = Get.arguments['description2'];
  bool? isChecked = Get.arguments['isChecked'];
  int? quantity = Get.arguments['quantity'];
  List<Color> clrs = [
    MyThemeData.second,
    Color(0xFFb9bace),
    MyThemeData.primaryColor,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                ),
                child: Container(
                  width: Get.width,
                  height: Get.height / 2,
                  child: Image.asset(
                    "${image}",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
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
                      "Product",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    badges.Badge(
                      badgeContent: Text(
                        "${BlocProvider.of<AddCartCubit>(context).counter}",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      badgeStyle:
                          badges.BadgeStyle(badgeColor: MyThemeData.second),
                      position: badges.BadgePosition.topEnd(top: 5, end: 5),
                      child: IconButton(
                          onPressed: () {
                            Get.toNamed(Cart.routeName);
                          },
                          icon: Icon(
                            CupertinoIcons.cart,
                            size: 30,
                            color: MyThemeData.primaryColor,
                          )),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 310,
                top: 340,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                            spreadRadius: 3,
                            offset: Offset(0, 3))
                      ]),
                  child: Center(
                      child: Icon(Icons.favorite,
                          color: MyThemeData.second, size: 20)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, right: 24, left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${price}",
                  style: TextStyle(fontSize: 28, color: MyThemeData.second),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${name}"),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: 4,
                          minRating: 1,
                          itemSize: 18,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "4.5",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Color option",
                  style: TextStyle(fontSize: 15),
                ),
                Row(
                  children: [
                    for (int i = 0; i < clrs.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                              color: clrs[i],
                              borderRadius: BorderRadius.circular(13)),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Description",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${description2}",
                  style: TextStyle(
                      fontSize: 14, color: Colors.grey, wordSpacing: 1),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                BlocProvider.of<AddCartCubit>(context).addCart(Models(
                    quantity: quantity!,
                    isChecked: isChecked!,
                    description1: "${description2}",
                    image: "${image}",
                    name: "${name}",
                    price: price!,
                    description2: "${description2}"));
                Get.toNamed(
                  Cart.routeName,
                );
              },
              child: Container(
                width: 150,
                height: 65,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(40)),
                    color: MyThemeData.primaryColor),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Add To Cart",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    )
                  ]),
                ),
              ),
            ),
          ),
        ],
      )),
    ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:task1/constants/app_images/assets.dart';
import 'package:task1/constants/theme/theme.dart';
import 'package:task1/cubits/addCart/add_cart_cubit.dart';

import 'package:task1/screens/home.dart';

class Cart extends StatefulWidget {
  Cart({super.key});
  static const String routeName = "/cart";

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  double shipping = 30.0;

  @override
  Widget build(BuildContext context) {
    //increment quantity of product
    void incrementProduct(int index) {
      setState(() {
        BlocProvider.of<AddCartCubit>(context).products[index].quantity++;
      });
    }

    // decrement quantity of product
    void decrementProduct(int index) {
      setState(() {
        if (BlocProvider.of<AddCartCubit>(context).products[index].quantity >
            1) {
          BlocProvider.of<AddCartCubit>(context).products[index].quantity--;
        }
      });
    }

    //calc total price
    double calculateTotalPrice() {
      double sum = 0;

      for (int i = 0;
          i < BlocProvider.of<AddCartCubit>(context).products.length;
          i++) {
        if (BlocProvider.of<AddCartCubit>(context).products[i].isChecked) {
          int quantity =
              BlocProvider.of<AddCartCubit>(context).products[i].quantity;
          double price =
              BlocProvider.of<AddCartCubit>(context).products[i].price;
          sum += quantity * price;
        }
      }

      return sum;
    }

    return SafeArea(child: BlocBuilder<AddCartCubit, AddCartState>(
      builder: (context, state) {
        if (state is AddCartSuccess) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
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
                          "Cart",
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
                  ),
                  SizedBox(
                      width: Get.width,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: BlocProvider.of<AddCartCubit>(context)
                              .products
                              .length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 16),
                              height: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Checkbox(
                                      activeColor: MyThemeData.second,
                                      value:
                                          BlocProvider.of<AddCartCubit>(context)
                                              .products[index]
                                              .isChecked,
                                      onChanged: (bool? val) {
                                        setState(() {
                                          BlocProvider.of<AddCartCubit>(context)
                                              .products[index]
                                              .isChecked = val!;
                                        });
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                blurRadius: 1,
                                                spreadRadius: 1,
                                                offset: Offset(0, 2))
                                          ]),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.asset(
                                            "${BlocProvider.of<AddCartCubit>(context).products[index].image}",
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${BlocProvider.of<AddCartCubit>(context).products[index].name}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "\$${BlocProvider.of<AddCartCubit>(context).products[index].price}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  color: MyThemeData.second,
                                                ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      incrementProduct(index);
                                                    },
                                                    child: Icon(Icons.add,
                                                        size: 20)),
                                                Text(
                                                    "${BlocProvider.of<AddCartCubit>(context).products[index].quantity}"),
                                                InkWell(
                                                    onTap: () {
                                                      decrementProduct(index);
                                                    },
                                                    child: Icon(Icons.remove,
                                                        size: 20)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          })),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: Get.height / 3,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 2,
                      spreadRadius: 5,
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Selected Item",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        "\$${calculateTotalPrice()}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: MyThemeData.second),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Shipping Fee",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        "\$${shipping}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: MyThemeData.second),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "SubTotal",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        "\$${calculateTotalPrice() + shipping}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: MyThemeData.second),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: Get.width,
                      height: 50,
                      decoration: BoxDecoration(
                          color: MyThemeData.primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text("Checkout",
                            style:
                                TextStyle(fontSize: 22, color: Colors.white)),
                      ),
                    ),
                  )
                ],
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
                  Text(
                    "Your Cart is empty",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black),
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
      },
    ));
  }
}

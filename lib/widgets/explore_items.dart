import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:task1/constants/models/models.dart';
import 'package:task1/constants/theme/theme.dart';
import 'package:task1/cubits/addFavCart/add_fav_product_cubit.dart';
import 'package:task1/screens/item_details.dart';

class ExploreItems extends StatelessWidget {
  const ExploreItems({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: Models.items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 2,
                          spreadRadius: 1,
                          offset: Offset(0, 3))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                  onTap: () {
                                    Get.toNamed(ItemDetails.routeName,
                                        arguments: {
                                          "image":
                                              "${Models.items[index].image}",
                                          "name": "${Models.items[index].name}",
                                          "price": Models.items[index].price,
                                          "description2":
                                              "${Models.items[index].description2}",
                                          "isChecked":
                                              Models.items[index].isChecked,
                                          "quantity": 1,
                                        });
                                  },
                                  child: Image.asset(
                                    "${Models.items[index].image}",
                                  ))),
                          Positioned(
                            left: 130,
                            top: 8,
                            child: Container(
                              alignment: Alignment.topRight,
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: MyThemeData.second),
                              child: Center(
                                  child: InkWell(
                                onTap: () {
                                  BlocProvider.of<AddFavCartCubit>(context)
                                      .addFavCart(Models(
                                          quantity:
                                              Models.items[index].quantity,
                                          description1:
                                              Models.items[index].description1,
                                          image: Models.items[index].image,
                                          name: Models.items[index].name,
                                          price: Models.items[index].price,
                                          description2:
                                              Models.items[index].description2,
                                          isChecked:
                                              Models.items[index].isChecked));
                                },
                                child: Icon(Icons.favorite,
                                    color: Colors.white, size: 20),
                              )),
                            ),
                          )
                        ],
                      ),
                      ListTile(
                        title: Text(
                          "${Models.items[index].name}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        subtitle: Text(
                          "${Models.items[index].description1}",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("\$${Models.items[index].price}"),
                            Container(
                              alignment: Alignment.topRight,
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: MyThemeData.primaryColor),
                              child: Center(
                                child: Icon(Icons.add, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

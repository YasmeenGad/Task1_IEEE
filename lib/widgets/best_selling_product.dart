import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/constants/models/models.dart';
import 'package:task1/constants/theme/theme.dart';
import 'package:task1/screens/item_details.dart';

class BestSellingProduct extends StatelessWidget {
  const BestSellingProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Models.items.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
            child: Container(
              width: Get.width,
              height: 120,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: Offset(0, 2)),
              ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset("${Models.items[index].image}",
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Container(
                    width: Get.width - 226,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "${Models.items[index].name}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "${Models.items[index].description1}",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${Models.items[2].price}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: MyThemeData.second),
                            ),
                            Container(
                              height: 30,
                              width: 38,
                              decoration: BoxDecoration(
                                  color: MyThemeData.primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
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
                                  child: Icon(Icons.arrow_forward,
                                      color: Colors.white, size: 22)),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ]),
              ),
            ),
          );
        }));
  }
}

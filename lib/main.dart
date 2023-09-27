import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:task1/constants/theme/theme.dart';
import 'package:task1/cubits/addCart/add_cart_cubit.dart';
import 'package:task1/cubits/addFavCart/add_fav_product_cubit.dart';
import 'package:task1/screens/cart.dart';
import 'package:task1/screens/fav_product.dart';
import 'package:task1/screens/home.dart';
import 'package:task1/screens/item_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddCartCubit>(
          create: (context) => AddCartCubit(),
        ),
        BlocProvider(
          create: (context) => AddFavCartCubit(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Home.routeName,
        getPages: [
          GetPage(name: "${Home.routeName}", page: () => Home()),
          GetPage(name: "${ItemDetails.routeName}", page: () => ItemDetails()),
          GetPage(name: "${Cart.routeName}", page: () => Cart()),
          GetPage(
              name: "${FavoriteProduct.routeName}",
              page: () => FavoriteProduct()),
        ],
        theme: MyThemeData.lightTheme,
      ),
    );
  }
}

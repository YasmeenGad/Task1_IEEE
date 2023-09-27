import 'package:task1/constants/app_images/assets.dart';

class Models {
  String image;
  String name;
  String description1;
  String description2;
  double price;
  int quantity;
  bool isChecked;
  Models({
    required this.quantity,
    required this.description1,
    required this.image,
    required this.name,
    required this.price,
    required this.description2,
    required this.isChecked,
  });
  static List<Models> items = [
    Models(
        quantity: 1,
        isChecked: true,
        description2:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
        description1: "description",
        image: "${Assets.imagesIm7}",
        name: "Minimal Chair",
        price: 115.00),
    Models(
        quantity: 0,
        isChecked: true,
        description2:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
        description1: "description",
        image: "${Assets.imagesIm17}",
        name: "Vintage Chair",
        price: 255.00),
    Models(
        quantity: 0,
        isChecked: true,
        description2:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
        description1: "description",
        image: "${Assets.imagesIm9}",
        name: "Elegant Chair",
        price: 400.00),
  ];
}

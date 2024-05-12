

import 'package:akrem/model/item.dart';

class CategoryModel {
  late int id;
  late String name;
  late String image;

  CategoryModel({required this.id, required this.name, required this.image});
}

/*
Category Data Information
width = 110px
height = 110px
 */
List<CategoryModel> categoryData =[
  CategoryModel(
    id: 1,
    name: 'Vitamins',
    image: "https://images.assetsdelivery.com/compings_v2/topvectors/topvectors1801/topvectors180102531.jpg",
  ),
  CategoryModel(
    id: 2,
    name: 'Skin Care',
    image: "https://cdn-icons-png.freepik.com/512/4192/4192598.png",
  ),
  CategoryModel(
    id: 3,
    name: 'Child care',
    image: "https://cdn-icons-png.flaticon.com/512/4161/4161578.png",
  ),
  CategoryModel(
    id: 4,
    name: 'Hair care',
    image: "https://cdn-icons-png.flaticon.com/512/3299/3299031.png",
  ),
  CategoryModel(
    id: 5,
    name: 'Medical \ndevices',
    image: "https://img.freepik.com/premium-vector/medical-devices-dentists-medical-treatments-medical-supplies-icons_843175-1032.jpg",
  ),
  CategoryModel(
    id: 6,
    name: 'Mother & \nchild',
    image: "https://cdn0.iconfinder.com/data/icons/medical-specialties-2-1/256/Pediatrics-512.png",
  ),
  CategoryModel(
    id: 7,
    name: 'Deals',
    image: "https://cdn-icons-png.flaticon.com/512/545/545623.png",
  ),
  CategoryModel(
    id: 8,
    name: 'Local \nproducts',
    image: "https://cdn-icons-png.flaticon.com/256/439/439461.png",
  ),
];
import 'package:akrem/Screens/customer_screen/shared/appbar.dart';
import 'package:akrem/model/item.dart';
import 'package:flutter/material.dart';
import 'home_view.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  Product product;
  Details({super.key, required this.product});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isShowMore = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Details Screen'),
          actions: const [
            ProductsAndPrice(),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(widget.product.imgPath),
              const SizedBox(
                height: 10,
              ),
              Text(
                '\$  ${widget.product.price}',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'New',
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ),
                  ),
                  const Row(
                    children: [

                    ],
                  ),
                  const Spacer(),
                  const Row(
                    children: [
                      Icon(
                        Icons.edit_location,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 3),
                      Text('AKRAM', style: TextStyle(fontSize: 18)),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Details:',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.start,
                ),
              ),
              Text(
                'Medicine is the science[1] and practice[2] of caring for a patient, managing the diagnosis, prognosis, prevention, treatment, palliation of their injury or disease, and promoting their health. Medicine encompasses a variety of health care practices evolved to maintain and restore health by the prevention and treatment of illness. Contemporary medicine applies biomedical sciences, biomedical research, genetics, and medical technology to diagnose, treat, and prevent injury and disease, typically through pharmaceuticals or surgery, but also through therapies as diverse as psychotherapy, external splints and traction, medical devices, biologics, and ionizing radiation, amongst others.[3]',
                style: const TextStyle(fontSize: 18),
                maxLines: isShowMore ? null : 3,
                overflow: TextOverflow.fade,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isShowMore = !isShowMore;
                  });
                },
                child: Text(isShowMore ? 'Show Less' : 'Show More',
                    style: const TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

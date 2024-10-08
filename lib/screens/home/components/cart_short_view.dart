import 'package:cart_animation/constants.dart';
import 'package:cart_animation/screens/controllers/home_controller.dart';
import 'package:flutter/material.dart';

class CardShortView extends StatelessWidget {
  const CardShortView({super.key, required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Cart", style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(width: defaultPadding),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                controller.cart.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: defaultPadding / 2),
                  child: Hero(
                    tag: controller.cart[index].product!.title! + "_cartTag",
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage(controller.cart[index].product!.image!),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            controller.totalCartItems().toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        )
      ],
    );
  }
}

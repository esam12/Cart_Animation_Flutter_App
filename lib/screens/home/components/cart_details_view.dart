import 'package:cart_animation/constants.dart';
import 'package:cart_animation/screens/controllers/home_controller.dart';
import 'package:cart_animation/screens/home/components/cart_detailsview_card.dart';
import 'package:flutter/material.dart';

class CartDetailsView extends StatelessWidget {
  const CartDetailsView({super.key, required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cart",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          ...List.generate(
            controller.cart.length,
            (index) => CartDetailsViewCard(
              productItem: controller.cart[index],
            ),
          ),
          const SizedBox(height: defaultPadding),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Next - \$30',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

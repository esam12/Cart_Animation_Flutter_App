import 'package:cart_animation/constants.dart';
import 'package:cart_animation/models/product.dart';
import 'package:cart_animation/screens/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'components/header.dart';
import 'components/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController();

    void _onVerticalGesture(DragUpdateDetails details) {
      if (details.primaryDelta! < -7) {
        controller.changeHomeState(HomeState.cart);
      } else if (details.primaryDelta! > 12) {
        controller.changeHomeState(HomeState.normal);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Container(
          color: const Color(0xFFEAEAEA),
          child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return LayoutBuilder(
                    builder: (context, BoxConstraints constraints) {
                  return Stack(
                    children: [
                      AnimatedPositioned(
                        duration: panelTransition,
                        top: controller.homeState == HomeState.normal
                            ? 85
                            : -(constraints.maxHeight - cartBarHeight * 2 - 85),
                        left: 0,
                        right: 0,
                        height: constraints.maxHeight - 85 - cartBarHeight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(defaultPadding * 1.5),
                              bottomRight:
                                  Radius.circular(defaultPadding * 1.5),
                            ),
                          ),
                          child: GridView.builder(
                            itemCount: demo_products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              mainAxisSpacing: defaultPadding,
                              crossAxisSpacing: defaultPadding,
                            ),
                            itemBuilder: (context, index) => ProductCard(
                              product: demo_products[index],
                              press: () {},
                            ),
                          ),
                        ),
                      ),
                      // Card Panel
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: cartBarHeight,
                        child: GestureDetector(
                          onVerticalDragUpdate: _onVerticalGesture,
                          child: Container(
                              // color: Colors.red,
                              ),
                        ),
                      ),
                      // Header
                      AnimatedPositioned(
                        duration: panelTransition,
                        top: controller.homeState == HomeState.normal ? 0 : -85,
                        left: 0,
                        right: 0,
                        height: 85,
                        child: const HomeHeader(),
                      ),
                    ],
                  );
                });
              }),
        ),
      ),
    );
  }
}

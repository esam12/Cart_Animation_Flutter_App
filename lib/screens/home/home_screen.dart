import 'package:cart_animation/constants.dart';
import 'package:cart_animation/models/product.dart';
import 'package:cart_animation/screens/controllers/home_controller.dart';
import 'package:cart_animation/screens/deatils/details_screen.dart';
import 'package:cart_animation/screens/home/components/cart_details_view.dart';
import 'package:cart_animation/screens/home/components/cart_short_view.dart';
import 'package:flutter/material.dart';

import 'components/header.dart';
import 'components/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController();

    void _onVerticalGesture(DragUpdateDetails details) {
      if (details.primaryDelta! < -0.7) {
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
                            itemCount: demoProducts.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              mainAxisSpacing: defaultPadding,
                              crossAxisSpacing: defaultPadding,
                            ),
                            itemBuilder: (context, index) => ProductCard(
                              product: demoProducts[index],
                              press: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      transitionDuration:
                                          const Duration(milliseconds: 500),
                                      reverseTransitionDuration:
                                          const Duration(milliseconds: 500),
                                      pageBuilder: (context, animation,
                                          secodaryAnimation) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: DetailsScreen(
                                            product: demoProducts[index],
                                            onProductAdd: () {
                                              controller.addProductToCart(
                                                  demoProducts[index]);
                                            },
                                          ),
                                        );
                                      }),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      // Card Panel
                      AnimatedPositioned(
                        duration: panelTransition,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: controller.homeState == HomeState.normal
                            ? cartBarHeight
                            : (constraints.maxHeight - cartBarHeight),
                        child: GestureDetector(
                          onVerticalDragUpdate: _onVerticalGesture,
                          child: Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            color: const Color(0xFFEAEAEA),
                            alignment: Alignment.topLeft,
                            child: AnimatedSwitcher(
                              duration: panelTransition,
                              child: controller.homeState == HomeState.normal
                                  ? CardShortView(controller: controller)
                                  : CartDetailsView(controller: controller),
                            ),
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

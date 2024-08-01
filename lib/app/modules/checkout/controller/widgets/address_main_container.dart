import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/modules/checkout/controller/checkout_controller.dart';
import 'package:grocery_app/app/modules/checkout/controller/widgets/address_top_buttons.dart';

class AddressMainContainer extends GetView<CheckoutController> {
  const AddressMainContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
          height: 50,
          padding: const EdgeInsets.all(3.5),
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            color: context.theme.primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              AddressTopButtons("New Address"),
              AddressTopButtons("Addresses"),
            ],
          )),
    );
  }
}

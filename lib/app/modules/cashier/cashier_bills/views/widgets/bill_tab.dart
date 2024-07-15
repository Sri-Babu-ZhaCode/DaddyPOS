import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../controllers/cashier_bills_controller.dart';
import '../bill_calculator_button_widget.dart';
import '../bill_calculator_widget.dart';

Widget billTab() {
  return GetBuilder<CashierBillsController>(builder: (_) {
    return Center(
      child: BillCalculatorWidget(
        crossAxisCount: 4,
        mainAxisSpacing: 6,
        itemCount: _.calulaterButtons.length,
        itemBuilder: (BuildContext context, int index) {
          if (_.calulaterButtons[index] is String) {
            return CalculatorButton(
              btnText: _.calulaterButtons[index],
              onButtonPressed: () {
                _.shopproductid = _.shopproductid + _.calulaterButtons[index];
                _.update();
              },
            );
          } else if (_.calulaterButtons[index] == true) {
            return CalculatorButton(
              isAddItemBtn: _.calulaterButtons[index],
              onButtonPressed: _.seperatingQty,
            );
          } else {
            // Backspace for quickslae tab
            if (index == 3) {
              return CalculatorButton(
                btnIcon: _.calulaterButtons[index],
                onButtonPressed: () {
                  if (_.shopproductid.isNotEmpty) {
                    if (_.shopproductid[_.shopproductid.length - 1] == 'x') {
                      _.isXpressed = !_.isXpressed;
                      _.isDesimal = true;
                      _.update();
                    }
                    if (_.shopproductid[_.shopproductid.length - 1] == '.') {
                      _.isDecimalPressed = !_.isDecimalPressed;
                    }
                    _.shopproductid =
                        _.shopproductid.substring(0, _.shopproductid.length - 1);
                    _.update();
                  }
                },
              );
            }
            // if x pressed
            if (index == 7) {
              return CalculatorButton(
                btnIcon: _.calulaterButtons[index],
                onButtonPressed: () {
                  if (_.shopproductid.isNotEmpty && !_.isXpressed) {
                    _.shopproductid += 'x';
                    _.isXpressed = !_.isXpressed;
                    _.isShopProductIdPresent();
                    _.update();
                  }
                },
              );
            }
            return CalculatorButton(
                btnIcon:
                    _.isDesimal ? _.calulaterButtons[index] : const Icon(null),
                onButtonPressed: () {
                  if (_.shopproductid.isNotEmpty && !_.isDecimalPressed) {
                    _.shopproductid += '.';
                    _.isDecimalPressed = !_.isDecimalPressed;
                    _.update();
                  }
                });
          }
        },
      ),
    );
  });
}

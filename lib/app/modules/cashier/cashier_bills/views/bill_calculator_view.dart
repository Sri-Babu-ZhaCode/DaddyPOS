import 'package:flutter/material.dart';

class BillCalculatorView extends StatefulWidget {
  const BillCalculatorView({super.key});

  @override
  BillCalculatorViewState createState() => BillCalculatorViewState();
}

class BillCalculatorViewState extends State<BillCalculatorView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('some date'),
    );
    // BillCalculatorWidget(
    //   crossAxisCount: calulaterButtons.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return calulaterButtons[index] is String
    //         ? CalculatorButton(
    //             btnText: calulaterButtons[index](),
    //             onTap: () {},
    //           )
    //         : CalculatorButton(
    //             btnIcon: calulaterButtons[index],
    //             onTap: () {},
    //           );
    //   },
    // );
  }
}

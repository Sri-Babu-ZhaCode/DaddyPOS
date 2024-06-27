import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_password_controller.dart';

class CreatePasswordView extends GetView<CreatePasswordController> {
  const CreatePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreatePasswordView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CreatePasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

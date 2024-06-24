import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nephro_pancartes/models/user.dart';
import 'package:nephro_pancartes/providers/user_provider.dart';
import 'package:nephro_pancartes/widgets/custom_button.dart';
import 'package:nephro_pancartes/widgets/custom_textfield.dart';

class ProfileScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final UserModel? user = userProvider.currentUser;

    if (user != null) {
      nameController.text = user.name;
      emailController.text = user.email;
      roleController.text = user.role;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: nameController,
              labelText: 'Name',
              hintText: 'Enter your name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            CustomTextField(
              controller: emailController,
              labelText: 'Email',
              hintText: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            CustomTextField(
              controller: roleController,
              labelText: 'Role',
              hintText: 'Enter your role',
              readOnly: true,
            ),
            SizedBox(height: 16.0),
            CustomButton(
              text: 'Update Profile',
              onPressed: () {
                if (user != null) {
                  userProvider.updateUser(UserModel(
                    id: user.id,
                    name: nameController.text,
                    email: emailController.text,
                    role: user.role,
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:donut_app_admin/src/modules/base/blocs/upload_picture_bloc/upload_picture_bloc.dart';
import 'package:donut_repository/donut_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../auth/components/my_text_field.dart';
import '../../base/components/macro.dart';
import '../blocs/create_donut_bloc/create_donut_bloc.dart';

class CreateDonutScreen extends StatefulWidget {
  const CreateDonutScreen({super.key});

  @override
  State<CreateDonutScreen> createState() => _CreateDonutScreenState();
}

class _CreateDonutScreenState extends State<CreateDonutScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final discountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final caloriesController = TextEditingController();
  final proteinController = TextEditingController();
  final fatController = TextEditingController();
  final carbsController = TextEditingController();
  bool creationRequired = false;
  String? _errorMsg;
  late Donut donut;

  @override
  void initState() {
    donut = Donut.empty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateDonutBloc, CreateDonutState>(
      listener: (context, state) {
        if (state is CreateDonutSuccess) {
          setState(() {
            creationRequired = false;
          });
          context.go('/');
        } else if (state is CreateDonutLoading) {
          setState(() {
            creationRequired = true;
          });
        } else if (state is CreateDonutFailure) {
          setState(() {
            creationRequired = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to create the donut. Please try again.'),
            ),
          );
        }
      },
      child: BlocListener<UploadPictureBloc, UploadPictureState>(
        listener: (context, state) {
          if (state is UploadPictureSuccess) {
            setState(() {
              donut.picture = state.url;
            });
          } else if (state is UploadPictureFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to upload the picture. Please try again.'),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 20.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create a New Donut !',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                        maxHeight: 1000,
                        maxWidth: 1000,
                      );
                      if (image != null && context.mounted) {
                        context.read<UploadPictureBloc>().add(
                          UploadPicture(
                            await image.readAsBytes(),
                            basename(image.path),
                          ),
                        );
                      }
                    },
                    child: donut.picture.startsWith('http')
                        ? Container(
                            width: 400,
                            height: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(donut.picture),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Ink(
                            width: 400,
                            height: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.photo,
                                  color: Colors.grey.shade200,
                                  size: 100,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "Add a Picture here...",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 400,
                          child: MyTextField(
                            controller: nameController,
                            hintText: 'Name',
                            obscureText: false,
                            fillColor: Colors.white,
                            keyboardType: TextInputType.text,
                            errorMsg: _errorMsg,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please fill in this field';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 400,
                          child: MyTextField(
                            controller: descriptionController,
                            hintText: 'Description',
                            obscureText: false,
                            fillColor: Colors.white,
                            keyboardType: TextInputType.text,
                            errorMsg: _errorMsg,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please fill in this field';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 400,
                          child: Row(
                            children: [
                              Expanded(
                                child: MyTextField(
                                  controller: priceController,
                                  hintText: 'Price',
                                  obscureText: false,
                                  fillColor: Colors.white,
                                  keyboardType: TextInputType.emailAddress,
                                  errorMsg: _errorMsg,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Please fill in this field';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: MyTextField(
                                  controller: discountController,
                                  hintText: 'Discount',
                                  suffixIcon: const Icon(
                                    CupertinoIcons.percent,
                                    color: Colors.white,
                                  ),
                                  obscureText: false,
                                  fillColor: Colors.white,
                                  keyboardType: TextInputType.emailAddress,
                                  errorMsg: _errorMsg,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Please fill in this field';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text('Is Filled :'),
                            const SizedBox(width: 10),
                            Checkbox(
                              value: donut.isFilled,
                              onChanged: (value) {
                                setState(() {
                                  donut.isFilled = value!;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Is Glazed :'),
                            const SizedBox(width: 10),
                            Checkbox(
                              value: donut.isGlazed,
                              onChanged: (value) {
                                setState(() {
                                  donut.isGlazed = value!;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text('Macros:'),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 400,
                          child: Row(
                            children: [
                              MyMacroWidget(
                                title: 'Calories',
                                value: 12,
                                icon: FontAwesomeIcons.fire,
                                controller: caloriesController,
                              ),
                              const SizedBox(width: 10),
                              MyMacroWidget(
                                title: 'Protein',
                                value: 12,
                                icon: FontAwesomeIcons.dumbbell,
                                controller: proteinController,
                              ),
                              const SizedBox(width: 10),
                              MyMacroWidget(
                                title: 'Carbs',
                                value: 12,
                                icon: FontAwesomeIcons.breadSlice,
                                controller: carbsController,
                              ),
                              const SizedBox(width: 10),
                              MyMacroWidget(
                                title: 'Fat',
                                value: 12,
                                icon: FontAwesomeIcons.oilWell,
                                controller: fatController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  !creationRequired
                      ? SizedBox(
                          width: 400,
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  donut.name = nameController.text;
                                  donut.description =
                                      descriptionController.text;
                                  donut.price = double.parse(
                                    priceController.text,
                                  );
                                  donut.discount = double.parse(
                                    discountController.text,
                                  );
                                  donut.macros.calories = int.parse(
                                    caloriesController.text,
                                  );
                                  donut.macros.protein = int.parse(
                                    proteinController.text,
                                  );
                                  donut.macros.carbs = int.parse(
                                    carbsController.text,
                                  );
                                  donut.macros.fat = int.parse(
                                    fatController.text,
                                  );
                                });
                                context.read<CreateDonutBloc>().add(
                                  CreateDonut(donut),
                                );
                              }
                            },
                            style: TextButton.styleFrom(
                              elevation: 3.0,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 5,
                              ),
                              child: Text(
                                'Create Donut',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

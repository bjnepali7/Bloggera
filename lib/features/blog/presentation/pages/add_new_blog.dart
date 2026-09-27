import 'dart:io';

import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddNewBlog extends StatefulWidget {
  const AddNewBlog({super.key});
  static route() => MaterialPageRoute(builder: (context) => AddNewBlog());

  @override
  State<AddNewBlog> createState() => _AddNewBlogState();
}

class _AddNewBlogState extends State<AddNewBlog> {
  final titleCOntroller = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];
  File? image;
  Future<void> selectImage() async {
    // print("1. selectImage started");

    final pickedImage = await pickImage();

    // print("2. pickImage finished");
    // print("3. pickedImage = $pickedImage");

    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });

      //print("4. image selected");
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleCOntroller.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.done_rounded))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              //border container
              image != null
                  ? GestureDetector(
                      onTap: selectImage,
                      child: SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(image!, fit: BoxFit.cover),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: selectImage,
                      child: DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          color: AppPallete.borderColor,
                          dashPattern: const [10, 4],
                          radius: const Radius.circular(12),
                          strokeCap: StrokeCap.round,
                        ),

                        child: Container(
                          height: 150,
                          width: double.infinity,
                          child: const Column(
                            mainAxisAlignment: .center,
                            children: [
                              Icon(Icons.folder_open, size: 40),

                              SizedBox(height: 16),
                              Text(
                                "Select your image",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      ['Technology', 'Business', 'Programming', 'Entertainment']
                          .map(
                            (e) => Padding(
                              padding: EdgeInsets.all(6),

                              child: GestureDetector(
                                onTap: () {
                                  if (selectedTopics.contains(e)) {
                                    selectedTopics.remove(e);
                                  } else {
                                    selectedTopics.add(e);
                                  }

                                  setState(() {});
                                },
                                child: Chip(
                                  label: Text(e),
                                  color: selectedTopics.contains(e)
                                      ? const MaterialStatePropertyAll(
                                          AppPallete.gradient1,
                                        )
                                      : null,
                                  side: selectedTopics.contains(e)
                                      ? null
                                      : const BorderSide(
                                          color: AppPallete.borderColor,
                                        ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              SizedBox(height: 12),

              BlogEditor(controller: titleCOntroller, hintText: "Blog titile"),
              SizedBox(height: 8),
              BlogEditor(
                controller: contentController,
                hintText: "Blog containt",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

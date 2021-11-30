import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_up/bloc/cubit/photo_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Upload"),
        centerTitle: true,
      ),
      body: BlocBuilder<PhotoCubit, PhotoState>(
        builder: (context, state) {
          return Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    context.read<PhotoCubit>().chooseFile(true);
                  },
                  child: CircleAvatar(
                    backgroundImage: state is PhotoUploaded
                        ? FileImage(state.image)
                        : state is PhotoSelected
                            ? FileImage(state.image)
                            : null,
                    backgroundColor: Colors.grey,
                    radius: 60,
                  ),
                ),
                ElevatedButton(
                    onPressed: state is UploadingPhoto
                        ? null
                        : () {
                            context.read<PhotoCubit>().uploadFile();
                          },
                    child: state is UploadingPhoto
                        ? const CircularProgressIndicator()
                        : const Text("Upload"))
              ],
            ),
          );
        },
      ),
    );
  }
}

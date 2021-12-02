import 'package:flutter/material.dart';
import 'package:photo_up/bloc/cubit/photo_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_up/widgets/dialog.dart';

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
                    showDialog(
                        context: context, builder: (ctx) => const MyDialog());
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
                            if (state is PhotoSelected) {
                              context.read<PhotoCubit>().uploadFile();
                            } else if (state is PhotoUploaded) {
                              showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                        title: const Text("Errore"),
                                        content: const Text(
                                            "Stai caricando la stessa foto due volte"),
                                        actions: [
                                          TextButton(
                                            child: const Text("Ok"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                        title: const Text("Errore"),
                                        content:
                                            const Text("Foto non selezionata"),
                                        actions: [
                                          TextButton(
                                            child: const Text("Ok"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ));
                            }
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

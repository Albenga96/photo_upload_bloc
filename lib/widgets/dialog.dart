import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_up/bloc/cubit/photo_cubit.dart';

class MyDialog extends StatelessWidget {
  const MyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoCubit, PhotoState>(
      builder: (context, state) {
        return AlertDialog(
          title: const Text("Seleziona fonte"),
          actions: [
            TextButton(
              onPressed: () {
                if (state is PhotoUploaded) {
                  context.read<PhotoCubit>().retakePhoto();
                }
                context.read<PhotoCubit>().chooseFile(true);
              },
              child: const Text("Camera"),
            ),
            TextButton(
              onPressed: () {
                if (state is PhotoUploaded) {
                  context.read<PhotoCubit>().retakePhoto();
                }
                context.read<PhotoCubit>().chooseFile(true);
              },
              child: const Text("Galleria"),
            ),
          ],
        );
      },
    );
  }
}

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as Path;

part 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  PhotoCubit() : super(PhotoNotSelected());

  Future<void> uploadFile() async {
    final File imageFile = (state as PhotoSelected).image;
    emit(UploadingPhoto());
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(imageFile.path)}}');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask
        .whenComplete(() => storageReference.getDownloadURL().then((fileURL) {
              emit(
                PhotoUploaded(
                  imageUrl: fileURL,
                  image: imageFile,
                ),
              );
            }));
  }

  Future<void> chooseFile(bool isCamera) async {
    await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery)
        .then((image) {
      emit(PhotoSelected(image: File(image!.path)));
    });
  }
}

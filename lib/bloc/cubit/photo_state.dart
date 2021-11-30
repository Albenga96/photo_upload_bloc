part of 'photo_cubit.dart';

@immutable
abstract class PhotoState {}

class PhotoNotSelected extends PhotoState {}

class PhotoSelected extends PhotoState {
  final File image;

  PhotoSelected({
    required this.image,
  });
}

class UploadingPhoto extends PhotoState {}

class PhotoUploaded extends PhotoState {
  final String imageUrl;
  final File image;

  PhotoUploaded({
    required this.imageUrl,
    required this.image,
  });
}

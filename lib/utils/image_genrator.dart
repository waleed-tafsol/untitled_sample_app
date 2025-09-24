import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageGenerator{

  Future<CroppedFile> createImageFile({required bool fromCamera}) async {
    final ImagePicker picker = ImagePicker();
    XFile? imageFile = fromCamera ? await picker.pickImage(
        source: ImageSource.camera)
        :
    await picker.pickImage(source: ImageSource.gallery);
    return cropImage(imageFileToCrop: imageFile!);
  }

  Future<CroppedFile> cropImage({required XFile imageFileToCrop}) async{
    final CroppedFile? croppedFile = await ImageCropper().cropImage(sourcePath: imageFileToCrop.path,
        //maxWidth: 1080,
        //maxHeight: 120,
        aspectRatio: const CropAspectRatio(ratioX: 2.5, ratioY: 2.5));
    return croppedFile!;
  }
}
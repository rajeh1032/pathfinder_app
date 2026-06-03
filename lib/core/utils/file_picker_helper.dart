import 'package:file_picker/file_picker.dart';

class FilePickerHelper {
  const FilePickerHelper._();

  static Future<PlatformFile?> pickSingleFile() async {
    final result = await FilePicker.platform.pickFiles();
    return result?.files.single;
  }
}

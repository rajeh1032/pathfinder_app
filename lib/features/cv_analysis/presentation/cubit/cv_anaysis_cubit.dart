
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import '../../domain/repositories/cv_anaylsis_repo.dart';
import 'cv_analysis_state.dart';

class CvAnalysisCubit extends Cubit<CvAnalysisState> {
  final CvAnalysisRepository repository;

  CvAnalysisCubit(this.repository) : super(const CvAnalysisInitial());

  Future<void> checkStatus() async {
    emit(const CvStatusLoading());
    try {
      final status = await repository.getCvStatus();
      emit(CvStatusLoaded(status));
    } catch (e) {
      emit(CvAnalysisError(e.toString()));
    }
  }

  Future<void> loadLatestAnalysis() async {
    emit(const CvAnalyzing());
    try {
      final result = await repository.getLatestAnalysis();
      emit(CvAnalysisLoaded(result));
    } catch (e) {
      emit(CvAnalysisError(e.toString()));
    }
  }
  Future<String?> pickCvFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result == null || result.files.isEmpty) return null;

    final file = result.files.single;

    // Validate size — max 10MB
    if (file.size > 10 * 1024 * 1024) {
      emit(const CvAnalysisError('File size must be less than 10MB'));
      return null;
    }

    return file.path;
  }

  Future<void> uploadAndAnalyze(String filePath) async {
    try {
      // Step 1 — uploading
      emit(const CvUploadLoading(progress: 0.1));
      await Future.delayed(const Duration(milliseconds: 300));
      emit(const CvUploadLoading(progress: 0.4));

      // Step 2 — analyzing (API call)
      emit(const CvAnalyzing());
      final result = await repository.uploadAndAnalyze(filePath);

      // Step 3 — done
      emit(CvAnalysisLoaded(result));
    } catch (e) {
      emit(CvAnalysisError(e.toString()));
    }
  }

  Future<void> pickAndUpload() async {
    final filePath = await pickCvFile();
    if (filePath == null) return;
    await uploadAndAnalyze(filePath);
  }
}
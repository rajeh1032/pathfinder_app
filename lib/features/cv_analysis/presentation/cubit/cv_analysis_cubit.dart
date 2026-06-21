import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/cv_analysis_repository.dart';
import 'cv_anaylsis_state.dart';

@injectable
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

  // ── Load Analysis by cvId
  Future<void> loadAnalysis(String cvId) async {
    emit(const CvAnalyzing());
    try {
      final result = await repository.getLatestAnalysis();
      emit(CvAnalysisLoaded(result));
    } catch (e) {
      emit(CvAnalysisError(e.toString()));
    }
  }

  // ── Load Latest Analysis ──────────────────────────────────
  Future<void> loadLatestAnalysis() async {
    emit(const CvAnalyzing());
    try {
      final result = await repository.getLatestAnalysis();
      emit(CvAnalysisLoaded(result));
    } catch (e) {
      emit(CvAnalysisError(e.toString()));
    }
  }

  // ── Pick CV File ──────────────────────────────────────────
  Future<String?> pickCvFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result == null || result.files.isEmpty) return null;

    final file = result.files.single;

    // Max 10MB
    if (file.size > 10 * 1024 * 1024) {
      emit(const CvAnalysisError('File size must be less than 10MB'));
      return null;
    }

    if (file.path == null) {
      emit(const CvAnalysisError('Could not access file path'));
      return null;
    }

    return file.path;
  }

  // ── Upload & Analyze ──────────────────────────────────────
  Future<String?> uploadAndAnalyze(String filePath) async {
    try {
      emit(const CvUploadLoading(progress: 0.1));
      await Future.delayed(const Duration(milliseconds: 200));

      emit(const CvUploadLoading(progress: 0.4));
      await Future.delayed(const Duration(milliseconds: 200));

      emit(const CvAnalyzing());

      final result = await repository.uploadAndAnalyze(filePath);

      emit(CvAnalysisLoaded(result));

      return result.cv.id; // ← return cvId for navigation
    } catch (e) {
      emit(CvAnalysisError(e.toString()));
      return null;
    }
  }

  // ── Pick & Upload in one step ─────────────────────────────
  Future<String?> pickAndUpload() async {
    final filePath = await pickCvFile();
    if (filePath == null) return null;
    return uploadAndAnalyze(filePath);
  }
}
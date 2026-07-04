import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/cv_anaylsis_repo.dart';
import 'cv_anaylsis_state.dart';

@injectable
class CvAnalysisCubit extends Cubit<CvAnalysisState> {
  final CvAnalysisRepository repository;

  CvAnalysisCubit(this.repository) : super(const CvAnalysisInitial());

  Future<void> checkStatus() async {
    emit(const CvStatusLoading());
    final result = await repository.getCvStatus();
    result.fold(
      (failure) => emit(CvAnalysisError(failure.message)),
      (status) => emit(CvStatusLoaded(status)),
    );
  }

  Future<void> loadAnalysis(String _) => loadLatestAnalysis();

  Future<void> loadLatestAnalysis() async {
    emit(const CvStatusLoading());
    final statusResult = await repository.getCvStatus();
    await statusResult.fold(
      (failure) async => emit(CvAnalysisError(failure.message)),
      (status) async {
        if (!status.hasCompletedAnalysis) {
          emit(CvStatusLoaded(status));
          return;
        }
        emit(const CvAnalyzing());
        final result = await repository.getLatestAnalysis();
        result.fold(
          (failure) => emit(CvAnalysisError(failure.message)),
          (analysis) => emit(CvAnalysisLoaded(analysis)),
        );
      },
    );
  }

  Future<String?> pickCvFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result == null || result.files.isEmpty) return null;

    final file = result.files.single;

    if (file.size > 10 * 1024 * 1024) {
      emit(const CvAnalysisError('cvUpload.fileTooLarge'));
      return null;
    }

    return file.path;
  }

  Future<void> uploadAndAnalyze(String filePath) async {
    emit(const CvUploadLoading());
    final result = await repository.uploadAndAnalyze(filePath);
    result.fold(
      (failure) => emit(CvAnalysisError(failure.message)),
      (analysis) => emit(CvAnalysisLoaded(analysis)),
    );
  }

  Future<void> pickAndUpload() async {
    final filePath = await pickCvFile();
    if (filePath == null) return;
    await uploadAndAnalyze(filePath);
  }
}

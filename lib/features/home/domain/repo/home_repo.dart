import '../entites/home_entity.dart';

abstract class HomeRepository {
  Future<HomeSummaryEntity> getHomeSummary();
}
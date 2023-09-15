abstract class TruckRepository<T> {
  Future<List<T>> getTrucksByClientAndProject(
      String clientId, String projectId);
  Future<T> getTruckByPlate(String plate);
}

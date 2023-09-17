abstract class LocationRepository<T> {
  Future<List<T>> getLocationsByClientAndProject(
      String idClient, String idProject);
}

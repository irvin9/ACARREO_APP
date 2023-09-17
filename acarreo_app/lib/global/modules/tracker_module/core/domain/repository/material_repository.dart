abstract class MaterialRepository<T> {
  Future<List<T>> getMaterialsByClientAndProject(
      String idClient, String idProject);
}

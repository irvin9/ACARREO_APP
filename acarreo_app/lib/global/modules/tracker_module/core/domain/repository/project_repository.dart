abstract class ProjectRepository<T> {
  Future<T> getById(String id);

  Future<List<T>> getProjectsByClient(String idClient);
}

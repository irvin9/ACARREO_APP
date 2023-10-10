abstract class ProjectRepository<T> {
  Future<T> getByProjectCode(String id);

  Future<List<T>> getProjectsByClient(String idClient);
}

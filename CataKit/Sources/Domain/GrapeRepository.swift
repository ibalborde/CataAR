/// Reads grape (cepa) content. Implementations live in the Data layer.
public protocol GrapeRepository: Sendable {
  func allGrapes() async throws -> [Grape]
  func grape(id: String) async throws -> Grape
}

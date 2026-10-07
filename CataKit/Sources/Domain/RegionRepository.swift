/// Reads region (zona) content. Implementations live in the Data layer.
public protocol RegionRepository: Sendable {
  func allRegions() async throws -> [Region]
  func region(id: String) async throws -> Region
}

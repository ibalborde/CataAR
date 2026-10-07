import ContentBundle
import Domain
import Foundation

public struct JSONRegionRepository: RegionRepository {
  private let bundle: Bundle

  public init(bundle: Bundle = ContentBundle.resourceBundle) {
    self.bundle = bundle
  }

  public func allRegions() async throws -> [Region] {
    let urls = ContentBundleJSONLoader.jsonFileURLs(in: "regions", bundle: bundle)
    let dtos = try urls.map { try ContentBundleJSONLoader.decode(RegionDTO.self, from: $0) }
    return try dtos.map { try $0.toDomain() }
  }

  public func region(id: String) async throws -> Region {
    guard let match = try await allRegions().first(where: { $0.id == id }) else {
      throw ContentError.notFound(id: id)
    }
    return match
  }
}

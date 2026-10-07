import ContentBundle
import Domain
import Foundation

public struct JSONGrapeRepository: GrapeRepository {
  private let bundle: Bundle

  public init(bundle: Bundle = ContentBundle.resourceBundle) {
    self.bundle = bundle
  }

  public func allGrapes() async throws -> [Grape] {
    let urls = ContentBundleJSONLoader.jsonFileURLs(in: "grapes", bundle: bundle)
    let dtos = try urls.map { try ContentBundleJSONLoader.decode(GrapeDTO.self, from: $0) }
    return try dtos.map { try $0.toDomain() }
  }

  public func grape(id: String) async throws -> Grape {
    guard let match = try await allGrapes().first(where: { $0.id == id }) else {
      throw ContentError.notFound(id: id)
    }
    return match
  }
}

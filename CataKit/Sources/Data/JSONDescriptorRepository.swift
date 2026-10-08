import ContentBundle
import Domain
import Foundation

public struct JSONDescriptorRepository: DescriptorRepository {
  private let bundle: Bundle

  public init(bundle: Bundle = ContentBundle.resourceBundle) {
    self.bundle = bundle
  }

  public func allDescriptors() async throws -> [Descriptor] {
    guard
      let url = bundle.url(
        forResource: "descriptors", withExtension: "json", subdirectory: "Content")
    else {
      throw ContentError.notFound(id: "descriptors")
    }
    let dtos = try ContentBundleJSONLoader.decode([DescriptorDTO].self, from: url)
    return try dtos.map { try $0.toDomain() }
  }

  public func descriptor(id: String) async throws -> Descriptor {
    guard let match = try await allDescriptors().first(where: { $0.id == id }) else {
      throw ContentError.notFound(id: id)
    }
    return match
  }
}

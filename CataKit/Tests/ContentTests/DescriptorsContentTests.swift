import Testing

@testable import Data

@Suite("descriptors.json")
struct DescriptorsContentTests {
  @Test("descriptors are unique, kebab-case, map cleanly, and have es names")
  func descriptorsAreValid() throws {
    let url = try #require(ContentFiles.descriptorsURL)
    let dtos = try ContentBundleJSONLoader.decode([DescriptorDTO].self, from: url)
    let ids = dtos.map(\.id)
    #expect(Set(ids).count == ids.count, "descriptor ids must be unique")
    for dto in dtos {
      #expect(ContentValidation.isKebabCase(dto.id), "\(dto.id) is not kebab-case")
      #expect(ContentValidation.hasEs(dto.names), "\(dto.id) is missing an 'es' name")
      _ = try dto.toDomain()
    }
  }
}

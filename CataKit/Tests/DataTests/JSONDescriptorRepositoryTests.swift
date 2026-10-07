import Domain
import Testing

@testable import Data

@Suite("JSONDescriptorRepository")
struct JSONDescriptorRepositoryTests {
  private static let descriptorsJSON = """
    [{ "id": "ciruela", "names": { "es": "Ciruela" }, "family": "fruta negra" }]
    """

  @Test("allDescriptors decodes the single descriptors.json file")
  func allDescriptorsDecodesFile() async throws {
    let bundle = try FixtureBundle.make(resources: ["descriptors.json": Self.descriptorsJSON])
    let repository = JSONDescriptorRepository(bundle: bundle)
    let descriptors = try await repository.allDescriptors()
    #expect(descriptors.map(\.id) == ["ciruela"])
  }

  @Test("descriptor(id:) throws notFound when descriptors.json is missing")
  func descriptorByIdThrowsNotFoundWhenMissing() async throws {
    let bundle = try FixtureBundle.make(resources: [:])
    let repository = JSONDescriptorRepository(bundle: bundle)
    await #expect(throws: ContentError.notFound(id: "descriptors")) {
      _ = try await repository.allDescriptors()
    }
  }
}

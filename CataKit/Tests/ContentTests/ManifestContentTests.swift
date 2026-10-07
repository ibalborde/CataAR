import Testing

@testable import Data

@Suite("manifest.json")
struct ManifestContentTests {
  static let supportedSchemaVersions: Set<Int> = [1]

  @Test("manifest exists and declares a supported schemaVersion")
  func manifestIsValid() throws {
    let url = try #require(ContentFiles.manifestURL)
    let dto = try ContentBundleJSONLoader.decode(ManifestDTO.self, from: url)
    #expect(Self.supportedSchemaVersions.contains(dto.schemaVersion))
    #expect(dto.defaultLocale == "es")
  }
}

import Domain
import Testing

@testable import Data

@Suite("JSONRegionRepository")
struct JSONRegionRepositoryTests {
  private static let regionJSON = """
    {
      "id": "fixture-region",
      "parentId": null,
      "level": "department",
      "names": { "es": "Zona de prueba" },
      "altitudeMeters": null,
      "climate": null,
      "soils": null,
      "keyGrapeIds": [],
      "wineStyle": null,
      "protectedDesignations": [],
      "coordinates": null,
      "sources": [{ "title": "Fixture", "url": "https://example.com", "accessed": "2026-01-01" }]
    }
    """

  @Test("allRegions loads and maps every file under regions/")
  func allRegionsLoadsEveryFile() async throws {
    let bundle = try FixtureBundle.make(resources: ["regions/fixture-region.json": Self.regionJSON])
    let repository = JSONRegionRepository(bundle: bundle)
    let regions = try await repository.allRegions()
    #expect(regions.map(\.id) == ["fixture-region"])
  }

  @Test("region(id:) throws notFound for an unknown id")
  func regionByIdThrowsNotFound() async throws {
    let bundle = try FixtureBundle.make(resources: [:])
    let repository = JSONRegionRepository(bundle: bundle)
    await #expect(throws: ContentError.notFound(id: "fixture-region")) {
      _ = try await repository.region(id: "fixture-region")
    }
  }
}

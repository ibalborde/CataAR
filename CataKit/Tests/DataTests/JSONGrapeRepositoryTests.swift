import Domain
import Testing

@testable import Data

@Suite("JSONGrapeRepository")
struct JSONGrapeRepositoryTests {
  private static let malbecJSON = """
    {
      "id": "fixture-grape",
      "names": { "es": "Cepa de prueba" },
      "aliases": [],
      "color": "red",
      "origin": { "regionId": "fr", "note": { "es": "Nota" } },
      "structure": { "body": 3, "tannin": 3, "acidity": 3, "alcohol": 3, "colorIntensity": 3 },
      "visual": { "es": "Visual" },
      "aromas": [],
      "palate": { "es": "Paladar" },
      "blindTastingKeys": [],
      "confusedWith": [],
      "evolution": {
        "young": { "es": "Joven" },
        "aged": { "es": "Evolucionado" },
        "agingPotentialYears": { "min": 1, "max": 5 }
      },
      "regionalExpressions": [],
      "sources": [{ "title": "Fixture", "url": "https://example.com", "accessed": "2026-01-01" }]
    }
    """

  @Test("allGrapes loads and maps every file under grapes/")
  func allGrapesLoadsEveryFile() async throws {
    let bundle = try FixtureBundle.make(resources: ["grapes/fixture-grape.json": Self.malbecJSON])
    let repository = JSONGrapeRepository(bundle: bundle)
    let grapes = try await repository.allGrapes()
    #expect(grapes.map(\.id) == ["fixture-grape"])
  }

  @Test("grape(id:) returns the matching grape")
  func grapeByIdReturnsMatch() async throws {
    let bundle = try FixtureBundle.make(resources: ["grapes/fixture-grape.json": Self.malbecJSON])
    let repository = JSONGrapeRepository(bundle: bundle)
    let grape = try await repository.grape(id: "fixture-grape")
    #expect(grape.id == "fixture-grape")
  }

  @Test("grape(id:) throws notFound for an unknown id")
  func grapeByIdThrowsNotFound() async throws {
    let bundle = try FixtureBundle.make(resources: [:])
    let repository = JSONGrapeRepository(bundle: bundle)
    await #expect(throws: ContentError.notFound(id: "fixture-grape")) {
      _ = try await repository.grape(id: "fixture-grape")
    }
  }
}

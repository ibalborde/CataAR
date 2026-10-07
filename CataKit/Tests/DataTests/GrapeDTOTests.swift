import Domain
import Foundation
import Testing

@testable import Data

@Suite("GrapeDTO")
struct GrapeDTOTests {
  private static let validJSON = """
    {
      "id": "fixture-grape",
      "names": { "es": "Cepa de prueba" },
      "aliases": ["Alias de prueba"],
      "color": "red",
      "origin": { "regionId": "fr", "note": { "es": "Nota de prueba" } },
      "structure": { "body": 3, "tannin": 3, "acidity": 3, "alcohol": 3, "colorIntensity": 3 },
      "visual": { "es": "Visual de prueba" },
      "aromas": [{ "descriptorId": "ciruela", "kind": "primary" }],
      "palate": { "es": "Paladar de prueba" },
      "blindTastingKeys": [{ "es": "Clave de prueba" }],
      "confusedWith": [],
      "evolution": {
        "young": { "es": "Joven de prueba" },
        "aged": { "es": "Evolucionado de prueba" },
        "agingPotentialYears": { "min": 1, "max": 5 }
      },
      "regionalExpressions": [],
      "sources": [{ "title": "Fixture", "url": "https://example.com", "accessed": "2026-01-01" }]
    }
    """

  @Test("decodes and maps a well-formed grape")
  func decodesAndMapsWellFormedGrape() throws {
    let dto = try JSONDecoder().decode(GrapeDTO.self, from: Data(Self.validJSON.utf8))
    let grape = try dto.toDomain()
    #expect(grape.id == "fixture-grape")
    #expect(grape.color == .red)
    #expect(grape.structure.body == 3)
    #expect(grape.aromas == [Grape.AromaReference(descriptorId: "ciruela", kind: .primary)])
    #expect(grape.evolution.agingPotentialYears.max == 5)
    #expect(grape.sources.first?.url.absoluteString == "https://example.com")
  }

  @Test("throws decodingFailed for an unknown color")
  func throwsForUnknownColor() throws {
    let json = Self.validJSON.replacingOccurrences(of: "\"red\"", with: "\"purple\"")
    let dto = try JSONDecoder().decode(GrapeDTO.self, from: Data(json.utf8))
    #expect(throws: ContentError.decodingFailed("grape fixture-grape: unknown color 'purple'")) {
      try dto.toDomain()
    }
  }

  @Test("throws decodingFailed for an unknown aroma kind")
  func throwsForUnknownAromaKind() throws {
    let json = Self.validJSON.replacingOccurrences(of: "\"primary\"", with: "\"nose\"")
    let dto = try JSONDecoder().decode(GrapeDTO.self, from: Data(json.utf8))
    #expect(throws: ContentError.decodingFailed("grape fixture-grape: unknown aroma kind 'nose'")) {
      try dto.toDomain()
    }
  }
}

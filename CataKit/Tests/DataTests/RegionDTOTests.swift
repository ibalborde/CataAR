import Domain
import Foundation
import Testing

@testable import Data

@Suite("RegionDTO")
struct RegionDTOTests {
  private static let departmentJSON = """
    {
      "id": "fixture-region",
      "parentId": "fixture-province",
      "level": "department",
      "names": { "es": "Zona de prueba" },
      "altitudeMeters": { "min": 800, "max": 1000 },
      "climate": { "es": "Clima de prueba" },
      "soils": { "es": "Suelo de prueba" },
      "keyGrapeIds": ["fixture-grape"],
      "wineStyle": { "es": "Estilo de prueba" },
      "protectedDesignations": [
        { "kind": "DOC", "name": { "es": "DOC de prueba" }, "rules": { "es": "Reglas de prueba" } }
      ],
      "coordinates": { "lat": -33.0, "lon": -68.0 },
      "sources": [{ "title": "Fixture", "url": "https://example.com", "accessed": "2026-01-01" }]
    }
    """

  private static let countryJSON = """
    {
      "id": "ar",
      "parentId": null,
      "level": "country",
      "names": { "es": "Argentina" },
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

  @Test("decodes and maps a department-level region")
  func decodesAndMapsDepartmentRegion() throws {
    let dto = try JSONDecoder().decode(RegionDTO.self, from: Data(Self.departmentJSON.utf8))
    let region = try dto.toDomain()
    #expect(region.id == "fixture-region")
    #expect(region.level == .department)
    #expect(region.altitudeMeters == Region.AltitudeRange(min: 800, max: 1000))
    #expect(region.protectedDesignations.first?.kind == .doc)
  }

  @Test("optional fields decode to nil at the country level")
  func optionalFieldsDecodeToNilAtCountryLevel() throws {
    let dto = try JSONDecoder().decode(RegionDTO.self, from: Data(Self.countryJSON.utf8))
    let region = try dto.toDomain()
    #expect(region.parentId == nil)
    #expect(region.altitudeMeters == nil)
    #expect(region.climate == nil)
    #expect(region.coordinates == nil)
  }

  @Test("throws decodingFailed for an unknown level")
  func throwsForUnknownLevel() throws {
    let json = Self.departmentJSON.replacingOccurrences(of: "\"department\"", with: "\"planet\"")
    let dto = try JSONDecoder().decode(RegionDTO.self, from: Data(json.utf8))
    #expect(throws: ContentError.decodingFailed("region fixture-region: unknown level 'planet'")) {
      try dto.toDomain()
    }
  }

  @Test("throws decodingFailed for an unknown protected designation kind")
  func throwsForUnknownDesignationKind() throws {
    let json = Self.departmentJSON.replacingOccurrences(of: "\"DOC\"", with: "\"XYZ\"")
    let dto = try JSONDecoder().decode(RegionDTO.self, from: Data(json.utf8))
    #expect(
      throws: ContentError.decodingFailed("region fixture-region: unknown designation kind 'XYZ'")
    ) {
      try dto.toDomain()
    }
  }
}

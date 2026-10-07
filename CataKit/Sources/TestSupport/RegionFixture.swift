import Domain
import Foundation

public enum RegionFixture {
  public static func make(
    id: String = "fixture-region",
    parentId: String? = nil,
    level: RegionLevel = .department,
    names: LocalizedText = LocalizedText(values: ["es": "Zona de prueba"]),
    altitudeMeters: Region.AltitudeRange? = Region.AltitudeRange(min: 800, max: 1000),
    climate: LocalizedText? = LocalizedText(values: ["es": "Clima de prueba"]),
    soils: LocalizedText? = LocalizedText(values: ["es": "Suelo de prueba"]),
    keyGrapeIds: [String] = [],
    wineStyle: LocalizedText? = LocalizedText(values: ["es": "Estilo de prueba"]),
    protectedDesignations: [Region.ProtectedDesignation] = [],
    coordinates: Region.Coordinates? = Region.Coordinates(lat: -33.0, lon: -68.0),
    sources: [Source] = [
      Source(title: "Fixture", url: URL(string: "https://example.com")!, accessed: "2026-01-01")
    ]
  ) -> Region {
    Region(
      id: id,
      parentId: parentId,
      level: level,
      names: names,
      altitudeMeters: altitudeMeters,
      climate: climate,
      soils: soils,
      keyGrapeIds: keyGrapeIds,
      wineStyle: wineStyle,
      protectedDesignations: protectedDesignations,
      coordinates: coordinates,
      sources: sources
    )
  }
}

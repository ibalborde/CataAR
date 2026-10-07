import Domain

struct RegionDTO: Codable {
  struct AltitudeDTO: Codable {
    let min: Int
    let max: Int
  }

  struct CoordinatesDTO: Codable {
    let lat: Double
    let lon: Double
  }

  struct ProtectedDesignationDTO: Codable {
    let kind: String
    let name: [String: String]
    let rules: [String: String]
  }

  let id: String
  let parentId: String?
  let level: String
  let names: [String: String]
  let altitudeMeters: AltitudeDTO?
  let climate: [String: String]?
  let soils: [String: String]?
  let keyGrapeIds: [String]
  let wineStyle: [String: String]?
  let protectedDesignations: [ProtectedDesignationDTO]
  let coordinates: CoordinatesDTO?
  let sources: [SourceDTO]
}

extension RegionDTO {
  func toDomain() throws -> Region {
    guard let level = RegionLevel(rawValue: level) else {
      throw ContentError.decodingFailed("region \(id): unknown level '\(level)'")
    }
    let protectedDesignations = try protectedDesignations.map {
      designation -> Region.ProtectedDesignation in
      guard let kind = ProtectedDesignationKind(rawValue: designation.kind) else {
        throw ContentError.decodingFailed(
          "region \(id): unknown designation kind '\(designation.kind)'"
        )
      }
      return Region.ProtectedDesignation(
        kind: kind,
        name: LocalizedText(values: designation.name),
        rules: LocalizedText(values: designation.rules)
      )
    }
    return Region(
      id: id,
      parentId: parentId,
      level: level,
      names: LocalizedText(values: names),
      altitudeMeters: altitudeMeters.map { Region.AltitudeRange(min: $0.min, max: $0.max) },
      climate: climate.map { LocalizedText(values: $0) },
      soils: soils.map { LocalizedText(values: $0) },
      keyGrapeIds: keyGrapeIds,
      wineStyle: wineStyle.map { LocalizedText(values: $0) },
      protectedDesignations: protectedDesignations,
      coordinates: coordinates.map { Region.Coordinates(lat: $0.lat, lon: $0.lon) },
      sources: try sources.map { try $0.toDomain() }
    )
  }
}

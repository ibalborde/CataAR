public struct Region: Sendable, Hashable, Identifiable {
  public let id: String
  public let parentId: String?
  public let level: RegionLevel
  public let names: LocalizedText
  public let altitudeMeters: AltitudeRange?
  public let climate: LocalizedText?
  public let soils: LocalizedText?
  public let keyGrapeIds: [String]
  public let wineStyle: LocalizedText?
  public let protectedDesignations: [ProtectedDesignation]
  public let coordinates: Coordinates?
  public let sources: [Source]

  public init(
    id: String,
    parentId: String?,
    level: RegionLevel,
    names: LocalizedText,
    altitudeMeters: AltitudeRange?,
    climate: LocalizedText?,
    soils: LocalizedText?,
    keyGrapeIds: [String],
    wineStyle: LocalizedText?,
    protectedDesignations: [ProtectedDesignation],
    coordinates: Coordinates?,
    sources: [Source]
  ) {
    self.id = id
    self.parentId = parentId
    self.level = level
    self.names = names
    self.altitudeMeters = altitudeMeters
    self.climate = climate
    self.soils = soils
    self.keyGrapeIds = keyGrapeIds
    self.wineStyle = wineStyle
    self.protectedDesignations = protectedDesignations
    self.coordinates = coordinates
    self.sources = sources
  }
}

extension Region {
  public struct AltitudeRange: Sendable, Hashable {
    public let min: Int
    public let max: Int

    public init(min: Int, max: Int) {
      self.min = min
      self.max = max
    }
  }

  public struct Coordinates: Sendable, Hashable {
    public let lat: Double
    public let lon: Double

    public init(lat: Double, lon: Double) {
      self.lat = lat
      self.lon = lon
    }
  }

  public struct ProtectedDesignation: Sendable, Hashable {
    public let kind: ProtectedDesignationKind
    public let name: LocalizedText
    public let rules: LocalizedText

    public init(kind: ProtectedDesignationKind, name: LocalizedText, rules: LocalizedText) {
      self.kind = kind
      self.name = name
      self.rules = rules
    }
  }
}

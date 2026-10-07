public struct Grape: Sendable, Hashable, Identifiable {
  public let id: String
  public let names: LocalizedText
  public let aliases: [String]
  public let color: WineColor
  public let origin: Origin
  public let structure: Structure
  public let visual: LocalizedText
  public let aromas: [AromaReference]
  public let palate: LocalizedText
  public let blindTastingKeys: [LocalizedText]
  public let confusedWith: [ConfusedWithReference]
  public let evolution: Evolution
  public let regionalExpressions: [RegionalExpression]
  public let sources: [Source]

  public init(
    id: String,
    names: LocalizedText,
    aliases: [String],
    color: WineColor,
    origin: Origin,
    structure: Structure,
    visual: LocalizedText,
    aromas: [AromaReference],
    palate: LocalizedText,
    blindTastingKeys: [LocalizedText],
    confusedWith: [ConfusedWithReference],
    evolution: Evolution,
    regionalExpressions: [RegionalExpression],
    sources: [Source]
  ) {
    self.id = id
    self.names = names
    self.aliases = aliases
    self.color = color
    self.origin = origin
    self.structure = structure
    self.visual = visual
    self.aromas = aromas
    self.palate = palate
    self.blindTastingKeys = blindTastingKeys
    self.confusedWith = confusedWith
    self.evolution = evolution
    self.regionalExpressions = regionalExpressions
    self.sources = sources
  }
}

extension Grape {
  public struct Origin: Sendable, Hashable {
    public let regionId: String
    public let note: LocalizedText

    public init(regionId: String, note: LocalizedText) {
      self.regionId = regionId
      self.note = note
    }
  }

  public struct Structure: Sendable, Hashable {
    public let body: Int
    public let tannin: Int
    public let acidity: Int
    public let alcohol: Int
    public let colorIntensity: Int

    public init(body: Int, tannin: Int, acidity: Int, alcohol: Int, colorIntensity: Int) {
      self.body = body
      self.tannin = tannin
      self.acidity = acidity
      self.alcohol = alcohol
      self.colorIntensity = colorIntensity
    }
  }

  public struct AromaReference: Sendable, Hashable {
    public let descriptorId: String
    public let kind: AromaKind

    public init(descriptorId: String, kind: AromaKind) {
      self.descriptorId = descriptorId
      self.kind = kind
    }
  }

  public struct ConfusedWithReference: Sendable, Hashable {
    public let grapeId: String
    public let howToTell: LocalizedText

    public init(grapeId: String, howToTell: LocalizedText) {
      self.grapeId = grapeId
      self.howToTell = howToTell
    }
  }

  public struct Evolution: Sendable, Hashable {
    public let young: LocalizedText
    public let aged: LocalizedText
    public let agingPotentialYears: AgingPotentialYears

    public init(young: LocalizedText, aged: LocalizedText, agingPotentialYears: AgingPotentialYears)
    {
      self.young = young
      self.aged = aged
      self.agingPotentialYears = agingPotentialYears
    }
  }

  public struct AgingPotentialYears: Sendable, Hashable {
    public let min: Int
    public let max: Int

    public init(min: Int, max: Int) {
      self.min = min
      self.max = max
    }
  }

  public struct RegionalExpression: Sendable, Hashable {
    public let regionId: String
    public let notes: LocalizedText

    public init(regionId: String, notes: LocalizedText) {
      self.regionId = regionId
      self.notes = notes
    }
  }
}

import Domain

struct GrapeDTO: Codable {
  struct OriginDTO: Codable {
    let regionId: String
    let note: [String: String]
  }

  struct StructureDTO: Codable {
    let body: Int
    let tannin: Int
    let acidity: Int
    let alcohol: Int
    let colorIntensity: Int
  }

  struct AromaDTO: Codable {
    let descriptorId: String
    let kind: String
  }

  struct ConfusedWithDTO: Codable {
    let grapeId: String
    let howToTell: [String: String]
  }

  struct AgingPotentialDTO: Codable {
    let min: Int
    let max: Int
  }

  struct EvolutionDTO: Codable {
    let young: [String: String]
    let aged: [String: String]
    let agingPotentialYears: AgingPotentialDTO
  }

  struct RegionalExpressionDTO: Codable {
    let regionId: String
    let notes: [String: String]
  }

  let id: String
  let names: [String: String]
  let aliases: [String]
  let color: String
  let origin: OriginDTO
  let structure: StructureDTO
  let visual: [String: String]
  let aromas: [AromaDTO]
  let palate: [String: String]
  let blindTastingKeys: [[String: String]]
  let confusedWith: [ConfusedWithDTO]
  let evolution: EvolutionDTO
  let regionalExpressions: [RegionalExpressionDTO]
  let sources: [SourceDTO]
}

extension GrapeDTO {
  func toDomain() throws -> Grape {
    guard let color = WineColor(rawValue: color) else {
      throw ContentError.decodingFailed("grape \(id): unknown color '\(color)'")
    }
    let aromas = try aromas.map { aroma -> Grape.AromaReference in
      guard let kind = AromaKind(rawValue: aroma.kind) else {
        throw ContentError.decodingFailed("grape \(id): unknown aroma kind '\(aroma.kind)'")
      }
      return Grape.AromaReference(descriptorId: aroma.descriptorId, kind: kind)
    }
    return Grape(
      id: id,
      names: LocalizedText(values: names),
      aliases: aliases,
      color: color,
      origin: Grape.Origin(regionId: origin.regionId, note: LocalizedText(values: origin.note)),
      structure: Grape.Structure(
        body: structure.body,
        tannin: structure.tannin,
        acidity: structure.acidity,
        alcohol: structure.alcohol,
        colorIntensity: structure.colorIntensity
      ),
      visual: LocalizedText(values: visual),
      aromas: aromas,
      palate: LocalizedText(values: palate),
      blindTastingKeys: blindTastingKeys.map { LocalizedText(values: $0) },
      confusedWith: confusedWith.map {
        Grape.ConfusedWithReference(
          grapeId: $0.grapeId,
          howToTell: LocalizedText(values: $0.howToTell)
        )
      },
      evolution: Grape.Evolution(
        young: LocalizedText(values: evolution.young),
        aged: LocalizedText(values: evolution.aged),
        agingPotentialYears: Grape.AgingPotentialYears(
          min: evolution.agingPotentialYears.min,
          max: evolution.agingPotentialYears.max
        )
      ),
      regionalExpressions: regionalExpressions.map {
        Grape.RegionalExpression(regionId: $0.regionId, notes: LocalizedText(values: $0.notes))
      },
      sources: try sources.map { try $0.toDomain() }
    )
  }
}

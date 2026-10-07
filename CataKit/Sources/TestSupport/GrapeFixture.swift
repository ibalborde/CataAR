import Domain
import Foundation

public enum GrapeFixture {
  public static func make(
    id: String = "fixture-grape",
    names: LocalizedText = LocalizedText(values: ["es": "Cepa de prueba"]),
    aliases: [String] = [],
    color: WineColor = .red,
    origin: Grape.Origin = Grape.Origin(
      regionId: "fr",
      note: LocalizedText(values: ["es": "Origen de prueba"])
    ),
    structure: Grape.Structure = Grape.Structure(
      body: 3,
      tannin: 3,
      acidity: 3,
      alcohol: 3,
      colorIntensity: 3
    ),
    visual: LocalizedText = LocalizedText(values: ["es": "Visual de prueba"]),
    aromas: [Grape.AromaReference] = [],
    palate: LocalizedText = LocalizedText(values: ["es": "Paladar de prueba"]),
    blindTastingKeys: [LocalizedText] = [],
    confusedWith: [Grape.ConfusedWithReference] = [],
    evolution: Grape.Evolution = Grape.Evolution(
      young: LocalizedText(values: ["es": "Joven de prueba"]),
      aged: LocalizedText(values: ["es": "Evolucionado de prueba"]),
      agingPotentialYears: Grape.AgingPotentialYears(min: 1, max: 5)
    ),
    regionalExpressions: [Grape.RegionalExpression] = [],
    sources: [Source] = [
      Source(title: "Fixture", url: URL(string: "https://example.com")!, accessed: "2026-01-01")
    ]
  ) -> Grape {
    Grape(
      id: id,
      names: names,
      aliases: aliases,
      color: color,
      origin: origin,
      structure: structure,
      visual: visual,
      aromas: aromas,
      palate: palate,
      blindTastingKeys: blindTastingKeys,
      confusedWith: confusedWith,
      evolution: evolution,
      regionalExpressions: regionalExpressions,
      sources: sources
    )
  }
}

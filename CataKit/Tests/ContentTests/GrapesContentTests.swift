import Foundation
import Testing

@testable import Data

@Suite("grapes/*.json")
struct GrapesContentTests {
  @Test(
    "each grape file is internally valid and its references resolve",
    arguments: ContentFiles.grapeFileURLs)
  func grapeFileIsValid(url: URL) throws {
    let dto = try ContentBundleJSONLoader.decode(GrapeDTO.self, from: url)

    #expect(ContentValidation.isKebabCase(dto.id), "\(dto.id) is not kebab-case")
    #expect(ContentValidation.hasEs(dto.names))
    #expect(ContentValidation.hasEs(dto.visual))
    #expect(ContentValidation.hasEs(dto.palate))
    #expect(ContentValidation.hasEs(dto.origin.note))
    #expect(ContentValidation.hasEs(dto.evolution.young))
    #expect(ContentValidation.hasEs(dto.evolution.aged))
    for key in dto.blindTastingKeys {
      #expect(ContentValidation.hasEs(key))
    }
    for scale in [
      dto.structure.body, dto.structure.tannin, dto.structure.acidity,
      dto.structure.alcohol, dto.structure.colorIntensity,
    ] {
      #expect(
        ContentValidation.isInScaleRange(scale), "\(dto.id) has an out-of-range structure scale")
    }
    #expect(!dto.sources.isEmpty, "\(dto.id) has no sources")
    #expect(dto.evolution.agingPotentialYears.min <= dto.evolution.agingPotentialYears.max)

    let grape = try dto.toDomain()

    let descriptorsURL = try #require(ContentFiles.descriptorsURL)
    let knownDescriptorIds = Set(
      try ContentBundleJSONLoader.decode([DescriptorDTO].self, from: descriptorsURL).map(\.id)
    )
    for aroma in grape.aromas {
      #expect(
        knownDescriptorIds.contains(aroma.descriptorId),
        "\(dto.id): unknown descriptorId \(aroma.descriptorId)"
      )
    }

    let knownGrapeIds = Set(
      ContentFiles.grapeFileURLs.compactMap {
        try? ContentBundleJSONLoader.decode(GrapeDTO.self, from: $0).id
      }
    )
    for confusion in grape.confusedWith {
      #expect(
        knownGrapeIds.contains(confusion.grapeId),
        "\(dto.id): unknown confusedWith grapeId \(confusion.grapeId)"
      )
    }

    let knownRegionIds = Set(
      ContentFiles.regionFileURLs.compactMap {
        try? ContentBundleJSONLoader.decode(RegionDTO.self, from: $0).id
      }
    )
    for expression in grape.regionalExpressions {
      #expect(
        knownRegionIds.contains(expression.regionId),
        "\(dto.id): unknown regionalExpression regionId \(expression.regionId)"
      )
    }
  }
}

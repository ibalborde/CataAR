import Foundation
import Testing

@testable import Data

@Suite("regions/*.json")
struct RegionsContentTests {
  @Test(
    "each region file is internally valid and its references resolve",
    arguments: ContentFiles.regionFileURLs)
  func regionFileIsValid(url: URL) throws {
    let dto = try ContentBundleJSONLoader.decode(RegionDTO.self, from: url)

    #expect(ContentValidation.isKebabCase(dto.id), "\(dto.id) is not kebab-case")
    #expect(ContentValidation.hasEs(dto.names))
    if let climate = dto.climate {
      #expect(ContentValidation.hasEs(climate))
    }
    if let soils = dto.soils {
      #expect(ContentValidation.hasEs(soils))
    }
    if let wineStyle = dto.wineStyle {
      #expect(ContentValidation.hasEs(wineStyle))
    }
    for designation in dto.protectedDesignations {
      #expect(ContentValidation.hasEs(designation.name))
      #expect(ContentValidation.hasEs(designation.rules))
    }
    if let altitude = dto.altitudeMeters {
      #expect(altitude.min <= altitude.max, "\(dto.id): altitudeMeters.min > max")
    }
    #expect(!dto.sources.isEmpty, "\(dto.id) has no sources")

    let region = try dto.toDomain()

    let knownRegionIds = Set(
      ContentFiles.regionFileURLs.compactMap {
        try? ContentBundleJSONLoader.decode(RegionDTO.self, from: $0).id
      }
    )
    if let parentId = region.parentId {
      #expect(knownRegionIds.contains(parentId), "\(dto.id): unknown parentId \(parentId)")
    }

    let knownGrapeIds = Set(
      ContentFiles.grapeFileURLs.compactMap {
        try? ContentBundleJSONLoader.decode(GrapeDTO.self, from: $0).id
      }
    )
    for grapeId in region.keyGrapeIds {
      #expect(knownGrapeIds.contains(grapeId), "\(dto.id): unknown keyGrapeId \(grapeId)")
    }
  }
}

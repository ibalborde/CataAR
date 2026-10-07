import Domain
import Foundation
import Testing

@Suite("Entity identity")
struct EntityIdentityTests {
  @Test("Descriptor id drives Identifiable conformance")
  func descriptorIdentity() {
    let descriptor = Descriptor(
      id: "ciruela",
      names: LocalizedText(values: ["es": "Ciruela"]),
      family: .blackFruit
    )
    #expect(descriptor.id == "ciruela")
  }

  @Test("equal descriptors are equal and hash the same")
  func equalDescriptorsAreEqual() {
    let names = LocalizedText(values: ["es": "Ciruela"])
    let a = Descriptor(id: "ciruela", names: names, family: .blackFruit)
    let b = Descriptor(id: "ciruela", names: names, family: .blackFruit)
    #expect(a == b)
    #expect(a.hashValue == b.hashValue)
  }

  @Test("grape id drives Identifiable conformance")
  func grapeIdentity() {
    let grape = Grape(
      id: "malbec",
      names: LocalizedText(values: ["es": "Malbec"]),
      aliases: ["Côt"],
      color: .red,
      origin: Grape.Origin(regionId: "fr", note: LocalizedText(values: ["es": "Nota"])),
      structure: Grape.Structure(body: 4, tannin: 3, acidity: 3, alcohol: 4, colorIntensity: 5),
      visual: LocalizedText(values: ["es": "Visual"]),
      aromas: [Grape.AromaReference(descriptorId: "ciruela", kind: .primary)],
      palate: LocalizedText(values: ["es": "Paladar"]),
      blindTastingKeys: [LocalizedText(values: ["es": "Clave"])],
      confusedWith: [],
      evolution: Grape.Evolution(
        young: LocalizedText(values: ["es": "Joven"]),
        aged: LocalizedText(values: ["es": "Evolucionado"]),
        agingPotentialYears: Grape.AgingPotentialYears(min: 3, max: 15)
      ),
      regionalExpressions: [],
      sources: [
        Source(title: "Fixture", url: URL(string: "https://example.com")!, accessed: "2026-01-01")
      ]
    )
    #expect(grape.id == "malbec")
  }

  @Test("region id drives Identifiable conformance")
  func regionIdentity() {
    let region = Region(
      id: "ar-mendoza-lujan-de-cuyo",
      parentId: "ar-mendoza",
      level: .department,
      names: LocalizedText(values: ["es": "Luján de Cuyo"]),
      altitudeMeters: Region.AltitudeRange(min: 850, max: 1100),
      climate: LocalizedText(values: ["es": "Clima"]),
      soils: LocalizedText(values: ["es": "Suelo"]),
      keyGrapeIds: ["malbec"],
      wineStyle: LocalizedText(values: ["es": "Estilo"]),
      protectedDesignations: [],
      coordinates: Region.Coordinates(lat: -33.035, lon: -68.878),
      sources: [
        Source(title: "Fixture", url: URL(string: "https://example.com")!, accessed: "2026-01-01")
      ]
    )
    #expect(region.id == "ar-mendoza-lujan-de-cuyo")
  }
}

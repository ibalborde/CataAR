import ContentBundle
import Data
import Domain

@MainActor
struct AppContainer {
  let grapeRepository: GrapeRepository
  let regionRepository: RegionRepository
  let descriptorRepository: DescriptorRepository

  init(
    grapeRepository: GrapeRepository = JSONGrapeRepository(),
    regionRepository: RegionRepository = JSONRegionRepository(),
    descriptorRepository: DescriptorRepository = JSONDescriptorRepository()
  ) {
    self.grapeRepository = grapeRepository
    self.regionRepository = regionRepository
    self.descriptorRepository = descriptorRepository
  }
}

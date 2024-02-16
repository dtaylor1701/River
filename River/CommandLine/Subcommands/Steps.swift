import ArgumentParser
import RiverKit

extension River {
  struct Steps: AsyncParsableCommand {
    mutating func run() async throws {
      let flowManager = try setupFlowManager()

      print(StateFormatter.description(of: try flowManager.steps()))
    }
  }
}

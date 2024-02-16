import ArgumentParser
import Foundation
import RiverKit

extension River {
  struct New: AsyncParsableCommand {
    @Argument
    var name: String

    mutating func run() async throws {
      let newFlowPath = try FlowManager.create(directory: River.currentDirectoryPath, name: name)
      print("Created new flow definition at \(newFlowPath)")
    }
  }
}

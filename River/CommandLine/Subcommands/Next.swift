import ArgumentParser
import RiverKit

extension River {
  struct Next: AsyncParsableCommand {
    mutating func run() async throws {
      let flowManager = try setupFlowManager()

      guard let nextState = try flowManager.next() else {
        print("Done")
        throw ExitCode.success
      }

      print(StateFormatter.description(of: nextState))

      for action in nextState.step.actions {
        if !nextState.completedActions.contains(action) {
          print(description(of: action).formattedOutput())
          switch action {
          case .collect(let collectAction):
            if let input = readLine() {
              try flowManager.perform(
                collectAction: collectAction, in: nextState.step, input: input)
            } else {
              print("Provide a valid value.")
            }
          case .execute(let executeAction):
            try flowManager.perform(
              executeAction: executeAction, in: nextState.step)
          }
        }
      }

      print(StateFormatter.description(of: try flowManager.state(for: nextState.step)))
      try await run()
    }

    @FormattedOutputBuilder
    func description(of action: Action) -> [FormattedElement] {
      FormattedElement("\(action.name):")
    }
  }
}

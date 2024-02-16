import RiverKit

enum StateFormatter {
  static func description(of steps: [StepState]) -> String {
    makeOutput {
      FormattedElement("Steps") {
        FormattedElement.spacer()
        for step in steps {
          formattedOutput(of: step)
          FormattedElement.spacer()
        }
      }
    }.formattedOutput()
  }

  static func description(of stepState: StepState) -> String {
    formattedOutput(of: stepState).formattedOutput()
  }

  @FormattedOutputBuilder
  static func formattedOutput(of stepState: StepState) -> [FormattedElement] {
    FormattedElement(stepState.step.name) {
      FormattedElement("Dependencies") {
        for artifact in stepState.allDependencies {
          formattedOutput(of: artifact, in: stepState)
        }

        if stepState.allDependencies.isEmpty {
          FormattedElement("None")
        }
      }
      FormattedElement("Actions") {
        for action in stepState.step.actions {
          formattedOutput(of: action, in: stepState)
        }

        if stepState.step.actions.isEmpty {
          FormattedElement("None")
        }
      }
    }
  }

  @FormattedOutputBuilder
  static func formattedOutput(of artifact: Artifact, in stepState: StepState) -> [FormattedElement]
  {
    if stepState.existingDependencies.contains(artifact) {
      FormattedElement("✅ \(artifact.description)")
    } else {
      FormattedElement("❌ \(artifact.description)")
    }
  }

  @FormattedOutputBuilder
  static func formattedOutput(of action: Action, in stepState: StepState) -> [FormattedElement] {
    if stepState.completedActions.contains(action) {
      FormattedElement("✅ \(action.name)")
    } else {
      FormattedElement("❌ \(action.name)")
    }
  }
}

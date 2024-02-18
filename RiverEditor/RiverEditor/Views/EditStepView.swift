import SwiftUI
import RiverKit
import Goose

struct EditStepView: View {
  enum Sheet: Identifiable {
    case selectDependency
    case selectActionOutput(action: Action)
    
    var id: String {
      switch self {
      case .selectDependency:
        return "select_dependency"
      case .selectActionOutput(let action):
        return "select_\(action.id)"
      }
    }
  }
  
  @Binding
  var step: Step
  
  @Binding
  var flow: Flow
  
  @State
  var sheet: Sheet?
  
  let title = "Edit Step"
  
  var body: some View {
    Form {
      TextField("Name", text: $step.name)
      Section("Actions") {
        AddActionView(flow: flow) { action in
          step.actions.append(action)
        }
        ForEach($step.actions) { action in
          HStack {
            EditActionView(action: action, flow: $flow)
            Spacer()
            DeleteButton(item: action.wrappedValue, array: $step.actions)
          }
        }
      }
      Section("Dependencies") {
        AddDependencyView(flow: flow) { artifactID in
          step.dependencyIDs.append(artifactID)
        }
        if let dependencies = try? step.dependencies(in: flow) {
          ForEach(dependencies) { artifact in
            HStack {
              Text(artifact.fileName)
              Spacer()
              DeleteButton(item: artifact.id, array: $step.dependencyIDs)
            }
          }
        } else {
          Text("Error loading dependencies.")
        }
      }
      DeleteButton(item: step, array: $flow.steps)
    }
    .formStyle(.grouped)
    .navigationTitle(title)
    .sheet(item: $sheet) { sheet in
      switch sheet {
      case .selectDependency:
        SelectArtifactView(artifacts: flow.artifacts) { selected in
          step.dependencyIDs.append(selected.id)
        }
        .asSheet()
      case .selectActionOutput(let action):
        SelectArtifactView(artifacts: flow.artifacts) { selected in
          guard let stepAction = step.actions.item(with: action.id) else { return }
            
          switch stepAction {
          case .collect(let collectionAction):
            var newAction = collectionAction
            newAction.outputArtifactID = selected.id
            step.actions.update(.collect(newAction))
          case .execute(let executeAction):
            var newAction = executeAction
            newAction.outputArtifactID = selected.id
            step.actions.update(.execute(newAction))
          }
        }        
        .asSheet()
      }
    }
  }
}

import SwiftUI
import RiverKit
import Goose
import BlueJay

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
      Section {
        TextField("Name", text: $step.name)
      }
      Section("Dependencies") {
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
      Section("Add Dependency") {
        AddDependencyView(step: step, flow: flow) { artifactID in
          step.dependencyIDs.append(artifactID)
        }
      }
      Section("Actions") {
        ForEach($step.actions) { action in
          HStack {
            EditActionView(action: action, flow: $flow)
            Spacer()
            DeleteButton(item: action.wrappedValue, array: $step.actions)
          }
        }
      }
      Section("Add Action") {
        AddActionView(flow: flow) { action in
          step.actions.append(action)
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
        .asSheet(configuration: .cancel)
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
        .asSheet(configuration: .cancel)
      }
    }
  }
}

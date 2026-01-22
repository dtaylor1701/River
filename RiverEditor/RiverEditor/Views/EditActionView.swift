import SwiftUI
import RiverKit

struct EditActionView: View {
  @Binding
  var action: Action
  
  @Binding
  var flow: Flow
  
  var body: some View {
    Section {
      switch action {
      case .collect(let collectAction):
        EditCollectAction(containingAction: $action, action: collectAction, flow: $flow)
      case .execute(let executeAction):
        EditExecuteAction(containingAction: $action, action: executeAction, flow: $flow)
      }
    }
  }
}

struct EditCollectAction: View {
  @Binding
  var containingAction: Action
  
  @State
  var action: CollectAction
  
  @Binding
  var flow: Flow
  
  var body: some View {
    Section {
      TextField("Name", text: $action.name)
      ArtifactPicker(artifacts: flow.artifacts, artifactID: $action.outputArtifactID)
    }
    .onChange(of: action) {
      containingAction = .collect(action)
    }
  }
}

struct EditExecuteAction: View {
  @Binding
  var containingAction: Action
  
  @State
  var action: ExecuteAction
  
  @Binding
  var flow: Flow
  
  var body: some View {
    Section {
      TextField("Name", text: $action.name)
      ArtifactPicker(artifacts: flow.artifacts, artifactID: $action.outputArtifactID)
      TextField("Executable Path", text: $action.executablePath)
      ArgumentsView(arguments: $action.arguments)
    }
    .onChange(of: action) {
      containingAction = .execute(action)
    }
  }
}

struct ArgumentsView: View {
  @Binding
  var arguments: [String]
  
  var body: some View {
    List {
      Button {
        arguments.append("")
      } label: {
        Image(systemName: "plus")
      }
      ForEach($arguments) { argument in
        TextField("value", text: argument)
      }
    }
  }
}

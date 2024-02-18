
import Foundation
import SwiftUI
import RiverKit

struct ActionTypePicker: View {
  enum ActionType: String, Identifiable {
    case collect, execute
    
    var id: String {
      rawValue
    }
    
    var displayValue: String {
      switch self {
      case .collect:
        return "Collect"
      case .execute:
        return "Execute"
      }
    }
  }
  
  let actionTypes: [ActionType] = [.collect, .execute]
  
  @Binding
  var actionType: ActionType
    
  var body: some View {
    Picker("Action Type", selection: $actionType) {
      ForEach(actionTypes) { actionType in
        Text(actionType.displayValue)
          .tag(actionType)
      }
    }
  }
}

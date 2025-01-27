//
//  NativeCustomButton.swift
//  CustomButton
//
//  Created by ahmed hussien on 27/01/2025.
//

import SwiftUI


struct TestView: View {
  @State private var isDisabled = false
  @State private var applyTint = false
  @State private var actionTaken = ""


  var body: some View {
    List {
      customButtonsView
      borderedButtonView
      buttonRolesView
      buttonShapesView
      buttonSizesView
    }
    .navigationTitle("Button Styles")
    .navigationBarTitleDisplayMode(.inline)
  }

  private var borderedButtonView: some View {
    Section {
      Button {
      } label: {
        Text("Bordered Prominent")
      }
      .buttonStyle(.borderedProminent)

      Button {
      } label: {
        Text("Bordered")
      }
      .buttonStyle(.bordered)

      Button {
      } label: {
        Text("Borderless")
      }
      .buttonStyle(.borderless)
        
    } header: {
      Text("Bordered Buttons")
    } footer: {
      Toggle(isOn: $applyTint) {
        Label("Apply Tint", systemImage: "paintbrush")
      }
    }
    .tint(applyTint ? .mint : .primary)
  }

  private var customButtonsView: some View {
    Section {
        
        Button {
        } label: {
            Text("SolidButton")
                .frame(width: 100)
        }
        .buttonStyle(.SolidButton)
        .disabled(isDisabled)
        
        Button {
        } label: {
            Text("BorderButton")
                .frame(width: 300)
        }
        .buttonStyle(.BorderButton)
        .disabled(isDisabled)
        
        
        Button {
        } label: {
            Text("PlainButton")
        }
        .buttonStyle(.PlainButton)
        .disabled(isDisabled)

        
    } header: {
      Text("Custom Buttons")
    } footer: {
      Toggle(isOn: $isDisabled) {
        Label("Disable Buttons", systemImage: "checkmark.circle.fill")
      }
    }
  }

  private var buttonRolesView: some View {
    Section {
      Button(role: .destructive) {
      } label: {
        Text("Destructive")
      }
      .swipeActions {
        Button(role: .destructive) {
          actionTaken = "Remove"
        } label: {
          Label("Remove", systemImage: "trash")
        }
        Button(role: .cancel) {
          actionTaken = "Add"
        } label: {
          Label("Add", systemImage: "plus")
        }
        Button {
          actionTaken = "Share"
        } label: {
          Label("Share", systemImage: "square.and.arrow.up")
        }
        .tint(.mint)
      }

        Button(role: .cancel) {
      } label: {
        Text("Cancel")
      }
    } header: {
      Text("Button Roles")
    } footer: {
      Text("Action Taken: \(actionTaken)")
    }
  }

  private var buttonShapesView: some View {
    Section {
      HStack {
        Button {
        } label: {
          Text("Rounded")
        }
        .buttonBorderShape(.roundedRectangle)

        Button {
        } label: {
          Text("Custom Radius")
        }
        .buttonBorderShape(.roundedRectangle(radius: 12))

        Button {
        } label: {
          Text("Capsule")
        }
        .buttonBorderShape(.capsule)
      }
    } header: {
      Text("Button Shapes")
    }
    .buttonStyle(.bordered)
  }

  private var buttonSizesView: some View {
    Section {
      HStack {
        Button {
        } label: {
          Text("Mini")
        }
        .controlSize(.mini)

        Button {
        } label: {
          Text("Small")
        }
        .controlSize(.small)

        Button {
        } label: {
          Text("Regular")
        }
        .controlSize(.regular)

        Button {
        } label: {
          Text("Large")
        }
        .controlSize(.large)
      }
    } header: {
      Text("Button Sizes")
    }
    .buttonStyle(.bordered)
  }

}

struct KitchenSinkView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
        TestView()
    }
  }
}

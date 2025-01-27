//
//  ButtonStyleExtentions.swift
//  CustomButton
//
//  Created by ahmed hussien on 27/01/2025.
//

import SwiftUI



//MARK:  SolidButton
struct SolidButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body)
            .foregroundColor(isEnabled ? .white : .gray.opacity(0.8))
            .padding()
            .background(backgroundView(configuration))
    }
    
    @ViewBuilder private func backgroundView( _ configuration: Configuration) -> some View {
        Capsule()
            .strokeBorder( isEnabled ? .clear : .gray , lineWidth: 2 )
            .background( Capsule().fill( isEnabled ? Color("Mainbutton") : Color("bgDisabledButton") ) )
    }
    
}
extension ButtonStyle where Self == SolidButtonStyle {
    static var SolidButton: SolidButtonStyle { .init() }
}

//MARK: BorderButton
struct BorderButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body)
            .foregroundColor(isEnabled ? Color("Mainbutton") : .gray.opacity(0.8))
            .padding()
            .background(backgroundView(configuration))
    }
    
    @ViewBuilder private func backgroundView( _ configuration: Configuration) -> some View {
        Capsule()
            .strokeBorder( isEnabled ? Color("Mainbutton") : .gray.opacity(0.8) , lineWidth: 1 )
    }
    
}
extension ButtonStyle where Self == BorderButtonStyle {
    static var BorderButton: BorderButtonStyle { .init() }
}

//MARK: PlainButton
struct PlainButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body)
            .foregroundColor(isEnabled ? Color("Mainbutton") : .gray.opacity(0.8))
            .padding()
            .background(backgroundView(configuration))
    }
    
    @ViewBuilder private func backgroundView( _ configuration: Configuration) -> some View {
        Capsule()
            .strokeBorder( isEnabled ? Color("Mainbutton") : .gray.opacity(0.8) , lineWidth: 1 )
    }
    
}

extension ButtonStyle where Self == PlainButtonStyle {
    static var PlainButton: PlainButtonStyle { .init() }
}



//struct GradientStyle: ButtonStyle {
//  @Environment(\.isEnabled) private var isEnabled
//  private let colors: [Color]
//
//  init(colors: [Color] = [.mint.opacity(0.6), .mint, .mint.opacity(0.6), .mint]) {
//    self.colors = colors
//  }
//
//  func makeBody(configuration: Configuration) -> some View {
//    HStack {
//      configuration.label
//    }
//    .font(.body.bold())
//    .foregroundColor(isEnabled ? .white : .black)
//    .padding()
//    .frame(height: 44)
//    .background(backgroundView(configuration: configuration))
//    .cornerRadius(10)
//  }
//
//  @ViewBuilder private func backgroundView(configuration: Configuration) -> some View {
//    if !isEnabled {
//      disabledBackground
//    }
//    else if configuration.isPressed {
//      pressedBackground
//    } else {
//      enabledBackground
//    }
//  }
//
//  private var enabledBackground: some View {
//    LinearGradient(
//      colors: colors,
//      startPoint: .topLeading,
//      endPoint: .bottomTrailing)
//  }
//
//  private var disabledBackground: some View {
//    LinearGradient(
//      colors: [.gray],
//      startPoint: .topLeading,
//      endPoint: .bottomTrailing)
//  }
//
//  private var pressedBackground: some View {
//    LinearGradient(
//      colors: colors,
//      startPoint: .topLeading,
//      endPoint: .bottomTrailing)
//    .opacity(0.4)
//  }
//}
//
//extension ButtonStyle where Self == GradientStyle {
//  static var gradient: GradientStyle { .init() }
//}

//
//  ContentView.swift
//  CustomButton
//
//  Created by ahmed hussien on 26/01/2025.
//

import SwiftUI


struct AppTest : View {
    var body: some View {
        List {
            Section("normal"){
                AppButton(state: .constant(.normal), style: .plain, action: {}) {
                    Text("Button")
                }
                
                AppButton(state: .constant(.normal), style: .stroke(), action: {}) {
                    Text("Button")
                }
                
                AppButton(state: .constant(.normal), style: .solid(), action: {}) {
                    Text("Button")
                }
            }
            
            
            Section("disabled"){
                AppButton(state: .constant(.disabled), style: .plain, action: {}) {
                    Text("Button")
                }
                
                AppButton(state: .constant(.disabled), style: .stroke(), action: {}) {
                    Text("Button")
                }
                
                AppButton(state: .constant(.disabled), style: .solid(), action: {}) {
                    Text("Button")
                }
            }
            
        }
        .listStyle(.sidebar)
        .navigationTitle("Button Test")
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    NavigationView {
        AppTest()
    }
}

struct AppButton<Content: View>: View {
    
    @Binding var state: ButtonState
    let style: ButtonStyles
    var action: () -> () = {}
    let content: Content
    
    public init(
        state: Binding<ButtonState>,
        style: ButtonStyles = .solid(),
        action: @escaping () -> Void,
        @ViewBuilder builder: () -> Content
    ) {
        self._state = state
        self.style = style
        self.action = action
        self.content = builder()
    }
    
    // Getter Attributes
    private var styleConfig: ButtonStyleConfig {
        return style.styleConfig
    }
    
    private var isDisabled: Bool {
        return state == .disabled
    }
    
    private var isLoading: Bool {
        return state == .loading
    }
    
    //MARK: View
    var body: some View {
        Button {
            action()
        } label: {
            
            switch style {
            case .stroke, .solid:
                strokeAndSolidContentView
                
            default:
                plainContentView
            }
            
        }
        .disabled(isDisabled || isLoading)
        .animation(.easeInOut, value: state)
    }
    
    //MARK: Stroke And Solid Views
    private var strokeAndSolidContentView: some View {
        content
            .opacity(isLoading ? 0.0 : 1.0)
            .frame(maxWidth: .infinity)
            .foregroundColor(isDisabled ? styleConfig.disabledForegroundColor : styleConfig.foregroundColor)
            .padding(styleConfig.paddingValue)
            .background(strokeAndSolidBackgroundView)
    }
    
    private var strokeAndSolidBackgroundView: some View {
        GeometryReader(content: { geometry in
            ZStack(alignment: .center) {
                backgroundView
                    .frame(width: isLoading ? geometry.size.height : nil, alignment: .center)
                    .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
                
                if isLoading {
                    loaderView
                        .padding(10)
                }
            }
        })
    }
    
    //MARK: Plain View
    @ViewBuilder private var plainContentView: some View {
        switch state {
        case .normal:
            content
                .foregroundColor(.blue)
        
        case .loading:
            loaderView
                .frame(height: 30)
                .aspectRatio(1, contentMode: .fit)
            
        case .disabled:
            content
                .foregroundColor(styleConfig.disabledForegroundColor)
        }
    }
    
    //MARK: Background View
    @ViewBuilder private var backgroundView: some View {
        
        switch styleConfig.cornerStyle {
        case .ellipse:
            Capsule()
                .strokeBorder(
                    isDisabled ? styleConfig.disableBorderColor : styleConfig.borderColor,
                    lineWidth: styleConfig.borderWidth
                )
                .background(Capsule().fill(isDisabled ? styleConfig.disabledBackgroundColor : styleConfig.backgroundColor))
            
        case .cornerRadius(radius: let radius):
            RoundedRectangle(cornerRadius: radius)
                .strokeBorder(isDisabled ? styleConfig.disableBorderColor : styleConfig.borderColor, lineWidth: styleConfig.borderWidth)
                .background(RoundedRectangle(cornerRadius: radius).fill(isDisabled ? styleConfig.disabledBackgroundColor : styleConfig.backgroundColor))
            
        case .rectangle:
            Rectangle()
                .strokeBorder(isDisabled ? styleConfig.disableBorderColor : styleConfig.borderColor, lineWidth: styleConfig.borderWidth)
                .background(Rectangle().fill(isDisabled ? styleConfig.disabledBackgroundColor : styleConfig.backgroundColor))
        }
    }
    
    //MARK: Loader View
    private var loaderView: some View {
        CircularLoaderView(strokeColor: styleConfig.loaderColor, strokeWidth: styleConfig.loaderStrokeWidth)
    }
    
}


enum ButtonState {
    case normal
    case disabled
    case loading
}



enum ButtonStyles {
    case stroke(
        primaryColor: Color = .blue,
        paddingValue: CGFloat = 12
    )
    case solid(
        textColor: Color = .white,
        backgroundColor: Color = .blue,
        paddingValue: CGFloat = 12
    )
    case plain
    case custom(config: ButtonStyleConfig)
}


extension ButtonStyles {
    var styleConfig: ButtonStyleConfig {
        switch self {
            
        case .stroke(let primaryColor,let paddingValue):
            return ButtonStyleConfig(
                foregroundColor: primaryColor,
                backgroundColor: .clear,
                cornerStyle: .ellipse,
                paddingValue: paddingValue,
                borderColor: primaryColor,
                borderWidth: 2,
                disabledForegroundColor: .gray,
                disabledBackgroundColor: .clear,
                disableBorderColor: .gray
            )
            
        case .solid(let textColor, let backgroundColor,let paddingValue):
            return ButtonStyleConfig(
                foregroundColor: textColor,
                backgroundColor: backgroundColor,
                cornerStyle: .ellipse,
                paddingValue: paddingValue,
                borderColor: .clear,
                borderWidth: 0,
                disabledForegroundColor: textColor,
                disabledBackgroundColor: .gray,
                disableBorderColor: .clear
            )
            
        case .plain:
            return ButtonStyleConfig(
                foregroundColor: .blue,
                backgroundColor: .clear,
                cornerStyle: .ellipse,
                borderColor: .clear,
                borderWidth: 0,
                disabledForegroundColor: .gray,
                disabledBackgroundColor: .clear,
                disableBorderColor: .clear
            )
            
        case .custom(config: let config):
            return config
        }
    }
}


struct ButtonStyleConfig {
    // Button Style
    public var foregroundColor: Color
    public var backgroundColor: Color
    public var cornerStyle: CornerStyle
    public var paddingValue: CGFloat = 12
    
    // Stroke Style
    public var borderColor: Color
    public var borderWidth: CGFloat
    
    // Loading View Style
    public var loaderColor: Color = .blue
    public var loaderStrokeWidth: CGFloat = 2
    
    // Disable Style
    public var disabledForegroundColor: Color
    public var disabledBackgroundColor: Color
    public var disableBorderColor: Color
}

enum CornerStyle {
    case ellipse
    case cornerRadius(radius: CGFloat)
    case rectangle
}



struct CircularLoaderView: View {
    @State private var isLoading = false
    var strokeColor: Color = .accentColor
    var strokeWidth: CGFloat = 2.0
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(strokeColor, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round, lineJoin: .round))
            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
            .animation(Animation.default.repeatForever(autoreverses: false), value: isLoading)
            .onAppear() {
                self.isLoading = true
            }
    }
}

//struct CircularLoaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        CircularLoaderView()
//            .frame(width: 50, height: 50)
//    }
//}

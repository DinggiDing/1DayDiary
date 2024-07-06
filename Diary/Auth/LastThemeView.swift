//
//  LastThemeView.swift
//  Diary
//
//  Created by 성재 on 5/15/24.
//

import SwiftUI

struct LastThemeView: View {

    @State var selectedOption: fontOption? = .a
    @AppStorage("MyfontValue") private var fontvalue: String = "Arita-buri-Medium_OTF"
    @AppStorage("MyTitlefontValue") private var titlefontvalue: String = "Arita-buri-Bold_OTF"

    
    var body: some View {
        Form {
            fontradioButton(tag: .a, selection: $selectedOption, label: "Aritaburi", font: "Arita-buri-Medium_OTF")
            fontradioButton(tag: .b, selection: $selectedOption, label: "NotoSans", font: "NotoSansKR-Light")
            fontradioButton(tag: .c, selection: $selectedOption, label: "SUITE", font: "SUITE-Light")
            fontradioButton(tag: .d, selection: $selectedOption, label: "RIDIBatang", font: "RIDIBatang")
        }
        .background(Color.ivory1)
        .scrollContentBackground(.hidden)
        .onChange(of: selectedOption) {
            switch selectedOption {
            case .a:
                fontvalue = "Arita-buri-Medium_OTF"
                titlefontvalue = "Arita-buri-Bold_OTF"
                
            case .b:
                fontvalue = "NotoSansKR-Light"
                titlefontvalue = "NotoSansKR-Medium"

            case .c:
                fontvalue = "SUITE-Light"
                titlefontvalue = "SUITE-Medium"

            case .d:
                fontvalue = "RIDIBatang"
                titlefontvalue = "RIDIBatang"

            default:
                break
            }
        }
        .onAppear {
            switch fontvalue {
            case "Arita-buri-Medium_OTF":
                selectedOption = .a
            case "NotoSansKR-Light":
                selectedOption = .b
            case "SUITE-Light":
                selectedOption = .c
            case "RIDIBatang":
                selectedOption = .d
            default:
                break
            }
        }
    }
}

struct fontradioButton: View {
    @Binding private var isSelected: Bool
    private let label: String
    private let font: String
    @State private var animate: Bool = false
    
    init(isSelected: Binding<Bool>, label: String = "", font: String = "") {
      self._isSelected = isSelected
      self.label = label
        self.font = font
    }
    
    // To support multiple options
    init<V: Hashable>(tag: V, selection: Binding<V?>, label: String = "", font: String = "") {
          self._isSelected = Binding(
            get: { selection.wrappedValue == tag },
            set: { _ in selection.wrappedValue = tag }
          )
        self.label = label
        self.font = font
    }

    var body: some View {
        Section {
            HStack {
                Circle()
                       .fill(innerCircleColor) // Inner circle color
                       .animation(.easeInOut(duration: 0.15), value: isSelected)
                       .padding(4)
                       .overlay(
                          Circle()
                            .stroke(outlineColor, lineWidth: 1)
                        ) // Circle outline
                       .frame(width: 20, height: 20)
                       .keyframeAnimator(
                            initialValue: AnimationProperties(), trigger: animate,
                            content: { content, value in
                                content
                                    .scaleEffect(value.scaleValue)
                            },
                            keyframes: { _ in
                              KeyframeTrack(\.scaleValue) {
                                CubicKeyframe(0.9, duration: 0.05)
                                CubicKeyframe(1.10, duration: 0.15)
                                CubicKeyframe(1, duration: 0.25)
                            }
                          })
                       .onChange(of: isSelected) { _, newValue in
                          if newValue == true {
                              animate.toggle()
                          }
                      }
                Text(label)
                    .font(.custom(font, size: 16))
                    .padding()
                Spacer()
                Rectangle().foregroundStyle(.white)
            }
            .foregroundStyle(.black)
        }.listRowBackground(Color.white)
        .onTapGesture { isSelected = true }
    }
}

private extension fontradioButton {
   var innerCircleColor: Color {
      return isSelected ? Color.blue : Color.clear
   }

   var outlineColor: Color {
      return isSelected ? Color.blue : Color.gray
   }
}

struct AnimationProperties {
    var scaleValue: CGFloat = 1.0
}

enum fontOption {
    case a
    case b
    case c
    case d
}

#Preview {
    LastThemeView()
}

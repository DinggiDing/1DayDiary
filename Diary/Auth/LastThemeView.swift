//
//  LastThemeView.swift
//  Diary
//
//  Created by 성재 on 5/15/24.
//

import SwiftUI

struct LastThemeView: View {

    @Environment(\.locale) var locale: Locale

    @State var selectedOption: Country.FontOption? = .a
    @AppStorage("MyfontValue") private var fontvalue: String = "Arita-buri-Medium_OTF"
    @AppStorage("MyTitlefontValue") private var titlefontvalue: String = "Arita-buri-Bold_OTF"

    
    var body: some View {
        Form {
            fontradioButton(tag: .a, selection: $selectedOption, font: FontManager.getFont(option: .a, type: .body, locale: locale))
            fontradioButton(tag: .b, selection: $selectedOption, font: FontManager.getFont(option: .b, type: .body, locale: locale))
            fontradioButton(tag: .c, selection: $selectedOption, font: FontManager.getFont(option: .c, type: .body, locale: locale))
            fontradioButton(tag: .d, selection: $selectedOption, font: FontManager.getFont(option: .d, type: .body, locale: locale))
        }
        .background(Color.ivory1)
        .scrollContentBackground(.hidden)
        .onChange(of: selectedOption) {
            fontvalue = FontManager.getFont(option: selectedOption ?? .a, type: .body, locale: locale)
            titlefontvalue = FontManager.getFont(option: selectedOption ?? .a, type: .title, locale: locale)
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
            case "NotoSerifJP-Light":
                selectedOption = .a
            case "NotoSansJP-Light":
                selectedOption = .b
            case "IBMPlexSansJP-Light":
                selectedOption = .c
            case "ZenMaruGothic-Light":
                selectedOption = .d
            default:
                break
            }
        }
    }
}

struct fontradioButton: View {
    @Binding private var isSelected: Bool
//    private let label: String
    private let font: String
    @State private var animate: Bool = false
    
//    init(isSelected: Binding<Bool>, label: String = "", font: String = "") {
//      self._isSelected = isSelected
//      self.label = label
//        self.font = font
//    }
    
    // To support multiple options
    init<V: Hashable>(tag: V, selection: Binding<V?>, font: String = "") {
          self._isSelected = Binding(
            get: { selection.wrappedValue == tag },
            set: { _ in selection.wrappedValue = tag }
          )
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
                Text(gettextfromFont(font: font))
                    .font(.custom(font, size: 16))
                    .lineLimit(1)
                    .padding()
                Spacer()
                Rectangle().foregroundStyle(.white)
            }
            .foregroundStyle(.black)
        }.listRowBackground(Color.white)
        .onTapGesture { isSelected = true }
    }
    
    private func gettextfromFont(font: String) -> String {
        let components = font.split(separator: "-")
        return String(components[0])
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

//enum fontOption {
//    case a
//    case b
//    case c
//    case d
//}

#Preview {
    LastThemeView()
}

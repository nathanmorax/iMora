//
//  ViewModifiers.swift
//  iMora
//
//  Created by Jonathan Mora on 05/06/25.
//

import SwiftUI

// MARK: -  ViewModifiers Text
struct TitleSectionHeaderViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .bold()
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding(.bottom, 10)
    }
}

struct TitleInfoViewModifier: ViewModifier {
        
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .bold()
            .foregroundColor(.black)
            .padding(.bottom, 42)
    }
}

struct SubtitleInfoViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundColor(.gray)
    }
}

struct DescriptionsViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundColor(.black)
            .fixedSize(horizontal: false, vertical: true)
    }
}

extension Text {
    func titleSectionHeader() -> some View {
        self.modifier(TitleSectionHeaderViewModifier())
    }
    
    func titleInfo() -> some View {
        self.modifier(TitleInfoViewModifier())
    }
    
    func subtitleInfo() -> some View {
        self.modifier(SubtitleInfoViewModifier())
    }
    
    func descriptionsInfo() -> some View {
        self.modifier(DescriptionsViewModifier())
    }
    
    func prefixedWithSFSymbol(named name: String) -> some View {
        HStack {
            Image(systemName: name)
                .resizable()
                .scaledToFit()
                .frame(width: 17, height: 17)
            self
        }
        .padding(.horizontal, 16)
    }
}

//MARK: - TextEditor

struct EditorStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .disableAutocorrection(true)
            .scrollContentBackground(.hidden)
            .autocapitalization(.none)
            .foregroundColor(.white)
            .padding()
    }
}

extension View {
    func editorStyle() -> some View {
        self.modifier(EditorStyleModifier())
    }
}



// MARK: -  ViewModifiers Button


struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .bold()
            .foregroundStyle(.white)
            .background(Color.Button.primaryButton.opacity(0.7))
            .cornerRadius(12)
    }
}

struct ButtonXmarxStyle: ButtonStyle {
    var backgroundColor: Color = Color.gray.opacity(0.5)
    var foregroundColor: Color = .white
    var size: CGFloat = 32
    var shadowRadius: CGFloat = 8
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: size, height: size)
            .padding(8)
            .background(
                Circle()
                    .fill(backgroundColor.opacity(configuration.isPressed ? 0.3 : 1.0))
                    .shadow(color: .black.opacity(0.2), radius: shadowRadius)
            )
            .foregroundStyle(foregroundColor)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct HoverOptionsButtonStyle: ButtonStyle {
    var isSelected: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .font(.footnote)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(maxWidth: 190)
            .background(isSelected ? Color.Button.primaryButton : Color.gray.opacity(0.3))
            .cornerRadius(18)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}

struct FloatigButtonMenuStyle: ButtonStyle {
    
    var foregroundColor: Color = .white
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            //.resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .foregroundColor(foregroundColor)
            .padding(20)
            .background(
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 44, height: 44)
                    .cornerRadius(12)
                    .shadow(radius: 18)
            )
    }
}

// MARK: -  ViewModifiers View

struct CardRoundCorner: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 300, height: 400)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

extension View {
    public func cardRoundCorner() -> some View {
        modifier(CardRoundCorner())
    }
}


// MARK: - TabView

struct CustomTabViewStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .font(.body)
            .bold()
            .padding()
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .multilineTextAlignment(.center)
    }
}

extension View {
    func customTabViewStyle() -> some View {
        self.modifier(CustomTabViewStyle())
    }
}


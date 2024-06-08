//
//  AuthenticatedView.swift
//  Diary
//
//  Created by 성재 on 5/8/24.
//

import SwiftUI
import AuthenticationServices

// see https://michael-ginn.medium.com/creating-optional-viewbuilder-parameters-in-swiftui-views-a0d4e3e1a0ae
extension AuthenticatedView where Unauthenticated == EmptyView {
  init(@ViewBuilder content: @escaping () -> Content) {
    self.unauthenticated = nil
    self.content = content
  }
}

struct AuthenticatedView<Content, Unauthenticated>: View where Content: View, Unauthenticated: View {
  @StateObject private var viewModel = AuthenticationViewModel()
  @State private var presentingLoginScreen = false
    
    // MARK: - Core data
//    @StateObject private var manager: DataManager = DataManager()
    

  var unauthenticated: Unauthenticated?
  @ViewBuilder var content: () -> Content

  public init(unauthenticated: Unauthenticated?, @ViewBuilder content: @escaping () -> Content) {
    self.unauthenticated = unauthenticated
    self.content = content
  }

  public init(@ViewBuilder unauthenticated: @escaping () -> Unauthenticated, @ViewBuilder content: @escaping () -> Content) {
    self.unauthenticated = unauthenticated()
    self.content = content
  }

    @State var splash = false


  var body: some View {
    switch viewModel.authenticationState {
    case .unauthenticated, .authenticating:
        
      VStack {
        if let unauthenticated = unauthenticated {
          unauthenticated
        }
        else {
          Text("You're not logged in.")
        }

          VStack {
              Spacer()
              Button(action: {
                  viewModel.reset()
                  presentingLoginScreen.toggle()

              }, label: {
                  Text("Go to Login")
                      .foregroundStyle(Color.primary)
                      .frame(height: 40)
                      .frame(maxWidth: .infinity)
                      .contentShape(.capsule)
                      .background {
                          Capsule()
                              .stroke(Color.primary, lineWidth: 0.5)
                      }
                      .padding(.bottom, 40)
                      .padding(.horizontal, 15)
              })
          }
      }
      .sheet(isPresented: $presentingLoginScreen) {
        AppleSignView()
          .environmentObject(viewModel)
      }
    case .authenticated:
      VStack {
          NavigationLink(isActive: $splash, destination: {
              content()
                .environmentObject(viewModel)
          }, label: {
              ZStack {
                  HStack {
                      Rectangle().frame(width: 1, alignment: .center).padding(.leading, 28)
                          .foregroundStyle(.gray5)
                      Spacer()
                  }
                  HStack {
                      Spacer()
                      VStack {
                          Spacer()
                      HStack {
                              Text("Welcome to ...")
                                  .font(.custom("SUIT-Medium", size: 32))
                              Spacer()
                          }
                          HStack {
                              Text("1DayDiary")
                                  .font(.custom("SUIT-Bold", size: 46))
                                  .foregroundStyle(AngularGradient(gradient: Gradient(colors: [Color.mainpoint, Color.maingra]),
                                                                   center: .bottomLeading,
                                                                  angle: .degrees(0 + 45)))
                              Spacer()
                              
                          }
                          Spacer()
                          Spacer()
                          Spacer()
                      }
                      .foregroundStyle(.black)
                      Spacer()
                  }
                  .frame(width: 280)
              }

          })
        
//          .environmentObject(manager)
//          .environment(\.managedObjectContext, manager.container.viewContext)
      }
      .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
              splash = true
          }
      }
      .onReceive(NotificationCenter.default.publisher(for: ASAuthorizationAppleIDProvider.credentialRevokedNotification)) { event in
        viewModel.signOut()
        if let userInfo = event.userInfo, let info = userInfo["info"] {
          print(info)
        }
      }
    }
  }
}

//
//  AppleSignView.swift
//  Diary
//
//  Created by 성재 on 5/8/24.
//

import SwiftUI

import Combine
//import FirebaseAnalyticsSwift
import AuthenticationServices

private enum FocusableField: Hashable {
  case email
  case password
}

struct AppleSignView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.colorScheme) var scheme
    @Environment(\.dismiss) var dismiss

    @FocusState private var focus: FocusableField?

    var body: some View {
      VStack {
          
          ZStack {
              Image("tuto")
                  .resizable()
                  .scaledToFill()
                  .frame(width: AppConfig.homeWidth, height: AppConfig.homeHeaderArticleHeight)
                  .padding()
              
              VStack {
                  Spacer()
                  LinearGradient(colors: [Color.clear, Color.clear, Color.white], startPoint: .top, endPoint: .bottom)
              }
          }                  
          .frame(width: AppConfig.homeWidth, height: AppConfig.homeHeaderArticleHeight-15)
          .padding(.vertical, 15)

          
          ZStack {
              Color.white
              VStack {
                  Text("1DayDiary")
                      .font(.system(size: 46, weight: .semibold))
//                          .foregroundStyle(AngularGradient(gradient: Gradient(colors: [Color.mainpoint, Color.maingra]),
//                                                           center: .bottomLeading,
//                                                           angle: .degrees(0 + 45)))
                          .padding()
                  Text("Decorate your precious 24-hour records with fonts and photos, and store them securely with iCloud. Access past entries and analyze your memories with data insights!")
                      .font(.system(size: 12, weight: .light))
                      .padding()
                  Rectangle().frame(height: 2, alignment: .center).padding(.vertical, 0)
                      .padding(.horizontal, 15)
                      .foregroundStyle(.gray5)
//                  Spacer()
                  
                  SignInWithAppleButton(.signIn) { request in
                      viewModel.handleSignInWithAppleRequest(request)
                  } onCompletion: { result in
                      viewModel.handleSignInWithAppleCompletion(result)
                  }
                  .overlay {
                      ZStack {
                          Capsule()
                          HStack {
                              Image(systemName: "applelogo")
                              Text("Sign in with Apple")
                          }
                          .foregroundStyle(scheme == .dark ? .black : .white)
                      }
                      .allowsHitTesting(false)
                  }
                  .frame(height: 45)
                  .clipShape(.capsule)
              }          
              .frame(height: AppConfig.homeHeaderArticleHeight)

          }
          .frame(height: AppConfig.homeHeaderArticleHeight)

      }
      .listStyle(.plain)
      .padding()
    }
}

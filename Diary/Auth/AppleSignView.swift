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
          Spacer()

          HStack {
              Text("Sign In")
                  .font(.system(size: 56, weight: .semibold))
                  .padding()
              Spacer()
          }
          Rectangle().frame(height: 2, alignment: .center).padding(.vertical, 0)
              .padding(.horizontal, 15)
              .foregroundStyle(.gray5)
          Spacer()
        
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
      .listStyle(.plain)
      .padding()
    }
}

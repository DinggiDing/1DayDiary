//
//  DiaryApp.swift
//  Diary
//
//  Created by 성재 on 2/25/24.
//

import SwiftUI
import TipKit
import Firebase

@main
struct DiaryApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
//    // MARK: - Core data
    @StateObject private var manager: DataManager = DataManager()
    
    init() {
        try? Tips.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                AuthenticatedView {
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
                } content: {
                    MainView()
                        .environmentObject(manager)
                        .environment(\.managedObjectContext, manager.container.viewContext)
                }
            }.preferredColorScheme(.light)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Firebase Configured")
        return true
    }
}

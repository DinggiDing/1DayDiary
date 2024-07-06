//
//  LastView.swift
//  Diary
//
//  Created by 성재 on 5/8/24.
//

import SwiftUI
import LPNotiSys

struct LastView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) private var todos: FetchedResults<DB_core>
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    @State var presentingConfirmationDialog = false
    
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) var viewContext

    
    private func deleteAccount() {
      Task {
        if await viewModel.deleteAccount() == true {
          dismiss()
        }
      }
    }

    private func signOut() {
        viewModel.signOut()
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    LPNotiSysView()
                }
                .frame(width: AppConfig.homeWidth, height: AppConfig.homeHeight)
                VStack {
                    
                    VStack {
                        HStack {
                            Text("General")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.horizontal, 32)
                        
                        HStack {
                            Text("로그인 상태와 테마 변경하기")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                            Spacer()
                        }
                        .padding(.horizontal, 32)
                        .padding(.bottom, 4)
                    }
                    .padding(.top, 8)
                    
                    Form {
                        Section("로그인 상태") {
                            ZStack {
                                HStack {
                                    Image(systemName: "apple.logo")
                                        .padding()
                                    Text(viewModel.displayName)
                                    Spacer()
                                    Spacer()
                                }
                            }
                        }
                        
                        
                        Section("General") {
                            NavigationLink(destination: {
                                LastThemeView()
                            }, label: {
                                HStack {
                                    Text("Theme")
                                    Spacer()
                                }
                            })
                            
                            NavigationLink(destination: {
                                WebView(urlToLoad: "https://inquisitive-foe-bfb.notion.site/1-Day-Diary-7b5d10c66afc44b7ba422abb807d6f3c?pvs=4")
                            }, label:  {
                                HStack {
                                    Text("Help and FAQ")
                                    Spacer()
                                }
                            })
                            
                            NavigationLink(destination: {
                                WebView(urlToLoad: "https://inquisitive-foe-bfb.notion.site/b20d46ce575246a89a39dc9e2bef1fa8?pvs=4")
                            }, label: {
                                HStack {
                                    Text("Privacy policy")
                                    Spacer()
                                }
                            })
                            
                        }
                        //
                        //                    Section {
                        //                        Button(role: .destructive, action: deleteall) {
                        //                            HStack {
                        //                                Spacer()
                        //                                Text("Data Delete")
                        //                                Spacer()
                        //                            }
                        //                        }
                        //                    }
                        //
                        Section {
                            Button(role: .destructive, action: signOut) {
                                HStack {
                                    Spacer()
                                    Text("Sign out")
                                    Spacer()
                                }
                            }
                        }
                        
                        Section {
                            Button(role: .destructive, action: { presentingConfirmationDialog.toggle() }) {
                                HStack {
                                    Spacer()
                                    Text("Delete Account")
                                    Spacer()
                                }
                            }
                        }
                    }
                    .background(Color.ivory1)
                    .scrollContentBackground(.hidden)
                    
                    
                }
                .confirmationDialog("Deleting your account is permanent. Do you want to delete your account?",
                                    isPresented: $presentingConfirmationDialog, titleVisibility: .visible) {
                    Button("Delete Account", role: .destructive, action: deleteAccount)
                    Button("Cancel", role: .cancel, action: { })
                }
                .frame(width: AppConfig.homeWidth, height: AppConfig.homeHeight)
            }
            .background(Color.ivory1)
            .scrollIndicators(.hidden)
            .navigationTitle("Setting")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        
    }
    
    private func deleteall() {
        for todo in todos {
            self.viewContext.delete(todo)
        }
        do {
            try self.viewContext.save()
//            print("Todo deleted!")
        } catch {
            print("whoops \(error.localizedDescription)")
        }
    }
}

#Preview {
    LastView()
}

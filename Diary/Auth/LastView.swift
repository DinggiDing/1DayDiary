//
//  LastView.swift
//  Diary
//
//  Created by 성재 on 5/8/24.
//

import SwiftUI

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
            VStack {
                
                Spacer().frame(height: 10)
                Form {
                    
                    Section {
                        ZStack {
//                            RoundedRectangle(cornerRadius: 15.0).foregroundStyle(.black)
                            HStack {
                                Image(systemName: "apple.logo")
                                    .padding()
                                Text(viewModel.displayName)
                                Spacer()
                                Spacer()
                            }
                            .foregroundStyle(.white)
                        }
                    }
                    .listRowBackground(Color.blackblue55)


                    Section("General") {
                        NavigationLink(destination: {
                            LastThemeView()
                        }, label: {
                            HStack {
                                Text("Theme")
                                Spacer()
//                                Image(systemName: "chevron.forward")
                            }
                        })
                        
                        NavigationLink(destination: {
                            WebView(urlToLoad: "https://inquisitive-foe-bfb.notion.site/1-Day-Diary-7b5d10c66afc44b7ba422abb807d6f3c?pvs=4")
                        }, label:  {
                            HStack {
                                Text("Help and FAQ")
                                Spacer()
    //                            Image(systemName: "chevron.forward")
                            }
                        })
                        
                        NavigationLink(destination: {
                            WebView(urlToLoad: "https://inquisitive-foe-bfb.notion.site/b20d46ce575246a89a39dc9e2bef1fa8?pvs=4")
                        }, label: {
                            HStack {
                                Text("Privacy policy")
                                Spacer()
//                                Image(systemName: "chevron.forward")
                            }
                        })
                        
                    }
                    .listRowBackground(Color.ivory1)
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
//                    .listRowBackground(Color.ivory1)
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
                    .listRowBackground(Color.ivory1)

                    Section {
                        Button(role: .destructive, action: { presentingConfirmationDialog.toggle() }) {
                            HStack {
                                Spacer()
                                Text("Delete Account")
                                Spacer()
                            }
                        }
                    }
                    .listRowBackground(Color.ivory1)

                }
                .scrollContentBackground(.hidden)

                
            }
            .background(.white)
            .navigationTitle("Profile")
            .confirmationDialog("Deleting your account is permanent. Do you want to delete your account?",
                                isPresented: $presentingConfirmationDialog, titleVisibility: .visible) {
                Button("Delete Account", role: .destructive, action: deleteAccount)
                Button("Cancel", role: .cancel, action: { })
            }
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

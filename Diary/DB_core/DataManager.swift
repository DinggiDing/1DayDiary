//
//  DataManager.swift
//  Diary
//
//  Created by 성재 on 3/2/24.
//

import Foundation
import CoreData

// Main data manager to handle the DB_core items
class DataManager: NSObject, ObservableObject {
    
    @Published var todos: [DB_core] = [DB_core]()
    
    // Add the Core Data container with the model name
//    let container: NSPersistentContainer = NSPersistentContainer(name: "Diarydb")
        let container: NSPersistentCloudKitContainer = NSPersistentCloudKitContainer(name: "Diarydb")

    
    // Default init method. Load the Core Data container
    override init() {
        super.init()
        container.loadPersistentStores { _, _ in }
        
    //        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy // in-memory와 영구 저장소 merge 충돌: in-memory우선
    //               container.viewContext.shouldDeleteInaccessibleFaults = true // 접근 불가의 결함들을 삭제할 수 있게끔 설정
    //               container.viewContext.automaticallyMergesChangesFromParent = true // parent의 context가 바뀌면 자동으로 merge되는 설정
    }
}

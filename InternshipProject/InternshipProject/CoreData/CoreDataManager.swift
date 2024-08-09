//
//  CoreDataManager.swift
//  InternshipProject
//
//  Created by 원동진 on 8/8/24.
//

import Foundation
import CoreData

// MARK: - CoreDataManager

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {}
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

// MARK: - func

extension CoreDataManager {
    func addUser(email: String, name: String, nickname: String) { // 회원가입
        let user = User(context: context)
        
        user.email = email
        user.name = name
        user.nickname = nickname
        
        saveContext()
        print("회원가입이 완료되었습니다.")
    }
    
    func isUserExist(email: String) throws-> Bool { // 회원가입한 유저인지 조회
        let fetchRequest = fetchRequestUser(email: email)
        
        do {
            let userListCount = try context.count(for: fetchRequest)
            
            return userListCount > 0
        } catch {
            throw CoreDataError.fetchFailed(reason: error.localizedDescription)
        }
    }
    
    func removeUserAccount(email: String) throws { // 회원 탈퇴
        let fetchRequest = fetchRequestUser(email: email)
        
        do {
            guard let user = try context.fetch(fetchRequest).first else { return }
            context.delete(user)
            
            saveContext()
            print("회원탈퇴가 완료되었습니다.")
        } catch {
            throw CoreDataError.fetchFailed(reason: error.localizedDescription)
        }
    }
    
    func getSaveCoredataPath() { // CoreData 파일 저장 경로 얻는 함수
        if let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            print("Documents Directory: \(documentsDirectoryURL)")
        }
    }
    
    func getUserInfo(email: String) throws->  User? { // 회원 탈퇴
        let fetchRequest = fetchRequestUser(email: email)
        
        do {
            let user = try context.fetch(fetchRequest).first
            
            return user
        } catch {
            throw CoreDataError.fetchFailed(reason: error.localizedDescription)
        }
    }
}

// MARK: - Private Method

extension CoreDataManager {
    private func saveContext() { // 변경 사항 저장
        if context.hasChanges {
            do {
                try context.save()
                print("변경사항이 저장되었습니다.")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func fetchRequestUser(email: String) -> NSFetchRequest<User> {
        let fetchRequest = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        return fetchRequest
    }
}


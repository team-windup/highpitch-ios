//
//  Actions.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/2/24.
//

import Foundation
import AVFoundation

enum Links {
    case recording
    case searchProject
    case notification
    case projectDetail
}

protocol ProjectUseCase {
    func fetchs() -> [ProjectModel]
    func update(_ item: ProjectModel) // ID로 변경하는게 좋을듯
    func delete(_ item: ProjectModel)
    func deleteAll()
    func add(_ item: ProjectModel)
    func search(name: String) -> [ProjectModel]
}

protocol PracticeUseCase {
    func fetchs() -> [PracticeModel]
    func update(_ item: PracticeModel)
    func delete(_ id: String)
    func deleteAll()
    func add(_ item: PracticeModel)
    func remark(_ id: String)
    func requestMedia(_ id: String, type: PracticeMedia)
    func requestAnalysis(_ id: String) -> PracticeAnalysis
}

protocol AnlaysisUseCase {
    func analysis(media: URL) -> PracticeAnalysis
}

protocol UserUseCase {
    func signIn(email: String, password: String)
    func signUp(email: String, password: String)
    func signOut()
    func leave()
    func updateBenchmark(_ userSpm: UserSpm)
    func updateProfile(image: URL)
    func updatePassword(password: String)
}

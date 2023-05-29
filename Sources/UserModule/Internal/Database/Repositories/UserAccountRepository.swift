//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 02. 24..
//

import Vapor
import Fluent
import FeatherCore

struct UserAccountRepository: FeatherModelRepository {
    typealias DatabaseModel = UserAccountModel

    public private(set) var db: Database
    
    init(_ db: Database) {
        self.db = db
    }
}

extension UserAccountRepository {

    func query(_ email: String) -> QueryBuilder<DatabaseModel> {
        query().filter(\.$email == email.lowercased())
    }
    
    func find(_ email: String) async throws -> DatabaseModel? {
        try await query(email).first()
    }

    func roleIds(_ accountId: UUID) async throws -> [UUID] {
        try await UserAccountRoleModel.query(on: db).filter(\.$accountId == accountId).all().map(\.roleId)
    }
    
    func update(roleIds: [UUID], accountId: UUID) async throws {
        try await UserAccountRoleModel.query(on: db).filter(\.$accountId == accountId).delete()
        try await roleIds.map { UserAccountRoleModel(accountId: accountId, roleId: $0) }.create(on: db)
    }
    
    func lastAccess(_ accountId: UUID) async throws -> Date? {
        try await UserTokenModel.query(on: db)
            .filter(\.$accountId == accountId)
            .sort(\.$lastAccess, .descending)
            .first()?.lastAccess
    }
}

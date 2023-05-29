//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 19..
//

import Vapor
import Fluent
import FeatherCore
import FeatherObjects
import UserObjects

struct UserAccountTokenAuthenticator: AsyncBearerAuthenticator {

    func authenticate(bearer: BearerAuthorization, for req: Request) async throws {
        guard let token = try await UserTokenModel.query(on: req.db).filter(\.$value == bearer.token).first() else {
            return
        }
        let now = Date()
        guard token.expiration > now else {
            return
        }
        guard let user = try await req.user.account.repository.get(token.accountId) else {
            return
        }
        user.lastAccess = Date()
        try await user.update(on: req.db)
        let roles = try await req.user.role.repository.findWithPermissions(user.uuid, req)
        let isRoot = !roles.filter { $0.key == User.Role.Keys.Root }.isEmpty
        req.auth.login(FeatherUser(id: user.uuid, level: isRoot ? .root : .authenticated, roles: roles))
        // update token last access & expiration date...
        token.lastAccess = now
        token.expiration = now.addingTimeInterval(86_400 * 7)
        try await token.update(on: req.db)
    }
}

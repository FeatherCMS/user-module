import Foundation
import FeatherCore
import UserObjects
import Fluent

public struct UserAccountRoleApi {

    let repository: UserAccountRoleRepository
    
    init(_ repository: UserAccountRoleRepository) {
        self.repository = repository
    }
}

public extension UserAccountRoleApi {

    func create(_ accountRole: User.AccountRole.Create) async throws {
        guard let account = try await UserAccountRepository(repository.db).find(accountRole.email) else {
            return
        }
        let roles = try await UserRoleRepository(repository.db).find(accountRole.roleKeys)
        
        let models = roles.map {
            UserAccountRoleModel(accountId: account.uuid, roleId: $0.uuid)
        }
        try await models.create(on: repository.db, chunks: 25)
    }
    

}

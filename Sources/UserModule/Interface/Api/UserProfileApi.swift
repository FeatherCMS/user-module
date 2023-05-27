import Foundation
import FeatherCore
import UserObjects

public struct UserProfileApi {

    let repository: UserAccountRepository
    
    init(_ repository: UserAccountRepository) {
        self.repository = repository
    }
}

public extension UserProfileApi {

//    func list() async throws -> [User.Account.List] {
//        try await repository.list().transform(to: [User.Account.List].self)
//    }

}

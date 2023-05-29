import Foundation
import FeatherCore
import UserObjects

public struct UserRoleApi {

    let repository: UserRoleRepository
    
    init(_ repository: UserRoleRepository) {
        self.repository = repository
    }
}

public extension UserRoleApi {

    func list() async throws -> [User.Role.List] {
        try await repository.list().transform(to: [User.Role.List].self)
    }
    
    func list(_ ids: [UUID]) async throws -> [User.Role.List] {
        try await repository.get(ids).transform(to: [User.Role.List].self)
    }
    
    func get(_ id: UUID) async throws -> User.Role.List? {
        try await repository.get(id)?.transform(to: User.Role.List.self)
    }

    func get(_ ids: [UUID]) async throws -> [User.Role.Detail] {
        try await repository.get(ids).transform(to: [User.Role.Detail].self)
    }

    func optionList() async throws -> [OptionContext] {
        try await list()
            .filter { ![User.Role.Keys.Guest, User.Role.Keys.Authenticated].contains($0.key) }
            .map { .init(key: $0.id.string, label: $0.name) }
    }
    
}

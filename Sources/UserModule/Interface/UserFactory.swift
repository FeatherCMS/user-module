import FeatherCore

/// user module factory
public struct UserModuleFactory {

    /// build a new module instance using a template
    public static func build(using template: UserModuleTemplate? = nil) -> FeatherModule {
        UserModule(template: template ?? DefaultUserModuleTemplate())
    }
}

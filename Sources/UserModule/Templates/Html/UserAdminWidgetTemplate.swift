//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 01..
//

import SwiftHtml
import FeatherIcons

struct UserAdminWidgetTemplate: TemplateRepresentable {
    
    @TagBuilder
    func render(_ req: Request) -> Tag {
        Svg.user
        H2("User")
        Ul {
//            if let user = req.auth.get(FeatherAccount.self) {
//                Li(user.email)
//            }
//            Li {
//                if  {
//                    A("Sign out")
//                        .href("/" + req.feather.config.paths.logout)
//                }
//            }

            if req.checkPermission(User.Account.permission(for: .detail)) {
                Li {
                    A("Profile")
                        .href("/admin/user/profile")
                }
            }
            
            if req.checkPermission(User.Account.permission(for: .list)) {
                Li {
                    A("Accounts")
                        .href("/admin/user/accounts")
                }
            }
            if req.checkPermission(User.Role.permission(for: .list)) {
                Li {
                    A("Roles")
                        .href("/admin/user/roles")
                }
            }
        }
    }
}
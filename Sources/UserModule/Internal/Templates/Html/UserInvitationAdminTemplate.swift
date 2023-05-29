//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 25..
//

import Vapor
import FeatherCore
import SwiftHtml

final class UserInvitationAdminTemplate: AbstractTemplate<UserInvitationContext> {

    override func render(_ req: Request) -> Tag {
        req.templateEngine.system.index(.init(title: context.title)) {
            Wrapper {
                Container {
                    LeadTemplate(.init(title: context.title, excerpt: context.message)).render(req)

                    FormTemplate(context.form).render(req)
                    
                    LinkTemplate(context.link).render(req)
                }
            }
        }
        .render(req)
    }
}



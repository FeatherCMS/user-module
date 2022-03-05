//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 02. 28..
//

import SwiftHtml

final class UserRegisterTemplate: AbstractTemplate<UserRegisterContext> {

    override func render(_ req: Request) -> Tag {
        req.templateEngine.system.index(.init(title: context.title)) {
            Wrapper {
                Container {
                    LeadTemplate(.init(title: context.title, excerpt: context.message)).render(req)

                    context.form
                }
            }
        }
        .render(req)
    }
}


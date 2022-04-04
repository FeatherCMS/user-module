//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 28..
//

import Vapor
import Mail

struct UserInvitationEmailController {
    
    func send(_ req: Request, _ model: UserInvitationModel) async throws {

        let baseUrl = req.feather.publicUrl + "/"
        let html = """
            <h1>\(model.email)</h1>
            <p>\(model.token)</p>
            <a href="\(baseUrl)register/?invitation=\(model.token)&redirect=/login/">Create account</a>
        """
        guard let from = req.variable("systemEmailAddress") else {
            return
        }
        
        var bcc: [String] = []
        if let rawBcc = req.variable("systemBccEmailAddresses") {
            bcc = rawBcc.components(separatedBy: ",")
        }
        
        _ = try await req.mail.send(.init(from: from,
                                          to: [model.email],
                                          bcc: bcc,
                                          subject: "Invitation",
                                          content: .init(value: html, type: .html)))
    }
}
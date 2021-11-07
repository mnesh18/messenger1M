//
//  chat.swift
//  messenger1M
//
//  Created by M's MacBook  on 06/11/2021.
//

import Foundation

struct Chat {
    var users: [String]
    var dictionary: [String: Any] {
        return ["users": users]
    }
}

extension Chat {
    init?(dictionary: [String:Any]) {
        guard let chatUsers = dictionary["users"] as? [String] else {return nil}
        self.init(users: chatUsers)
    }
}

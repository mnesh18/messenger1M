//
//  ChatUser.swift
//  messenger1M
//
//  Created by M's MacBook  on 06/11/2021.
//

import Foundation
import MessageKit

struct ChatUser: SenderType, Equatable {
    var senderId: String
    var displayName: String
}

//
//  UpdateStore.swift
//  WHUT
//
//  Created by Nic Demai on 11/20/21.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}

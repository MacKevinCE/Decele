//
//  BaseDestination.swift
//  Decele
//
//  Created by Mc Kevin on 9/07/22.
//

import Dispatch
import Foundation

open class BaseDestination {
    open var asynchronously = true

    var queue: DispatchQueue? // dispatch_queue_t?

    public init() {
        let uuid = NSUUID().uuidString
        let queueLabel = "Chuck-queue-" + uuid
        queue = DispatchQueue(label: queueLabel, target: queue)
    }

    func send(_ chuck: any InputProtocol, thread _: String) -> OutputClass {
        return chuck.output()
    }
}

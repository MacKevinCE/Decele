//
//  OutputLog.swift
//  Chuck
//
//  Created by Mc Kevin on 15/07/22.
//

import Foundation

class OutputLog: OutputClass {
    init(_ input: InputLog) {
        super.init(input)
        self.title = input.getTitle()
        self.colorTitle = input.colorText
        self.detailTabs = [
            DetailTabs(name: "RESUME", attributed: input.getTabResume()),
            DetailTabs(name: "ALL", attributed: input.getTabAll())
        ]
    }
}

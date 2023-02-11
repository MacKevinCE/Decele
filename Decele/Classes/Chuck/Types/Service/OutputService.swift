//
//  OutputService.swift
//  Decele
//
//  Created by Mc Kevin on 15/07/22.
//

import Foundation

class OutputService: OutputClass {
    init(_ input: InputService) {
        super.init(input)
        title = input.endPoint.truncated(prefixLength: 50, suffixLength: 50)
        colorTitle = input.colorText
        detailTabs = [
            DetailTabs(name: "RESUME", attributed: input.getTabResume()),
            DetailTabs(name: "REQUEST", attributed: input.getTabRequest()),
            DetailTabs(name: "RESPONSE", attributed: input.getTabResponse()),
            DetailTabs(name: "All", attributed: input.getTabAll()),
        ]
    }
}

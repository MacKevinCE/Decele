//
//  InputService.swift
//  Chuck
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

struct InputService: InputProtocol {
    let file: String
    let function: String
    let line: Int
    let type: ChuckLevel
    let colorText: UIColor
    let state: String
    let method: String
    let url: String
    let endPoint: String
    let typeRequest: String
    let headersResquest: [String: String]
    let request: String
    let typeResponse: String
    let headersResponse: [String: String]
    let response: String
    let error: String

    init(
        _ urlResponse: URLResponse?,
        _ request: URLRequest?,
        _ data: Data?,
        _ error: Error? = nil,
        _ typeRequest: String? = nil,
        _ typeResponse: String? = nil,
        _ file: String,
        _ function: String,
        _ line: Int
    ) {
        let response = urlResponse as? HTTPURLResponse
        self.file = file
        self.function = function
        self.line = line
        self.type = .service
        self.colorText = getColor(response)
        self.state = getState(response)
        self.method = getMethod(request)
        self.url = getUrl(request)
        self.endPoint = getEndPoint(request)
        self.typeRequest = typeRequest ?? .empty
        self.headersResquest = getHeadersRequest(request)
        self.request = getRequest(request)
        self.typeResponse = typeResponse ?? .empty
        self.headersResponse = getHeadersResponse(response)
        self.response = getResponse(data)
        self.error = getError(error)
    }

    func output() -> OutputService {
        return OutputService(self)
    }

    func getPreview() -> PreviewInfo {
        let colorText = self.colorText
        let colorState: UIColor = (colorText == .black) ? .green : colorText
        let attributed = "\(self.state)"
            .initAttributeIndentation(indentation: 35)
            .addAttributeText(color: colorState, font: .semibold16)
            .printSpacer().printSpacer()
            .addTextWithAttributeText(text: self.method.uppercased(), color: colorText, font: .semibold14)
            .printSpacer().printSpacer()
            .addTextWithAttributeText(text: self.endPoint.resume(), color: colorText, font: .regular14)
            .printEnter().printTab().printTab().printSpacer()
            .addTextWithAttributeText(text: self.time.toString(), color: .gray, font: .regular12)
        return .attributed(attributed)
    }

    func getTabAll() -> NSMutableAttributedString {
        var pares: [String: String] = [:]
        pares["ID"] = self.id.uuidString
        pares["Method"] = self.method
        pares["URL"] = self.url
        pares["Error"] = self.error
        pares["Request Headers"] = self.headersResquest.toString()
        pares["Request Body"] = self.request
        pares["Response Status"] = self.state
        pares["Response Headers"] = self.headersResponse.toString()
        pares["Response Body"] = self.response
        pares["File"] = Chuck.getPath(self.file)
        pares["Function"] = self.function
        pares["Line"] = String(self.line)
        pares["Time"] = self.time.toString(with: .iso8601)
        return pares.toAttributedString()
    }

    func getTabResume() -> NSMutableAttributedString {
        let colorState = (colorText == .black) ? .green : self.colorText

        var attributeText = String.empty.initAttributeText(font: .regular14)
            .printTitleChuck("URL")
            .printEnter()
            .addTextWithAttributeText(text: self.state, color: colorState, font: .semibold14)
            .printSpacer().printSpacer()
            .addAttributeIndentation(indentation: 35)
            .addTextWithAttributeText(text: self.method.uppercased(), color: self.colorText, font: .semibold14)
            .printSpacer().printSpacer()
            .addTextWithAttributeText(text: self.url, color: self.colorText, font: .regular14)
            .printEnter()

        if let err = self.error.null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("ERROR", color: .red)
                .printEnter()
                .addTextWithAttributeText(text: err, color: .red, font: .regular14)
                .printEnter()
        }

        if let typeRequest = self.typeRequest.null(),
           let typeResponse = self.typeResponse.null()
        {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("TYPE")
                .printEnter()
                .printParStringForChuck((key: "TYPE REQUEST", value: typeRequest))
                .printEnter()
                .printParStringForChuck((key: "TYPE RESPONSE", value: typeResponse))
                .printEnter()
        }

        if let request = self.request.null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("REQUEST")
                .printEnter()
                .printJSONForChuck(request)
                .printEnter()
        }
        if let response = self.response.null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("RESPONSE")
                .printEnter()
                .printJSONForChuck(response)
                .printEnter()
        }
        return attributeText
    }

    func getTabRequest() -> NSMutableAttributedString {
        var attributeText = String.empty.initAttributeText(font: .regular14)

        if let request = self.request.null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("REQUEST BODY")
                .printEnter()
                .printJSONForChuck(request)
                .printEnter()
        }
        if self.headersResquest.count > 0 {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("REQUEST HEADER")
                .printEnter()
            self.headersResquest.forEach {
                attributeText = attributeText
                    .printParStringForChuck($0)
                    .printEnter()
            }
        }
        return attributeText
    }

    func getTabResponse() -> NSMutableAttributedString {
        var attributeText = String.empty.initAttributeText(font: .regular14)

        if let response = self.response.null() {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("RESPONSE BODY")
                .printEnter()
                .printJSONForChuck(response)
                .printEnter()
        }
        if self.headersResponse.count > 0 {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("RESPONSE HEADER")
                .printEnter()
            self.headersResponse.forEach {
                attributeText = attributeText
                    .printParStringForChuck($0)
                    .printEnter()
            }
        }
        return attributeText
    }
}

func getState(_ response: HTTPURLResponse?) -> String {
    response?.statusCode.description ?? "RIP"
}

func getColor(_ response: HTTPURLResponse?) -> UIColor {
    if let status = response?.statusCode {
        switch status {
        case 200: return .darkText
        case 201 ... 299: return .systemGreen
        case 300 ... 399: return .systemBlue
        case 400 ... 499: return .systemOrange
        default: return .systemRed
        }
    } else {
        return .systemPink
    }
}

func getMethod(_ request: URLRequest?) -> String {
    request?.httpMethod ?? "T_T"
}

func getUrl(_ request: URLRequest?) -> String {
    request?.debugDescription ?? "~/<¡_¡>"
}

func getEndPoint(_ request: URLRequest?) -> String {
    getUrl(request).replacingOccurrences(of: Chuck.baseURL, with: "~")
}

func getRequest(_ request: URLRequest?) -> String {
    return getResponse(request?.httpBody)
}

func getHeadersRequest(_ request: URLRequest?) -> [String: String] {
    request?.allHTTPHeaderFields ?? [:]
}

func getResponse(_ data: Data?) -> String {
    let pretty = data?.prettyPrintedJSONString?.null()
    let normal = data.map { String(decoding: $0, as: UTF8.self) }
    let final = normal?.replacingOccurrences(of: "&", with: "\n").null()
    return pretty ?? final ?? "None"
}

func getHeadersResponse(_ response: HTTPURLResponse?) -> [String: String] {
    let parString = response?.allHeaderFields.map { ($0.key.description, ($0.value as AnyObject).description ?? .empty) }
    guard let sequence = parString else { return [:] }
    return Dictionary(uniqueKeysWithValues: sequence)
}

func getError(_ error: Error?) -> String {
    error?.localizedDescription ?? .empty
}

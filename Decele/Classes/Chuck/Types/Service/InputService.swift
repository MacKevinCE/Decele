//
//  InputService.swift
//  Decele
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation

// MARK: - InputService
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
        type = .service
        colorText = getColor(response)
        state = getState(response)
        method = getMethod(request)
        url = getUrl(request)
        endPoint = getEndPoint(request)
        self.typeRequest = typeRequest ?? .empty
        headersResquest = getHeadersRequest(request)
        self.request = getRequest(request)
        self.typeResponse = typeResponse ?? .empty
        headersResponse = getHeadersResponse(response)
        self.response = getResponse(data)
        self.error = getError(error)
    }

    func output() -> OutputService {
        OutputService(self)
    }

    func getPreview() -> PreviewInfo {
        let colorText = self.colorText
        let colorState: UIColor = (colorText == .black) ? .green : colorText
        let attributed = "\(state)"
            .applying(indentation: 35)
            .applying(font: .semibold16, color: colorState)
            .printSpacer().printSpacer()
            .addTextApplying(text: method.uppercased(), font: .semibold14, color: colorText)
            .printSpacer().printSpacer()
            .addTextApplying(text: endPoint.truncated(prefixLength: 50, suffixLength: 50), font: .regular14, color: colorText)
            .printEnter().printTab().printTab().printSpacer()
            .addTextApplying(text: time.string(withFormat: .timeMedium), font: .regular12, color: .gray)
        return .attributed(attributed)
    }

    func getTabAll() -> NSMutableAttributedString {
        var pares: [String: String] = [:]
        pares["ID"] = id.uuidString
        pares["Method"] = method
        pares["URL"] = url
        pares["Error"] = error
        pares["Request Headers"] = headersResquest.toString()
        pares["Request Body"] = request
        pares["Response Status"] = state
        pares["Response Headers"] = headersResponse.toString()
        pares["Response Body"] = response
        pares["File"] = Chuck.getPath(file)
        pares["Function"] = function
        pares["Line"] = String(line)
        pares["Time"] = time.string(withFormat: .iso8601)
        return pares.toAttributedString()
    }

    func getTabResume() -> NSMutableAttributedString {
        let colorState = (colorText == .black) ? .green : colorText

        var attributeText = NSMutableAttributedString()
            .printTitleChuck("URL")
            .printEnter()
            .addTextApplying(text: state, font: .semibold14, color: colorState)
            .printSpacer().printSpacer()
            .applying(indentation: 35)
            .addTextApplying(text: method.uppercased(), font: .semibold14, color: colorText)
            .printSpacer().printSpacer()
            .addTextApplying(text: url, font: .regular14, color: colorText)
            .printEnter()

        if let err = error.nullable {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("ERROR", color: .red)
                .printEnter()
                .addTextApplying(text: err, font: .regular14, color: .red)
                .printEnter()
        }

        if let typeRequest = typeRequest.nullable,
           let typeResponse = typeResponse.nullable
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

        if let request = request.nullable {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("REQUEST")
                .printEnter()
                .printJSONForChuck(request)
                .printEnter()
        }
        if let response = response.nullable {
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
        var attributeText = NSMutableAttributedString()

        if let request = request.nullable {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("REQUEST BODY")
                .printEnter()
                .printJSONForChuck(request)
                .printEnter()
        }
        if headersResquest.count > 0 {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("REQUEST HEADER")
                .printEnter()
            headersResquest.forEach {
                attributeText = attributeText
                    .printParStringForChuck($0)
                    .printEnter()
            }
        }
        return attributeText
    }

    func getTabResponse() -> NSMutableAttributedString {
        var attributeText = NSMutableAttributedString()

        if let response = response.nullable {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("RESPONSE BODY")
                .printEnter()
                .printJSONForChuck(response)
                .printEnter()
        }
        if headersResponse.count > 0 {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("RESPONSE HEADER")
                .printEnter()
            headersResponse.forEach {
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
    getResponse(request?.httpBody)
}

func getHeadersRequest(_ request: URLRequest?) -> [String: String] {
    request?.allHTTPHeaderFields ?? [:]
}

func getResponse(_ data: Data?) -> String {
    let pretty = data?.prettyPrintedJSONString?.nullable
    let normal = data.map { String(decoding: $0, as: UTF8.self) }
    let final = normal?.replacingOccurrences(of: "&", with: "\n").nullable
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

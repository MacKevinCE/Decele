//
//  SwiftyBeaver.swift
//  SwiftyBeaver
//
//  Created by Sebastian Kreutzberger (Twitter @skreutzb) on 28.11.15.
//  Copyright © 2015 Sebastian Kreutzberger
//  Some rights reserved: http://opensource.org/licenses/MIT
//
//
//  Chuck.swift
//  Chuck
//
//  Update by Mc Kevin on 14/07/22.
//

import Foundation

public class Chuck {
    private(set) static var dataChuck: [OutputClass] = []
    private(set) static var selectChuck: [OutputClass] = []
    private(set) static var destination = BaseDestination()
    private(set) static var typeOpen: TypeOpen = .none
    private(set) static var baseURL: String = ""
    private(set) static var enverimoment: String = ""
    private(set) static var enableType: [ChuckLevel] = ChuckLevel.allCases
    private(set) static var showDetectingButton: Bool = true
    private(set) static var leftBarButtonItems: [UIBarButtonItem] = []
    private(set) static var rightBarButtonItems: [UIBarButtonItem] = []
    private(set) static var iconCircle: TypeIcon = .character("😁")
    static var location: CGPoint = .zero
    static var isDetecting: Bool = true
    static var searchText: String = ""
    static var searchTextDetail: String = ""
    static var tabControl: Int = .zero
    static var tabControlDetail: Int = .zero

    // MARK: Setting Handling

    class func getSelectChuck(_ chuck: OutputClass) {
        if !selectChuck.contains(chuck) {
            selectChuck.removeAll(where: { $0.type == chuck.type })
            selectChuck.append(chuck)
        }
    }

    open class func typeOpen(_ typeOpen: TypeOpen) {
        self.typeOpen = typeOpen
    }

    open class func setBaseURL(_ baseURL: String) {
        self.baseURL = baseURL
    }

    open class func setEnverimoment(_ enverimoment: String) {
        self.enverimoment = enverimoment
    }

    open class func setIconCircle(_ type: TypeIcon) {
        iconCircle = type
    }

    open class func showDetectingButton(_ show: Bool) {
        showDetectingButton = show
    }

    open class func leftBarButtonItems(_ barButtonItems: [UIBarButtonItem]) {
        leftBarButtonItems = barButtonItems
    }

    open class func rightBarButtonItems(_ barButtonItems: [UIBarButtonItem]) {
        rightBarButtonItems = barButtonItems
    }

    open class func addLeftBarButtonItems(_ barButtonItem: UIBarButtonItem) {
        leftBarButtonItems.append(barButtonItem)
    }

    open class func addLeftBarButtonItems(_ barButtonItems: [UIBarButtonItem]) {
        leftBarButtonItems.append(contentsOf: barButtonItems)
    }

    open class func addRightBarButtonItems(_ barButtonItem: UIBarButtonItem) {
        rightBarButtonItems.append(barButtonItem)
    }

    open class func addRightBarButtonItems(_ barButtonItems: [UIBarButtonItem]) {
        rightBarButtonItems.append(contentsOf: barButtonItems)
    }

    open class func setEnableType(_ enableType: [ChuckLevel]) {
        self.enableType = enableType.isEmpty ? ChuckLevel.allCases : enableType
        self.enableType.uniqued()
    }

    open class func addEnableType(_ enableType: ChuckLevel) {
        self.enableType.append(enableType)
        self.enableType.uniqued()
    }

    open class func addEnableType(_ enableTypes: [ChuckLevel]) {
        enableType.append(contentsOf: enableTypes)
        enableType.uniqued()
    }

    // MARK: Method Handling

    open class func resetChuck() {
        searchText = .empty
        searchTextDetail = .empty
        tabControl = .zero
        tabControlDetail = .zero
        dataChuck.removeAll()
    }

    open class func removeChuck(_ id: UUID) {
        guard let index = dataChuck.firstIndex(where: { $0.id == id }) else { return }
        dataChuck.remove(at: index)
    }

    open class func removeChuck(_ ids: [UUID]) {
        ids.forEach { removeChuck($0) }
    }

    open class func removeChuck(_ chuck: OutputClass?) {
        guard let id = chuck?.id else { return }
        removeChuck(id)
    }

    open class func removeChuck(_ chucks: [OutputClass]) {
        chucks.forEach { removeChuck($0) }
    }

    open class func removeChuck(_ type: ChuckLevel) {
        dataChuck = dataChuck.filter { $0.type != type }
    }

    /// returns the current thread name
    open class func threadName() -> String {
        if Thread.isMainThread {
            return ""
        } else {
            let name = __dispatch_queue_get_label(nil)
            return String(cString: name, encoding: .utf8) ?? Thread.current.description
        }
    }

    // MARK: Chucks add

    /// log something generally unimportant (lowest priority)
    open class func print(_ items: Any..., separator: String = " ", terminator: String = "\n",
                          file: String = #file, function: String = #function, line: Int = #line)
    {
        custom(InputLog(items, separator: separator, terminator: terminator, .print, file, function, line))
    }

    /// log something which help during debugging (low priority)
    open class func debug(_ items: Any..., separator: String = " ", terminator: String = "\n",
                          file: String = #file, function: String = #function, line: Int = #line)
    {
        custom(InputLog(items, separator: separator, terminator: terminator, .debug, file, function, line))
    }

    /// log something which you are really interested but which is not an issue or error (normal priority)
    open class func info(_ items: Any..., separator: String = " ", terminator: String = "\n",
                         file: String = #file, function: String = #function, line: Int = #line)
    {
        custom(InputLog(items, separator: separator, terminator: terminator, .info, file, function, line))
    }

    /// log something which may cause big trouble soon (high priority)
    open class func warning(_ items: Any..., separator: String = " ", terminator: String = "\n",
                            file: String = #file, function: String = #function, line: Int = #line)
    {
        custom(InputLog(items, separator: separator, terminator: terminator, .warning, file, function, line))
    }

    /// log something which will keep you awake at night (highest priority)
    open class func error(_ items: Any..., separator: String = " ", terminator: String = "\n",
                          file: String = #file, function: String = #function, line: Int = #line)
    {
        custom(InputLog(items, separator: separator, terminator: terminator, .error, file, function, line))
    }

    /// log something which you are really interested but which is not an issue or error (normal priority)
    open class func service(_ urlResponse: URLResponse?,
                            _ request: URLRequest?,
                            _ data: Data?,
                            _ error: Error? = nil,
                            _ typeRequest: String? = nil,
                            _ typeResponse: String? = nil,
                            file: String = #file, function: String = #function, line: Int = #line)
    {
        custom(InputService(urlResponse, request, data, error, typeRequest, typeResponse, file, function, line))
    }

    open class func classInit(_ id: UUID, _ anyObject: AnyObject, file: String = #file, function: String = #function, line: Int = #line) {
        return custom(InputARC(id, anyObject, file, function, line))
    }

    open class func persistent(namespace: String, key: String, value: Any?, file: String = #file, function: String = #function, line: Int = #line) {
        return custom(InputPersistent(namespace, key, value, file, function, line))
    }

    open class func persistent(namespace: String, key: String, callback: (String) -> Any?, file: String = #file, function: String = #function, line: Int = #line) {
        let value = callback(key)
        return custom(InputPersistent(namespace, key, value, file, function, line))
    }

    open class func userDefaults(key: String, file: String = #file, function: String = #function, line: Int = #line) {
        let value = UserDefaults.standard.object(forKey: key)
        return custom(InputPersistent("UserDefaults", key, value, file, function, line))
    }

    /// custom logging to manually adjust values, should just be used by other frameworks
    open class func custom(_ chuck: any InputProtocol) {
        if enableType.contains(chuck.type) {
            dispatch_send(chuck, thread: threadName())
        }
    }

    class func dispatchWorkItem(_ chuck: any InputProtocol, thread: String) -> DispatchWorkItem {
        return DispatchWorkItem {
            let output = destination.send(chuck, thread: thread)
            if isDetecting {
                dataChuck.append(output)

                if Chuck.typeOpen == .circle || Chuck.typeOpen == .all { openChuckDebugView() }
            }
        }
    }

    /// internal helper which dispatches send to dedicated queue if minLevel is ok
    class func dispatch_send(_ chuck: any InputProtocol, thread: String) {
        guard let queue = destination.queue else { return }

        if destination.asynchronously {
            queue.async(execute: dispatchWorkItem(chuck, thread: thread))
        } else {
            queue.sync(execute: dispatchWorkItem(chuck, thread: thread))
        }
    }

    class func getChuckDebugView() -> ChuckDebugView? {
        guard let owner = UIApplication.rootViewController else { return nil }
        let presented = owner.presentedViewController?.view.subviews.first(with: ChuckDebugView.self)
        let direct = owner.view.subviews.first(with: ChuckDebugView.self)
        return presented ?? direct
    }

    class func getDebugNavController() -> DebugNavController? {
        guard let owner = UIApplication.rootViewController else { return nil }
        let presented = owner.presentedViewController?.presentedViewController as? DebugNavController
        let direct = owner.presentedViewController as? DebugNavController
        return presented ?? direct
    }

    class func openChuckDebugView() {
        DispatchQueue.main.async {
            guard let owner = UIApplication.rootViewController else { return }
            if let chuckNav = getDebugNavController() {
                if let chuckController = chuckNav.getChuckDebugViewController(), chuckController.isViewLoaded {
                    chuckController.reloadData()
                }
                return
            } else {
                guard getChuckDebugView() == nil else { return }
                ChuckDebugView().addPopUp(owner: owner.presentedViewController ?? owner)
            }
        }
    }

    open class func debugNavController() -> UINavigationController {
        DebugNavController(rootViewController: ChuckDebugAssembly.build())
    }

    class func openChuckDebug() {
        guard let owner = UIApplication.rootViewController else { return }
        let final = owner.presentedViewController ?? owner
        final.present(debugNavController(), animated: true, completion: nil)
    }

    class func getPath(_ file: String) -> String {
        var path: String = #file
        while !file.contains(path) {
            let last = path.split(separator: "/").last?.description ?? .empty
            path = path.replacingOccurrences(of: "/\(last)", with: String.empty)
        }
        let final = file.replacingOccurrences(of: path, with: String.empty)
        return "[Project Path]\(final)"
    }
}

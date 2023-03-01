//
//  NibView.swift
//  Decele
//
//  Created by Mc Kevin on 6/01/23.
//

import SnapKit
import UIKit

// MARK: - NibView
open class NibView: UIView {
    public var view: UIView!

    override public init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        viewDidLoad()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        viewDidLoad()
    }

    public func viewDidLoad() {}

    private func xibSetup() {
        backgroundColor = UIColor.clear
        view = loadNib()
        addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    public func buildViewController(with viewController: UIViewController) -> UIViewController {
        viewController.view = self
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return viewController
    }

    public func buildViewController() -> UIViewController {
        buildViewController(with: UIViewController())
    }

    private func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}

public extension UITableView {
    func dequeueReusableCell<T: NibView>(with _: T.Type, isRegistered: Bool = false) -> (view: T, cell: UITableViewCell) {
        let identifier = "\(String(describing: T.self))+\(String(describing: NibView.self))"
        guard let cell = dequeueReusableCell(withIdentifier: identifier) else {
            if isRegistered {
                fatalError("Couldn't find UITableViewCell with identifier \(identifier), make sure the cell is registered with table view")
            } else {
                register(T.self, forCellReuseIdentifier: identifier)
                return dequeueReusableCell(with: T.self, isRegistered: true)
            }
        }
        if let view: T = cell.contentView.subviews.firstType() {
            return (view, cell)
        } else {
            let view = T()
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            return (view, cell)
        }
    }
}

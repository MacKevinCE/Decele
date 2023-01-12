import UIKit

public class NibView: UIView {
    public var view: UIView!
    public weak var viewController: UIViewController?

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
        view.makeConstraintsEdgesToSuperview()
    }

    public func buildViewController(with viewController: UIViewController) -> UIViewController {
        viewController.view.addSubview(self)
        self.viewController = viewController
        makeConstraintsEdgesToSuperview()

        return viewController
    }

    public func buildViewController() -> UIViewController {
        let viewController = UIViewController()
        return buildViewController(with: viewController)
    }
}

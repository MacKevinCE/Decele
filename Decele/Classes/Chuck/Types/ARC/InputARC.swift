//
//  InputARC.swift
//  Decele
//
//  Created by Mc Kevin on 30/10/22.
//

import Foundation

// MARK: - InputARC
struct InputARC: InputProtocol {
    let id: UUID
    let file: String
    let function: String
    let line: Int
    let type: ChuckLevel
    let anyObject: AnyObject

    init(
        _ id: UUID,
        _ anyObject: AnyObject,
        _ file: String,
        _ function: String,
        _ line: Int
    ) {
        self.id = id
        self.file = file
        self.function = function
        self.line = line
        self.anyObject = anyObject
        type = .arc
    }

    func output() -> OutputARC {
        OutputARC(self)
    }

    func getPreview() -> PreviewInfo {
        let attributed = "\(classAsArray().first ?? "AnyObject"):"
            .applying(font: .semibold16, color: .systemTeal)
            .printSpacer()
            .addTextApplying(text: getNameClass())
            .printEnter().printTab().printTab().printSpacer()
            .addTextApplying(text: time.string(withFormat: .timeMedium), font: .regular12, color: .gray)
        return .attributed(attributed)
    }

    func getTabResume() -> NSMutableAttributedString {
        var attributeText = NSMutableAttributedString()

        if let name = getNameClass().nullable {
            attributeText = attributeText
                .printTitleChuck("CLASS NAME")
                .printEnter()
                .printJSONForChuck(name)
                .printEnter()
        }

        if let type = classAs().nullable {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("CLASS AS")
                .printEnter()
                .printJSONForChuck(type)
                .printEnter()
        }

        if let describing = describingClass().nullable {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("ALL DESCRIBING CLASS")
                .printEnter()
                .printJSONForChuck(describing)
                .printEnter()
        }

        if let json = jsonClass().nullable {
            attributeText = attributeText
                .printEnter()
                .printTitleChuck("JSON")
                .printEnter()
                .printJSONForChuck(json)
                .printEnter()
        }

        return attributeText
    }

    func getTabAll() -> NSMutableAttributedString {
        var pares: [String: String] = [:]
        pares["ID"] = id.uuidString
        pares["Project's Name"] = getNameProject()
        pares["Class Name"] = getNameClass()
        pares["All Describing Class"] = describingClass()
        pares["Encodable Class"] = jsonClass()
        pares["NavigationController Description"] = navigationControllerDescription()
        pares["View Description"] = viewDescription()
        pares["Class As"] = classAs()
        pares["File"] = Chuck.getPath(file)
        pares["Function"] = function
        pares["Line"] = String(line)
        pares["Time"] = time.string(withFormat: .iso8601)
        return pares.toAttributedString()
    }

    func classAsArray() -> [String] {
        [
            inherit(with: AnyKeyPath.self),
            inherit(with: Bundle.self),
            inherit(with: BlockOperation.self),
            inherit(with: ByteCountFormatter.self),
            inherit(with: DateComponentsFormatter.self),
            inherit(with: Dimension.self),
            inherit(with: DispatchData.self),
            inherit(with: UIAccessibilityElement.self),
            inherit(with: UIAccessibilityTraits.self),
            inherit(with: UIActivity.self),
            inherit(with: UIActivityIndicatorView.self),
            inherit(with: UIActivityItemProvider.self),
            inherit(with: UIAlertAction.self),
            inherit(with: UIAlertController.self),
            inherit(with: UIApplication.self),
            inherit(with: UIApplicationShortcutIcon.self),
            inherit(with: UIApplicationShortcutItem.self),
            inherit(with: UIAttachmentBehavior.self),
            inherit(with: UIButton.self),
            inherit(with: UIBarItem.self),
            inherit(with: UIBezierPath.self),
            inherit(with: UIBlurEffect.self),
            inherit(with: UIColor.self),
            inherit(with: UIControl.self),
            inherit(with: UIContextualAction.self),
            inherit(with: UICollisionBehavior.self),
            inherit(with: UIContentSizeCategory.self),
            inherit(with: UICollectionReusableView.self),
            inherit(with: UICollectionView.self),
            inherit(with: UICollectionViewCell.self),
            inherit(with: UICollectionViewController.self),
            inherit(with: UICollectionViewDropProposal.self),
            inherit(with: UICollectionViewDropPlaceholder.self),
            inherit(with: UICollectionViewFlowLayout.self),
            inherit(with: UICollectionViewFlowLayoutInvalidationContext.self),
            inherit(with: UICollectionViewFocusUpdateContext.self),
            inherit(with: UICollectionViewLayout.self),
            inherit(with: UICollectionViewLayoutAttributes.self),
            inherit(with: UICollectionViewLayoutInvalidationContext.self),
            inherit(with: UICollectionViewPlaceholder.self),
            inherit(with: UICollectionViewUpdateItem.self),
            inherit(with: UICollectionViewTransitionLayout.self),
            inherit(with: UIDragPreviewTarget.self),
            inherit(with: UIDevice.self),
            inherit(with: UIDocument.self),
            inherit(with: UIDragItem.self),
            inherit(with: UIDatePicker.self),
            inherit(with: UIDragPreview.self),
            inherit(with: UIDropProposal.self),
            inherit(with: UIDictationPhrase.self),
            inherit(with: UIDragInteraction.self),
            inherit(with: UIDropInteraction.self),
            inherit(with: UIDynamicAnimator.self),
            inherit(with: UIDynamicBehavior.self),
            inherit(with: UIEvent.self),
            inherit(with: UIFont.self),
            inherit(with: UIFocusGuide.self),
            inherit(with: UIFocusSystem.self),
            inherit(with: UIFontMetrics.self),
            inherit(with: UIFieldBehavior.self),
            inherit(with: UIFocusDebugger.self),
            inherit(with: UIFontDescriptor.self),
            inherit(with: UIFeedbackGenerator.self),
            inherit(with: UIFloatRange.self),
            inherit(with: UIFocusUpdateContext.self),
            inherit(with: UIGravityBehavior.self),
            inherit(with: UIGraphicsRenderer.self),
            inherit(with: UIGestureRecognizer.self),
            inherit(with: UIGraphicsPDFRenderer.self),
            inherit(with: UIGraphicsImageRenderer.self),
            inherit(with: UIGraphicsRendererFormat.self),
            inherit(with: UIGraphicsRendererContext.self),
            inherit(with: UIGraphicsPDFRendererFormat.self),
            inherit(with: UIGraphicsPDFRendererContext.self),
            inherit(with: UIGraphicsImageRendererFormat.self),
            inherit(with: UIGraphicsImageRendererContext.self),
            inherit(with: UIImage.self),
            inherit(with: UIImageView.self),
            inherit(with: UIInputView.self),
            inherit(with: UIImageAsset.self),
            inherit(with: UIInputViewController.self),
            inherit(with: UIImagePickerController.self),
            inherit(with: UIImpactFeedbackGenerator.self),
            inherit(with: UIInterpolatingMotionEffect.self),
            inherit(with: UIKeyCommand.self),
            inherit(with: UILabel.self),
            inherit(with: UILexicon.self),
            inherit(with: UILayoutGuide.self),
            inherit(with: UILexiconEntry.self),
            inherit(with: UILayoutPriority.self),
            inherit(with: UILocalizedIndexedCollation.self),
            inherit(with: UILongPressGestureRecognizer.self),
            inherit(with: UIMotionEffect.self),
            inherit(with: UIManagedDocument.self),
            inherit(with: UIMotionEffectGroup.self),
            inherit(with: UIMarkupTextPrintFormatter.self),
            inherit(with: UIMutableApplicationShortcutItem.self),
            inherit(with: UINavigationBar.self),
            inherit(with: UINavigationItem.self),
            inherit(with: UINib.self),
            inherit(with: UINotificationFeedbackGenerator.self),
            inherit(with: UIPress.self),
            inherit(with: UIPrinter.self),
            inherit(with: UIPasteboard.self),
            inherit(with: UIPrintInfo.self),
            inherit(with: UIPickerView.self),
            inherit(with: UIPrintPaper.self),
            inherit(with: UIPageControl.self),
            inherit(with: UIPressesEvent.self),
            inherit(with: UIProgressView.self),
            inherit(with: UIPushBehavior.self),
            inherit(with: UIPreviewAction.self),
            inherit(with: UIPrintFormatter.self),
            inherit(with: UIPasteConfiguration.self),
            inherit(with: UIPreviewInteraction.self),
            inherit(with: UIPresentationController.self),
            inherit(with: UIPrintPageRenderer.self),
            inherit(with: UIPageViewController.self),
            inherit(with: UIPreviewActionGroup.self),
            inherit(with: UIPanGestureRecognizer.self),
            inherit(with: UIRegion.self),
            inherit(with: UIRefreshControl.self),
            inherit(with: UIRotationGestureRecognizer.self),
            inherit(with: UIReferenceLibraryViewController.self),
            inherit(with: UISwitch.self),
            inherit(with: UISlider.self),
            inherit(with: UIScreen.self),
            inherit(with: UIStepper.self),
            inherit(with: UIStoryboard.self),
            inherit(with: UIStackView.self),
            inherit(with: UISearchBar.self),
            inherit(with: UIScrollView.self),
            inherit(with: UIScreenMode.self),
            inherit(with: UISnapBehavior.self),
            inherit(with: UIStoryboardSegue.self),
            inherit(with: UISearchController.self),
            inherit(with: UISegmentedControl.self),
            inherit(with: UITabBar.self),
            inherit(with: UITableView.self),
            inherit(with: UITabBarItem.self),
            inherit(with: UITraitCollection.self),
            inherit(with: UITapGestureRecognizer.self),
            inherit(with: UITargetedDragPreview.self),
            inherit(with: UITableViewPlaceholder.self),
            inherit(with: UITableViewDropProposal.self),
            inherit(with: UITableViewDropPlaceholder.self),
            inherit(with: UITableViewFocusUpdateContext.self),
            inherit(with: UITableViewHeaderFooterView.self),
            inherit(with: UITableViewCell.self),
            inherit(with: UITabBarController.self),
            inherit(with: UITableViewDropProposal.self),
            inherit(with: UITableViewDropPlaceholder.self),
            inherit(with: UITableViewHeaderFooterView.self),
            inherit(with: UITableViewFocusUpdateContext.self),
            inherit(with: UITableViewController.self),
            inherit(with: UITouch.self),
            inherit(with: UIToolbar.self),
            inherit(with: UITextView.self),
            inherit(with: UITextField.self),
            inherit(with: UITextRange.self),
            inherit(with: UITextChecker.self),
            inherit(with: UITextPosition.self),
            inherit(with: UITextInputMode.self),
            inherit(with: UIVisualEffect.self),
            inherit(with: UIVibrancyEffect.self),
            inherit(with: UIVisualEffectView.self),
            inherit(with: UIViewPrintFormatter.self),
            inherit(with: UIViewPropertyAnimator.self),
            inherit(with: UIVideoEditorController.self),
            inherit(with: UIView.self),
            inherit(with: UINavigationController.self),
            inherit(with: UIViewController.self),
            inherit(with: UIResponder.self),
            inherit(with: UIWindow.self),
            inherit(with: Codable.self),
            inherit(with: Decodable.self),
            inherit(with: Encodable.self),
            inherit(with: AnyObject.self),
        ].compactMap { $0 }
    }

    func classAs() -> String {
        classAsArray().joined(separator: ", ")
    }

    func inherit<T>(with _: T.Type) -> String? {
        if anyObject is T {
            return String(describing: T.self)
        } else {
            return nil
        }
    }

    func jsonClass() -> String {
        (anyObject as? Encodable)?.toPrettyPrintedJSONString() ?? .empty
    }

    func navigationControllerDescription() -> String {
        guard let value = (anyObject as? UIViewController) else { return .empty }
        return value.navigationController?.description ?? .empty
    }

    func viewDescription() -> String {
        guard let value = (anyObject as? UIViewController) else { return .empty }
        return value.view.description
    }

    func describingClass() -> String {
        String(describing: anyObject)
    }

    func getNameComplete() -> String {
        let describing = describingClass()
        return String(describing.split(separator: ":").first ?? "").replacingOccurrences(of: "<", with: "")
    }

    func getNameProject() -> String {
        String(getNameComplete().split(separator: ".").first ?? "")
    }

    func getNameClass() -> String {
        String(getNameComplete().split(separator: ".").last ?? "")
    }
}

// MARK: - ARC
open class ARC {
    let idARC = UUID()
    public init() {
        Chuck.classInit(idARC, self)
    }

    deinit {
        Chuck.removeChuck(idARC)
    }
}

// MARK: - ARCViewController
open class ARCViewController: UIViewController {
    let idARC = UUID()
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        Chuck.classInit(idARC, self)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        Chuck.classInit(idARC, self)
    }

    deinit {
        Chuck.removeChuck(idARC)
    }
}

// MARK: - ARCTableViewCell
open class ARCTableViewCell: UITableViewCell {
    let idARC = UUID()
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        Chuck.classInit(idARC, self)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        Chuck.classInit(idARC, self)
    }

    deinit {
        Chuck.removeChuck(idARC)
    }
}

// MARK: - ARCCollectionViewCell
open class ARCCollectionViewCell: UICollectionViewCell {
    let idARC = UUID()
    override public init(frame: CGRect) {
        super.init(frame: frame)
        Chuck.classInit(idARC, self)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        Chuck.classInit(idARC, self)
    }

    deinit {
        Chuck.removeChuck(idARC)
    }
}

// MARK: - ARCNavigationController
open class ARCNavigationController: UINavigationController {
    let idARC = UUID()
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        Chuck.classInit(idARC, self)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        Chuck.classInit(idARC, self)
    }

    deinit {
        Chuck.removeChuck(idARC)
    }
}

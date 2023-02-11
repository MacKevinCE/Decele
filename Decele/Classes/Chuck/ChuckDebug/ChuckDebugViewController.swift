//
//  DeceleViewController.swift
//  Decele
//
//  Created by Mc Kevin on 9/07/22.
//

import Foundation
import UIKit

// MARK: - ChuckDebugViewController
class ChuckDebugViewController: UIViewController {
    @IBOutlet private var enverimomentButton: UIButton!
    @IBOutlet private var resultLabel: UILabel! {
        willSet {
            newValue.text = .empty
        }
    }

    @IBOutlet private var heightSegmentedControlConstraint: NSLayoutConstraint!
    @IBOutlet private var segmentedControl: UISegmentedControl! {
        willSet {
            newValue.addTarget(self, action: #selector(changedSegmentedControl(_:)), for: .valueChanged)
        }
    }

    @IBOutlet private var tableView: UITableView! {
        willSet {
            newValue.dataSource = self
            newValue.delegate = self
            newValue.allowsMultipleSelectionDuringEditing = true
        }
    }

    @IBOutlet private var searchBar: UISearchBar! {
        willSet {
            newValue.delegate = self
            newValue.text = Chuck.searchText
        }
    }

    var isEdit: Bool = false {
        willSet {
            let type = getCurrentLevels[safe: segmentedControl.selectedSegmentIndex]
            isAllEdit = newValue && (type?.isEditing ?? true)
        }
    }

    var isAllEdit: Bool = false {
        willSet {
            tableView.isEditing = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    override func viewWillAppear(_: Bool) {
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.semibold16,
        ]
    }

    private func configView() {
        title = "Swifty Chuck"
        enverimomentState()
        leftBarButtonItem()
        rightBarButtonItem()
    }

    private func leftBarButtonItem() {
        var leftBarButtonItems: [UIBarButtonItem] = []

        if #available(iOS 13.0, *) {
            let close = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
            leftBarButtonItems.append(close)
        } else {
            let close = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeButtonTapped))
            close.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont.semibold12,
            ], for: [.normal, .highlighted])
            leftBarButtonItems.append(close)
        }

        if Chuck.showDetectingButton {
            let title = Chuck.isDetecting ? "Yes\nDetecting" : "No\nDetecting"
            let color: UIColor = Chuck.isDetecting ? .systemGreen : .systemRed

            let detectingBtn = UIButton(type: .system)
            detectingBtn.setTitle(title, for: .normal)
            detectingBtn.tintColor = color
            detectingBtn.titleLabel?.font = .semibold12
            detectingBtn.titleLabel?.textAlignment = .center
            detectingBtn.titleLabel?.numberOfLines = 2
            detectingBtn.addTarget(self, action: #selector(detectingButtonTapped), for: .touchUpInside)

            let detectingItem = UIBarButtonItem(customView: detectingBtn)
            leftBarButtonItems.append(detectingItem)
        }

        leftBarButtonItems.append(contentsOf: Chuck.leftBarButtonItems)

        navigationItem.leftBarButtonItems = leftBarButtonItems
    }

    private func rightBarButtonItem() {
        var rightBarButtonItems: [UIBarButtonItem] = []

        let type = getCurrentLevels[safe: segmentedControl.selectedSegmentIndex]
        let isEditing = type?.isEditing ?? false
        let showDeleteAllButton = type?.showDeleteAll ?? false

        if isEditing {
            let edit = UIBarButtonItem(barButtonSystemItem: isEdit ? .done : .edit, target: self, action: #selector(editButtonTapped))
            edit.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont.semibold12,
            ], for: [.normal, .highlighted])
            rightBarButtonItems.append(edit)
        }

        if showDeleteAllButton || isAllEdit {
            let title = isAllEdit ? "Delete\nSelection" : "Delete\nAll"
            let indexPaths = tableView.indexPathsForSelectedRows ?? []

            let deleteBtn = UIButton(type: .system)
            deleteBtn.setTitle(title, for: .normal)
            deleteBtn.isUserInteractionEnabled = !(isAllEdit && indexPaths.isEmpty || data.isEmpty)
            deleteBtn.tintColor = deleteBtn.isUserInteractionEnabled ? .systemRed : .systemGray
            deleteBtn.titleLabel?.font = .semibold12
            deleteBtn.titleLabel?.textAlignment = .center
            deleteBtn.titleLabel?.numberOfLines = 2
            deleteBtn.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)

            let deleteItem = UIBarButtonItem(customView: deleteBtn)
            rightBarButtonItems.append(deleteItem)
        }

        rightBarButtonItems.append(contentsOf: Chuck.rightBarButtonItems)

        navigationItem.rightBarButtonItems = rightBarButtonItems
    }

    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.getNewLevels()
            self.tableView.reloadData()
        }
    }

    private var levels: [ChuckLevel]? {
        willSet {
            let levels = newValue ?? []
            segmentedControl.removeAllSegments()
            levels.enumerated().forEach {
                segmentedControl.insertSegment(withTitle: $0.element.text, at: $0.offset, animated: false)
            }
            segmentedControl.selectedSegmentIndex = min(Chuck.tabControl, segmentedControl.numberOfSegments - 1)

            heightSegmentedControlConstraint.isActive = levels.count < 2
            segmentedControl.isHidden = levels.count < 2
        }
    }

    @discardableResult
    private func getNewLevels() -> [ChuckLevel] {
        let data = Chuck.dataChuck
        levels = Chuck.enableType.filter { type in
            !data.filter { $0.type == type }.isEmpty
        }
        return levels ?? []
    }

    private var getCurrentLevels: [ChuckLevel] {
        if let levels = levels {
            return levels
        } else {
            return getNewLevels()
        }
    }

    private var data: [OutputClass] = []

    private func dataFinal(type: ChuckLevel) -> [OutputClass] {
        var data = Chuck.dataChuck.filter { $0.type == type }
        let countInicial = data.count
        if let textFilter = searchBar.text?.nullable {
            data = data.filter {
                $0.preview.getSearchText.lowercased().unaccent.contains(textFilter.lowercased().unaccent)
            }
            resultLabel.text = "\(data.count) of \(countInicial)"
        } else {
            resultLabel.text = .empty
        }
        return data.reversed()
    }

    private func enverimomentState() {
        enverimomentButton.isEnabled = false
        let enverimoment = Chuck.enverimoment
        enverimomentButton.setTitle(enverimoment, for: .normal)
        enverimomentButton.setTitleColor(.systemOrange, for: .normal)
        enverimomentButton.setTitleColor(.systemPink, for: .highlighted)
        enverimomentButton.setTitleColor(.systemGray, for: .disabled)
    }

    @objc private func changedSegmentedControl(_ sender: UISegmentedControl) {
        Chuck.tabControl = sender.selectedSegmentIndex
        let type = getCurrentLevels[safe: segmentedControl.selectedSegmentIndex]
        isAllEdit = isEdit && (type?.isEditing ?? true)
        tableView.reloadData()
        rightBarButtonItem()
    }

    @IBAction private func enverimomentButtonTapped(_: UIButton) {
        // falta
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }

    @objc private func detectingButtonTapped() {
        Chuck.isDetecting.toggle()
        leftBarButtonItem()
    }

    @objc private func deleteButtonTapped() {
        searchBar.resignFirstResponder()
        if isAllEdit {
            let indexPaths = tableView.indexPathsForSelectedRows ?? []
            let ids = indexPaths.compactMap { data[safe: $0.row]?.id }
            Chuck.removeChuck(ids)
            tableView.deleteRows(at: indexPaths, with: .automatic)
        } else {
            if let type = getCurrentLevels[safe: segmentedControl.selectedSegmentIndex] {
                Chuck.removeChuck(type)
            }
            tableView.reloadData()
        }
        rightBarButtonItem()
    }

    @objc private func editButtonTapped() {
        isEdit.toggle()
        tableView.reloadData()
        rightBarButtonItem()
    }
}

// MARK: UISearchBarDelegate
extension ChuckDebugViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        Chuck.searchText = searchText
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: UITableViewDataSource
extension ChuckDebugViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if let chuckType = getCurrentLevels[safe: segmentedControl.selectedSegmentIndex] {
            data = dataFinal(type: chuckType)
            rightBarButtonItem()
            return data.count
        } else {
            return .zero
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dato = data[indexPath.row]
        let isSelect = Chuck.selectChuck.contains(dato)
        switch dato.preview {
        case let .attributed(attributedString, numberOfLines):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChuckDebugCell", for: indexPath)
            cell.textLabel?.numberOfLines = numberOfLines
            cell.textLabel?.font = .regular14
            cell.backgroundColor = (isSelect && !isAllEdit) ? .systemGray.setAlpha(0.25) : .clear
            cell.selectionStyle = isAllEdit ? .default : .none
            cell.textLabel?.attributedText = attributedString
            cell.contentView.isUserInteractionEnabled = !isEdit
            return cell

        case let .cell(typeCell, _):
            let cell = tableView.dequeueReusableCell(withClass: typeCell) as! PreviewTableViewCell

            cell.seputCell(output: dato)
            cell.select(is: isSelect)
            if let type = getCurrentLevels[safe: segmentedControl.selectedSegmentIndex], type.isEditing, isAllEdit {
                cell.selectionStyle = .default
            }
            cell.contentView.isUserInteractionEnabled = !isEdit
            return cell
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var rowActions: [UIContextualAction] = []

        let dato = data[indexPath.row]

        dato.trailingSwipeActions.forEach { action in
            let executeAction = UIContextualAction(style: .normal, title: action.name) { [weak self] _, _, close in
                close(true)
                let dato = self?.data[indexPath.row]
                action.execute(dato, indexPath)
            }
            executeAction.backgroundColor = action.color
            rowActions.append(executeAction)
        }

        if dato.showDeleteAction {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, close in
                close(true)
                Chuck.removeChuck(dato)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                self?.rightBarButtonItem()
            }
            rowActions.append(deleteAction)
        }

        return UISwipeActionsConfiguration(actions: rowActions)
    }

    func tableView(_: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var rowActions: [UIContextualAction] = []

        let dato = data[indexPath.row]

        dato.leadingSwipeActions.forEach { action in
            let executeAction = UIContextualAction(style: .normal, title: action.name) { [weak self] _, _, close in
                close(true)
                let dato = self?.data[indexPath.row]
                action.execute(dato, indexPath)
            }
            executeAction.backgroundColor = action.color
            rowActions.append(executeAction)
        }
        return UISwipeActionsConfiguration(actions: rowActions)
    }
}

// MARK: UITableViewDelegate
extension ChuckDebugViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isAllEdit {
            rightBarButtonItem()
        } else {
            tableView.deselectRow(at: indexPath, animated: false)
            searchBar.resignFirstResponder()
            let dato = data[indexPath.row]
            Chuck.getSelectChuck(dato)
            tableView.reloadRowsVisiblesCell()
            if dato.detailTabs.count != .zero {
                let viewController = ChuckDebugDetailAssembly.build(chuck: dato)
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }

    func tableView(_: UITableView, didDeselectRowAt _: IndexPath) {
        if isAllEdit {
            rightBarButtonItem()
        }
    }
}

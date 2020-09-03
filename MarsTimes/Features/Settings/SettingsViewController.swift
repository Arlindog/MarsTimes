//
//  SettingsViewController.swift
//  MarsTimes
//
//  Created by Arlindo on 9/1/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import RxSwift
import RxCocoa

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var settingTableView: UITableView!

    private let disposeBag = DisposeBag()
    private let viewModel = SettingsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        setupTableView()
        setupNavigationBar()
    }

    private func setupTableView() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(UINib(nibName: LanguageSettingCell.identifier, bundle: nil),
                               forCellReuseIdentifier: LanguageSettingCell.identifier)

        settingTableView.tableFooterView = UIView()
        settingTableView.sectionHeaderHeight = UITableView.automaticDimension
        settingTableView.estimatedSectionHeaderHeight = 60

        settingTableView.register(LanguageSettingsHeaderView.self,
                                  forHeaderFooterViewReuseIdentifier: LanguageSettingsHeaderView.identifier)
    }

    private func setupNavigationBar() {
        let backBarButton = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(dismissSettings))
        navigationItem.leftBarButtonItem = backBarButton
        "← Back".localized()
            .drive(backBarButton.rx.title)
            .disposed(by: disposeBag)
    }

    @objc private func dismissSettings() {
        navigationController?.popViewController(animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settingItemCount
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let group = viewModel.getSettingGroup(for: IndexPath(row: 0, section: section)) else { return nil }
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: group.headerIdentifier)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let settingItem = viewModel.getSettingItem(for: indexPath) else {
            fatalError("Expecting a feedItem at index path: \(indexPath)")
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: settingItem.cellIdentifier, for: indexPath)

        if let cell = cell as? SettingCell {
            cell.configure(with: settingItem)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

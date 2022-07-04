//
//  BudgetDataSource.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

struct BudgetDataSource {
    typealias DataSource = RxTableViewSectionedReloadDataSource

    static func dataSource() -> DataSource<BudgetSection> {
        return DataSource<BudgetSection>(
            configureCell: { dataSource, tableView, indexPath, item -> UITableViewCell in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BudgetCell.reuseID, for: indexPath) as? BudgetCell else {
                    return UITableViewCell()
                }
                cell.viewModel.budget.accept(item)
                return cell

            }, titleForHeaderInSection: { dataSource, index in
                return dataSource.sectionModels[index].header
            }
        )
    }
}




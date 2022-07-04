//
//  TransactionDataSource.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

struct TransactionDataSource {
    typealias DataSource = RxTableViewSectionedReloadDataSource

    static func dataSource() -> DataSource<TransactionSection> {
        return DataSource<TransactionSection>(
            configureCell: { dataSource, tableView, indexPath, item -> UITableViewCell in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionPreviewCell.reuseID, for: indexPath) as? TransactionPreviewCell else {
                    return UITableViewCell()
                }
                cell.viewModel.transaction.accept(item)
                return cell

            }, titleForHeaderInSection: { dataSource, index in
                return dataSource.sectionModels[index].header
            }
        )
    }
}




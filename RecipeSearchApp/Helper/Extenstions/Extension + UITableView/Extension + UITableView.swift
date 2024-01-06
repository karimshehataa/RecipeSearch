//
//  Extension + UITableView.swift
//  RecipeSearchApp
//
//  Created by karim  on 06/01/2024.
//

import UIKit

extension UITableView {

    func isLast(for indexPath: IndexPath) -> Bool {

        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1

        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }
}

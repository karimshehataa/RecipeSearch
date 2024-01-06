//
//  FilterCell.swift
//  RecipeSearchApp
//
//  Created by karim  on 03/01/2024.
//

import UIKit
class FilterCell: UICollectionViewCell {
    @IBOutlet weak var filterName: UILabel!
    override var isSelected: Bool {
           didSet {
               self.contentView.backgroundColor = isSelected ? UIColor.lightGray : UIColor.clear
               self.contentView.alpha = isSelected ? 0.75 : 1.0
           }
         }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

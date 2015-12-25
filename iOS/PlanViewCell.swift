//
//  PlanViewCell.swift
//  Cos What
//
//  Created by 周建明 on 15/10/8.
//  Copyright © 2015年 Uncle Jerry. All rights reserved.
//

import UIKit

class PlanViewCell: UITableViewCell {

    // MARK: Properties
    
    //link
    @IBOutlet weak var PhotoImageView: UIImageView!
    @IBOutlet weak var RoleCell: UILabel!
    @IBOutlet weak var AnimeNameCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

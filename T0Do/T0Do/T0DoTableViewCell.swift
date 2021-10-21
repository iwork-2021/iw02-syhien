//
//  T0DoTableViewCell.swift
//  T0Do
//
//  Created by nju on 2021/10/21.
//

import UIKit

class T0DoTableViewCell: UITableViewCell {

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var job: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

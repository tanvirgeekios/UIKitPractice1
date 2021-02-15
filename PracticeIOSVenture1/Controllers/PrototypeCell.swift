//
//  prototypeCell.swift
//  PracticeIOSVenture1
//
//  Created by MD Tanvir Alam on 13/2/21.
//

import UIKit

class PrototypeCell: UITableViewCell {

    @IBOutlet weak var itemNo: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemDescription: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

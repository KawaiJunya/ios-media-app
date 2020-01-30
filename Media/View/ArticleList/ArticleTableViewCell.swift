//
//  ArticleTableViewCell.swift
//  Media
//
//  Created by junya.kawai on 2020/01/30.
//  Copyright © 2020 川井淳矢. All rights reserved.
//

import UIKit

struct ArticleCell {
    let title:  String
    let author: String
    let image:  String
}

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

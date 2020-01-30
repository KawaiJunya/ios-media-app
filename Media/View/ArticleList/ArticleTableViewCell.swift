//
//  ArticleTableViewCell.swift
//  Media
//
//  Created by junya.kawai on 2020/01/30.
//  Copyright © 2020 川井淳矢. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    @IBOutlet weak var likes_count: UILabel!
    func set(article: Article){
        title.text       = article.title
        author.text      = article.user.name
        thumbnail.image  = UIImage(url: article.user.profile_image_url)
        likes_count.text = String(article.likes_count)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

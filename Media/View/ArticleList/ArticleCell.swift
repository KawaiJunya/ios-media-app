//
//  ArticleCell.swift
//  Media
//
//  Created by 川井淳矢 on 2020/01/30.
//  Copyright © 2020 川井淳矢. All rights reserved.
//

import UIKit

final class ArticleCell: UITableViewCell {

    private var task: URLSessionTask?

    override func prepareForReuse() {
        super.prepareForReuse()

        task?.cancel()
        task = nil
        imageView?.image = nil
    }

    func configure(article: Article) {
        task = {
            let url = article.user.profile_image_url
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let imageData = data else {
                    return
                }

                DispatchQueue.global().async { [weak self] in
                    guard let image = UIImage(data: imageData) else {
                        return
                    }

                    DispatchQueue.main.async {
                        self?.imageView?.image = image
                        self?.setNeedsLayout()
                    }
                }
            }
            task.resume()
            return task
        }()

        nameLabel.text = user.login
    }
}

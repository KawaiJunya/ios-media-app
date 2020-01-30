//
//  extension.swift
//  Media
//
//  Created by junya.kawai on 2020/01/30.
//  Copyright © 2020 川井淳矢. All rights reserved.
//

import UIKit

extension UIImage {
    public convenience init(url: String) {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            self.init(data: data)!
            return
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        self.init()
    }
}

//
//  UIImageView.swift
//  RevivalPatient
//
//  Created by phuong.doan on 6/9/21.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func downloadImage(from urlStr: String,
                       placeHolder: String? = nil,
                       isBlur: Bool = false) {
        if let placeholder = placeHolder {
            let placeholderImage = UIImage.init(named: placeholder)
            if let url = URL.init(string: urlStr) {
                if isBlur == false {
                    kf.setImage(with: url, placeholder: placeholderImage)
                } else {
                    let processor = BlurImageProcessor.init(blurRadius: 6)
                    kf.setImage(with: url, placeholder: placeholderImage, options: [.processor(processor)])
                }
            } else {
                image = UIImage.init(named: placeholder)
            }
        } else {
            if let url = URL.init(string: urlStr) {
                if isBlur == false {
                    kf.setImage(with: url)
                } else {
                    let processor = BlurImageProcessor.init(blurRadius: 6)
                    kf.setImage(with: url, placeholder: nil, options: [.processor(processor)])
                }
            } else {
                image = nil
            }
        }
    }
    
    func setImage(base64String: String?) {
        guard let string = base64String?.removingPercentEncoding,
              let url = URL(string: string),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            self.image = UIImage(named: "ic_icon_default")
            return
        }
        self.image = image
    }
}

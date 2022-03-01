//
//  NSMutableAttributedString.swift
//  RevivalPatient
//
//  Created by phuong.doan on 5/26/21.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    func append(string: String,
                font: UIFont = .systemFont(ofSize: 14,
                                           weight: UIFont.Weight.regular),
                color: UIColor = .black) {
        self.append(NSAttributedString(string: string,
                                       attributes: [.font: font,
                                                    .foregroundColor: color]))
    }
}

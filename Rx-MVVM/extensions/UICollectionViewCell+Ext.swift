//
//  UICollectionViewCell+Ext.swift
//  BaseProject
//
//  Created by Văn Tiến Tú on 11/7/18.
//  Copyright © 2018 Văn Tiến Tú. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    class var nib: UINib {
        return UINib(nibName: identifierString, bundle: nil)
    }
    
    class var identifierString: String {
        return String(describing: self)
    }
    
    class func dequeueCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> Self? {
        return collectionView.dequeueCell(self, forIndexPath: indexPath)
    }
}
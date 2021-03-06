//
//  LoadingCell.swift
//  OpenMarket
//
//  Created by κΆλμ on 2022/01/30.
//

import UIKit

final class LoadingCell: UICollectionViewCell {
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func startLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
}

// MARK: - IdentifiableView

extension LoadingCell: IdentifiableView {}

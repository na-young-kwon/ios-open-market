//
//  AViewController.swift
//  OpenMarket
//
//  Created by 권나영 on 2022/01/26.
//

import UIKit

final class ProductDetailsViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountedPriceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Properties
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        return flowLayout
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.isHidden = false

        self.view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

        return loadingIndicator
    }()
    
    private var product: ProductDetails?
    private var images: [ImageData] = []

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    // MARK: - Internal Methods
    
    func fetchDetails(of productID: Int) {
        let apiService = MarketAPIService()
        startLoadingIndicator()
        apiService.fetchProduct(productID: productID) { [weak self] result in
            guard let self = self else {
                return
            }
            self.stopLoadingIndicator()
            switch result {
            case .success(let product):
                self.product = product
                self.images = product.images
                DispatchQueue.main.async {
                    self.setLabels(with: product)
                    self.setNavigationTitle(with: product)
                    self.setPageControl()
                    self.collectionView.reloadData()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.presentAlert(alertTitle: "데이터를 가져오지 못했습니다", alertMessage: "죄송해요") { _ in
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
}

// MARK: - Private Methods

extension ProductDetailsViewController {
    private func setLabels(with product: ProductDetails) {
        let presentation = getPresentation(product: product, identifier: ProductDetailsViewController.identifier)
        
        setProductNameLabel(with: presentation)
        setStockLabel(with: presentation)
        setPriceLabel(with: presentation)
        setDiscountedPriceLabel(with: presentation)
        descriptionLabel.text = product.description
    }
    
    private func setProductNameLabel(with presentation: ProductUIPresentation) {
        productNameLabel.text = presentation.productNameLabelText
        productNameLabel.font = presentation.productNameLabelFont
    }
    
    private func setStockLabel(with presentation: ProductUIPresentation) {
        stockLabel.text = presentation.stockLabelText
        stockLabel.textColor = presentation.stockLabelTextColor
    }
    
    private func setPriceLabel(with presentation: ProductUIPresentation) {
        priceLabel.text = presentation.priceLabelText
        priceLabel.textColor = presentation.priceLabelTextColor
        priceLabel.attributedText = presentation.priceLabelIsCrossed ? priceLabel.convertToAttributedString(from: priceLabel) : nil
    }
    
    private func setDiscountedPriceLabel(with presentation: ProductUIPresentation) {
        discountedPriceLabel.text = presentation.discountedLabelText
        discountedPriceLabel.textColor = presentation.discountedLabelTextColor
        discountedPriceLabel.isHidden = presentation.discountedLabelIsHidden
    }
    
    private func setNavigationTitle(with product: ProductDetails) {
        navigationController?.title = product.name
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = flowLayout
    }
    
    private func setPageControl() {
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .gray
    }
    
    private func startLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    private func stopLoadingIndicator() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ProductDetailsViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return images.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductDetailsImageCell.identifier,
            for: indexPath) as? ProductDetailsImageCell else {
            return UICollectionViewCell()
        }
        let imageURL = images[indexPath.row].url
        cell.configure(with: imageURL)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProductDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        return CGSize(width: width, height: height)
    }

    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        targetContentOffset.pointee = scrollView.contentOffset
        var indexes = self.collectionView.indexPathsForVisibleItems
        indexes.sort()
        var index = indexes.first!
        let cell = self.collectionView.cellForItem(at: index)!
        let position = self.collectionView.contentOffset.x - cell.frame.origin.x
        if position > cell.frame.size.width / 2 {
            index.row = index.row + 1
        }
        self.collectionView.scrollToItem(at: index, at: .left, animated: true)
        pageControl.currentPage = index.row
    }
}

// MARK: - ProductUIPresentable

extension ProductDetailsViewController: ProductUIPresentable {}

// MARK: - IdentifiableView

extension ProductDetailsViewController: IdentifiableView { }

import UIKit
import Kingfisher

class SlideshowView: UIView {
    private let imageView = UIImageView()
    var imageUrls: [URL] = [] {
        didSet {
            startSlideshow()
        }
    }
    private var currentIndex = 0
    private var timer: Timer?

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)

        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func startSlideshow() {
        guard !imageUrls.isEmpty else { return }
        loadImage(at: currentIndex)

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.currentIndex = (self.currentIndex + 1) % self.imageUrls.count
            self.loadImage(at: self.currentIndex)
        }
    }

    private func loadImage(at index: Int) {
        let url = imageUrls[index]
        imageView.kf.setImage(with: url)
    }

    func stopSlideshow() {
        timer?.invalidate()
        timer = nil
    }

    deinit {
        stopSlideshow()
    }
}

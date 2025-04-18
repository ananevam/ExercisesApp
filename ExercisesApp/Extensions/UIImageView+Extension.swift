import UIKit

extension UIImageView {
    // https://gist.github.com/algal/03e661630a6869c883d9d915d5ecccbc
    // устанавливает изображение и меняет высоту
    func setImageWithAspectFit(_ image: UIImage?) {
        guard let image = image else { return }
        self.image = image
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true

        setAspectRatioConstraint()
    }
    // устанавливает url изображения и меняет высоту
    func setImageWithAspectFit(with url: URL?) {
        guard let url = url else { return }
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true

        self.kf.setImage(with: url) { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let value):
                let imageSize = value.image.size
                guard imageSize.width > 0 else { return }

                let aspectRatio = imageSize.height / imageSize.width

                self.snp.remakeConstraints { make in
                    make.height.equalTo(self.snp.width).multipliedBy(aspectRatio)
                }
            case .failure:
                // Handle error or use default image
                break
            }
        }
    }
    // меняет высоту если изображение имеется
    func setAspectRatioConstraint() {
        guard let image = self.image else { return }
        let aspectRatio = image.size.height / image.size.width

        self.snp.remakeConstraints { make in
            make.height.equalTo(self.snp.width).multipliedBy(aspectRatio)
        }
    }
}

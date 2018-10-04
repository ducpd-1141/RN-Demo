import UIKit

extension UIImageView {

    func frameImageWithScaleFit() -> CGRect {
        let imageViewSize = self.frame.size
        guard let imageSize = self.image?.size else {
            return CGRect.zero
        }
        let imageRatio = imageSize.width / imageSize.height
        let imageViewRatio = imageViewSize.width / imageViewSize.height
        if imageRatio < imageViewRatio {
            let scaleFactor = imageViewSize.height / imageSize.height
            let width = imageSize.width * scaleFactor
            let topLeftX = (imageViewSize.width - width) * 0.5
            return CGRect(x: topLeftX, y: 0, width: width, height: imageViewSize.height)
        } else {
            let scalFactor = imageViewSize.width / imageSize.width
            let height = imageSize.height * scalFactor
            let topLeftY = (imageViewSize.height - height) * 0.5
            return CGRect(x: 0, y: topLeftY, width: imageViewSize.width, height: height)
        }
    }

    func centerOfImageFrame() -> CGPoint {
        let frame = frameImageWithScaleFit()
        let centerX = frame.origin.x + (frame.width - bounds.width) / 2
        let centerY = frame.origin.y + (frame.height - bounds.height) / 2
        return CGPoint(x: centerX, y: centerY)
    }

    func zoomScaleToFill() -> CGFloat {
        guard let imageSize = image?.size else {
            return 1.0
        }
        let imageViewSize = bounds.size
        let isFitHeight = frameImageWithScaleFit().origin.x != 0
        var zoom: CGFloat = 1.0
        if isFitHeight {
            let scaleRatio = imageSize.height / imageViewSize.height
            let imageWidthInView = imageSize.width / scaleRatio
            zoom = imageViewSize.width / imageWidthInView
        } else {
            let scaleRatio = imageSize.width / imageViewSize.width
            let imageHeightInView = imageSize.height / scaleRatio
            zoom = imageViewSize.height / imageHeightInView
        }
        return zoom
    }

    func zoomScaleToFill(left: CGFloat, top: CGFloat) -> CGFloat {
        guard let imageSize = image?.size else {
            return 1.0
        }
        let imageViewSize = bounds.size
        let isFitHeight = frameImageWithScaleFit().origin.x != 0
        var zoom: CGFloat = 1.0
        if isFitHeight {
            let scaleRatio = imageSize.height / imageViewSize.height
            let imageWidthInView = imageSize.width / scaleRatio
            zoom = (imageViewSize.width + left) / imageWidthInView
        } else {
            let scaleRatio = imageSize.width / imageViewSize.width
            let imageHeightInView = imageSize.height / scaleRatio
            zoom = (imageViewSize.height + top) / imageHeightInView
        }
        return zoom
    }

    func addBlurEffect(alpha: CGFloat = 0.5) {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.alpha = alpha
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        addSubview(blurEffectView)
    }
}

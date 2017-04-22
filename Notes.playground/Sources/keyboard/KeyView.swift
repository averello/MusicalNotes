import UIKit
import QuartzCore

final public class KeyView: UIView {
	public override init(frame: CGRect) {
		if frame == CGRect.zero {
			super.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
		}
		else {
			super.init(frame: frame)
		}



		self.backgroundColor = UIColor.black
		self.layer.cornerRadius = self.bounds.size.width.divided(by: 2)
	}
	
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//extension KeyView: CustomPlaygroundQuickLookable {
//	public var customPlaygroundQuickLook: PlaygroundQuickLook {
//		return PlaygroundQuickLook.view(self.layer)
//	}
//}

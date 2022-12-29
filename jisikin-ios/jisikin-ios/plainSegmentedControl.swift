//
//  plainSegmentedControl.swift
//  jisikin-ios
//
//  Created by 박정헌 on 2022/12/28.
//

import Foundation
import UIKit
// https://ios-development.tistory.com/963
class PlainSegmentedControl:UISegmentedControl{
    override init(frame: CGRect) {
      super.init(frame: frame)
      self.removeBackgroundAndDivider()
    }
    override init(items: [Any]?) {
      super.init(items: items)
      self.removeBackgroundAndDivider()
    }
    required init?(coder: NSCoder) {
      fatalError()
    }
    
    private func removeBackgroundAndDivider() {
      let image = UIImage()
      self.setBackgroundImage(image, for: .normal, barMetrics: .default)
      self.setBackgroundImage(image, for: .selected, barMetrics: .default)
      self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
      
      self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
}

//
//  Constant.swift
//  DarshanaDRCPractical
//
//  Created by Ravi on 02/07/23.
//

import Foundation
import UIKit


let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}


extension UIViewController {
    
    static let DELAY_SHORT = 1.5
      static let DELAY_LONG = 3.0

      func showToast(message : String) {
          let label = ToastLabel()
          label.backgroundColor = UIColor.blue
          label.textColor = .white
          label.textAlignment = .center
          label.font = UIFont.systemFont(ofSize: 14)
          label.alpha = 0
          label.text = message
          label.clipsToBounds = true
          label.layer.cornerRadius = 20
          label.numberOfLines = 0
          label.textInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
          label.translatesAutoresizingMaskIntoConstraints = false
          view.addSubview(label)

          let saveArea = view.safeAreaLayoutGuide
          label.centerXAnchor.constraint(equalTo: saveArea.centerXAnchor, constant: 0).isActive = true
          label.leadingAnchor.constraint(greaterThanOrEqualTo: saveArea.leadingAnchor, constant: 15).isActive = true
          label.trailingAnchor.constraint(lessThanOrEqualTo: saveArea.trailingAnchor, constant: -15).isActive = true
          label.bottomAnchor.constraint(equalTo: saveArea.bottomAnchor, constant: -30).isActive = true

          UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
              label.alpha = 1
          }, completion: { _ in
              UIView.animate(withDuration: 4.0, delay: UIViewController.DELAY_SHORT, options: .curveEaseOut, animations: {
                  label.alpha = 0
              }, completion: {_ in
                  label.removeFromSuperview()
              })
          })
      }
}


class ToastLabel: UILabel {
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }

    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top, left: -textInsets.left, bottom: -textInsets.bottom, right: -textInsets.right)

        return textRect.inset(by: invertedInsets)
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}


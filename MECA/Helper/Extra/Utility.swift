

import Foundation
import UIKit

class UtilesSwift :NSObject {
    
    static let  shared = UtilesSwift()
    
    func showAlert(text:String, icon:String){
        
        var originY:CGFloat = 0.0
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.bounds.height >= 812 {
            originY = 20
        }
        let errorView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: 0))
        errorView.backgroundColor = ThemeManager.currentTheme().white
        errorView.clipsToBounds = false
        errorView.layer.masksToBounds = false
        errorView.layer.shadowOffset = CGSize(width: 0, height: 1)
        errorView.layer.shadowOpacity = 0.2
        errorView.layer.shadowRadius = 1
        errorView.layer.cornerRadius = 2
        let lb_error = UILabel(frame: CGRect(x:  UIScreen.main.bounds.width * 0.23, y: 0, width: UIScreen.main.bounds.width * 0.78, height: 0))
        lb_error.numberOfLines = 0
        lb_error.textAlignment = .left
        lb_error.textColor = ThemeManager.currentTheme().black
        lb_error.font = UIFont.systemFont(ofSize: 16)
        lb_error.text = text
        
        let noNet_ico = UIImageView(frame: CGRect(x: 0, y: -35, width: UIScreen.main.bounds.width * 0.23, height: 70))
        noNet_ico.image = UIImage(named: icon)
        noNet_ico.contentMode = .center
        
        errorView.addSubview(lb_error)
        UtilesSwift.shared.getTopViewController().view.addSubview(errorView)
        errorView.addSubview(noNet_ico)
        UIView.animate(withDuration: 0.4, animations: {
            errorView.frame = CGRect(x: 0, y: originY, width: UIScreen.main.bounds.width, height: 80)
            lb_error.frame = CGRect(x:  UIScreen.main.bounds.width * 0.23, y: 20, width: UIScreen.main.bounds.width * 0.78, height: 60)
            noNet_ico.frame = CGRect(x: 0, y: 15, width: UIScreen.main.bounds.width * 0.23, height: 70)
        }, completion: {
            finished in
            UIView.animate(withDuration: 0.3, delay: 2.5, options: .curveEaseIn, animations: {
                errorView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0)
                lb_error.frame = CGRect(x:  UIScreen.main.bounds.width * 0.23, y: 0, width: UIScreen.main.bounds.width * 0.78, height: 0)
                noNet_ico.frame = CGRect(x: 0, y: -35, width:  UIScreen.main.bounds.width * 0.23, height: 70)
            }, completion: {finished in
                errorView.removeFromSuperview()
            })
        })
    }
    
    func getTopViewController()->UIViewController{
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return UIViewController()
    }
}

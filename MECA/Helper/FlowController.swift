

import Foundation
import UIKit

class FlowController:NSObject{
    
    func instantiateViewController(identifier:String, storyBoard:String)->UIViewController{
       return getStoryboard(name: storyBoard).instantiateViewController(withIdentifier: identifier)
        
    }
    func getStoryboard(name:String)->UIStoryboard{
        return UIStoryboard(name: name, bundle: nil)
    }
}

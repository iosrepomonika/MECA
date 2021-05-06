

import UIKit
import WebKit

class PDFReaderVC: UIViewController, WKNavigationDelegate {
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var webVIew: WKWebView!
var isFromTab = ""
    var isFromDetailPage = false
    var detailPageurl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webVIew.navigationDelegate = self
        // Do any additional setup after loading the view.
        if isFromDetailPage{
            isFromDetailPage = false
            setURL(url: detailPageurl)
        }else{
        callMEBITFeedWebservice()
        }
    }
    func setURL(url : String) {

        let url = URL(string: url)!
        webVIew.load(URLRequest(url: url))
        webVIew.allowsBackForwardNavigationGestures = true

    }
    
    func callMEBITFeedWebservice() {
        GlobalObj.displayLoader(true, show: true)
        APIClient.webserviceForMEBITList { [self] (result) in
            if let dic = result.pdf_links{
                GlobalObj.displayLoader(true, show: false)
                if self.isFromTab == "what_is_mebit"{
                    setURL(url: dic.what_is_mebit ?? "")
                }else if self.isFromTab == "Overall"{
                    setURL(url: dic.over_all_schedule ?? "")
                }
            }
        
            
        }
    }
}


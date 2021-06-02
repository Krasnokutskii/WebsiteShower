//
//  ViewController.swift
//  Project4
//
//  Created by Ярослав on 3/24/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate{
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = [String]()
    
    override func loadView() {
        //super.loadView()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "open", style: .plain, target: self, action: #selector(butonTapped))
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        let backButton = UIBarButtonItem(barButtonSystemItem: .add, target: webView, action: #selector(webView.goBack))
        let forwardButton = UIBarButtonItem(barButtonSystemItem:.fastForward, target: webView, action: #selector(webView.goForward))
        
        toolbarItems = [backButton,forwardButton ,progressButton ,space,refresh]
        navigationController?.isToolbarHidden = false
         
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        
    }
  

    @objc func butonTapped(){
        
        let ac = UIAlertController(title: "open", message: nil, preferredStyle: .actionSheet)
        for website in websites{
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "9anime.org", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "cancel", style: .cancel))
        
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
        
    }
    
    
    @objc func openPage(action: UIAlertAction){
        let url = URL(string: "https://" + action.title!)
        webView.load(URLRequest(url: url!))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url!
//        if let host = url.host{
//            if websites.contains(host) == false{
//                wrongURLtapped()
//            }
//        }
        
        
        if let host = url.host{
            for website in websites{
                if host.contains(website){
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
    }
    
    
//    func wrongURLtapped(){
//        let ac = UIAlertController(title: "error", message: "it's blocked", preferredStyle: .alert)
//        ac.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
//        present(ac, animated: true)
//    }
}

    

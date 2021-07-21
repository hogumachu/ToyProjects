//
//  InstagramViewController.swift
//  HogumachuTalk
//
//  Created by 홍성준 on 2021/07/20.
//

import UIKit
import WebKit

class InstagramViewController: UIViewController {
    
    let closeButton = UIButton()
    let forwardButton = UIButton()
    let backwardButton = UIButton()
    let reloadButton = UIButton()
    let buttonStackView = UIStackView()
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        draw()
        loadInitialWebView()
        
    }
    
    @objc func close(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func forward(sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @objc func backward(sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc func reload(sender: UIButton) {
        webView.reload()
    }
    
    func loadInitialWebView() {
        guard let url = URL(string: "https://www.instagram.com/hogumachu/") else {
            fatalError("올바르지 않은 URL 임둥")
        }
        
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    
    func draw() {
        addViews()
        setViews()
        setConstraints()
    }
    
    func addViews() {
        view.addSubViews(UIViews: [
            webView,
            buttonStackView.addSubViewsAndReturnSelf(UIViews: [
                closeButton,
                forwardButton,
                backwardButton,
                reloadButton,
            ])
        ])
    }
    
    func setViews() {
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .fill
        buttonStackView.contentMode = .scaleToFill
        buttonStackView.backgroundColor = .white
        
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.red, for: .normal)
        closeButton.addTarget(self, action: #selector(close(sender: )), for: .touchUpInside)
        
        forwardButton.setTitle("Forward", for: .normal)
        forwardButton.setTitleColor(.systemBlue, for: .normal)
        forwardButton.addTarget(self, action: #selector(forward(sender:)), for: .touchUpInside)
        
        backwardButton.setTitle("Backward", for: .normal)
        backwardButton.setTitleColor(.systemBlue, for: .normal)
        backwardButton.addTarget(self, action: #selector(backward(sender:)), for: .touchUpInside)
        
        reloadButton.setTitle("Reload", for: .normal)
        reloadButton.setTitleColor(.systemBlue, for: .normal)
        reloadButton.addTarget(self, action: #selector(reload(sender:)), for: .touchUpInside)
    }
    
    
    func setConstraints() {
        translatesAutoresizingMaskIntoConstraints(UIViews: [
            closeButton, forwardButton, backwardButton, reloadButton, webView, buttonStackView
        ])
        
        let buttonHeight: CGFloat = 15
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor),
            
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            closeButton.leadingAnchor.constraint(equalTo: buttonStackView.leadingAnchor),
            closeButton.bottomAnchor.constraint(equalTo: buttonStackView.bottomAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            forwardButton.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor),
            forwardButton.bottomAnchor.constraint(equalTo: buttonStackView.bottomAnchor),
            forwardButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            backwardButton.leadingAnchor.constraint(equalTo: forwardButton.trailingAnchor),
            backwardButton.bottomAnchor.constraint(equalTo: buttonStackView.bottomAnchor),
            backwardButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            reloadButton.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor),
            reloadButton.leadingAnchor.constraint(equalTo: backwardButton.trailingAnchor),
            reloadButton.bottomAnchor.constraint(equalTo: buttonStackView.bottomAnchor),
            reloadButton.heightAnchor.constraint(equalToConstant: buttonHeight),
        ])
    }
}

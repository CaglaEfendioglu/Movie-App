//
//  Label.swift
//  MovieApp
//
//  Created by Cagla Efendioğlu on 30.01.2023.
//

import UIKit

class CustomLabel: UILabel {
    
    private var label: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.textAlignment = .center
        self.font = UIFont(name: "Poppins-Medium", size: 15)
        self.numberOfLines = 0
    }
    
    func labelText(text: String) {
        self.text = text
    }
}

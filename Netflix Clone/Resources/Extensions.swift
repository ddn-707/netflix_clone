//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Jos Nguyen on 28/10/2023.
//

import Foundation

extension String{
    func capitalizeFirstLetter() -> String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

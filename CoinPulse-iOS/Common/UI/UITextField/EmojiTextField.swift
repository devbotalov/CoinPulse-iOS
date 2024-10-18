//
//  EmojiTextField.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 18.10.2024.
//

import UIKit

class EmojiTextField: UITextField, UITextFieldDelegate {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        
        for scalar in string.unicodeScalars {
            if !isEmoji(scalar) {
                return false
            }
        }
        return true
    }
    
    private func isEmoji(_ scalar: UnicodeScalar) -> Bool {
        switch scalar.value {
        case 0x1F600...0x1F64F,     // Смайлики
             0x1F300...0x1F5FF,     // Символы и пиктограммы
             0x1F680...0x1F6FF,     // Транспорт и символы
             0x1F1E6...0x1F1FF,     // Флаги (региональные коды)
             0x2600...0x26FF,       // Разные символы
             0x2700...0x27BF,       // Разные символы
             0xFE00...0xFE0F,       // Варианты представления (Emoji Modifier)
             0x1F900...0x1F9FF,     // Символы дополненной реальности и новые эмодзи
             0x1FA70...0x1FAFF:     // Новые пиктограммы и эмодзи
            return true
        default:
            return false
        }
    }
}

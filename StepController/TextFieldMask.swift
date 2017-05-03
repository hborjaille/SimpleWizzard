//
//  TextFieldCPF.swift
//  eSegurado
//
//  Created by Eduardo Motta on 21/03/17.
//  Copyright © 2017 Evológica. All rights reserved.
//


//  Para adicionar uma mascara CPF/CNPJ ao seu textView:
//  1.  retorne o metodo:
//          shoudChangeCharactersInMask(_ textField: UITextField, ...
//      no retorno do metodo do UITextViewDelegate:
//          textField(_ textField: UITextField, shouldChangeCharactersIn ...
//
//  2.  chame o metodo:
//          addMaskToTextField(_ textField: UITextField)
//      de dentro de uma action criada para o evento Editing Changed:
//          Ex: @IBAction func userFieldEditingChanged(_ sender: UITextField)
//

import UIKit

class TextFieldMask {
    
    private static let digits: [Character] = ["0","1","2","3","4","5","6","7","8","9"]
    
    //  Habilita/Desabilita a edicao e ajusta a posicao do cursor verificando o tipo dos caracteres adicionados,
    //  os comandos de entrada e o tamanho do campo de texto.
    public static func shoudChangeCharactersInMask (_ textField: UITextField, replacementString string: String, mask: String, pattern: Character) -> Bool {
        
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        // Detecta backspace
        if string == "" && isBackSpace == -92 {
            
            let cursorPosition = textField.offset(from: textField.beginningOfDocument, to: (textField.selectedTextRange?.start)!)
            
            if let text = textField.text{
                let deletedCharIndex = text.characters.index(text.startIndex, offsetBy: cursorPosition-1)
                let deletedChar = text[deletedCharIndex]
                
                if digits.contains(deletedChar) == false { // Detecta se backspace executa sobre um simbolo. Ex: '.', '/', '-'
                    let numberIndex = text.characters.index(text.startIndex, offsetBy: cursorPosition - 2)
                    textField.text?.remove(at: numberIndex) // Remove valor antes do simbolo
                    
                    self.applyMask(toTextField: textField, mask: mask, pattern: pattern) // Formata string
                    
                    let targetPosition = textField.position(from: textField.beginningOfDocument, offset: cursorPosition - 2)
                    if let target = targetPosition {
                        textField.selectedTextRange = textField.textRange(from: target, to: target) // Reposiciona cursor
                    }
                    
                    return false
                }
            }
        }
        
        // Detecta Delete
        if string == "" {
            return true
        }
        
        // Detecta caracteres invalidos de entrada e limite maximo do campo
        if textField.text!.characters.count >= 18 || isInvalidInput(string){
            return false
        }
        
        // Ajusta cursor em entradas sucedidas por simbolo
        let initialLength = textField.text?.characters.count ?? 0
        let targetCursorPosition = textField.offset(from: textField.beginningOfDocument, to: (textField.selectedTextRange?.start)!) // Current cursor position index
        if initialLength != targetCursorPosition {
            let text = textField.text!
            let nextChar: Character = text[text.index(text.startIndex, offsetBy: targetCursorPosition)]
            print(nextChar)
            if !digits.contains(nextChar) {
                let targetPosition = textField.position(from: textField.beginningOfDocument, offset: targetCursorPosition + 1 )
                if let target = targetPosition {
                    textField.selectedTextRange = textField.textRange(from: target, to: target) // Set new cursor position
                }

            }
        }
        return true
    }
    
    // Aplica a formatacao definida em applyMask e ajusta o cursor
    public static func addMaskToTextField(_ textField: UITextField, mask: String, pattern: Character) {
        let initialLength = textField.text?.characters.count ?? 0
        let targetCursorPosition = textField.offset(from: textField.beginningOfDocument, to: (textField.selectedTextRange?.start)!) // Current cursor position index
        
        self.applyMask(toTextField: textField, mask: mask, pattern: pattern)
        
        let finalLength = textField.text?.characters.count ?? 0
        let extraCharsAdded = finalLength > initialLength ? finalLength - initialLength : 0 //Dedecta a adicao de novos simbolos
        
        let targetPosition = textField.position(from: textField.beginningOfDocument, offset: targetCursorPosition + extraCharsAdded )
        if let target = targetPosition {
            textField.selectedTextRange = textField.textRange(from: target, to: target) // Set new cursor position
        }
    }

    // Retorna false se a string possui caracteres invalidos (nao numeros)
    // ou true caso contrario
    private static func isInvalidInput(_ string: String) -> Bool {
        let arrayNumbers = string.characters.filter { (char) -> Bool in
            return digits.contains(char)
        }
        return arrayNumbers.count < string.characters.count
    }
    
    // Define as configuracoes da mascara de entrada
    private static func applyMask(toTextField textField: UITextField, mask: String, pattern: Character) {
        if let text = textField.text {
            textField.text! = formatStringNumber(text, mask: mask, pattern: pattern)
        }
    }
    
    // Retorna uma string contendo os numeros da string original de entrada formatada de acordo com applyMask.
    public static func formatStringNumber(_ stringNumber: String, mask: String, pattern: Character) -> String {
        
        var arrayNumbers = stringNumber.characters.filter { (char) -> Bool in
            return digits.contains(char)
        }
        var arrayMask = Array(mask.characters)
        
        for i in 0..<arrayMask.count {
            if i < arrayNumbers.count {
                if arrayMask[i] != pattern {
                    arrayNumbers.insert(arrayMask[i], at: i)
                }
            }
        }

        let newStringNumbers = String(arrayNumbers)
        
        if arrayNumbers.count > arrayMask.count {
            return newStringNumbers.substring(to: mask.endIndex)
        }
        return newStringNumbers
    }
    
    // Retorna uma string contendo somente numeros, sem os caracteres da mascara
    public static func removeMask(from string: String) -> String {
        let arrayNumbers = string.characters.filter { (char) -> Bool in
            return digits.contains(char)
        }
        return String(arrayNumbers)
    }
}


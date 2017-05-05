//
//  ExpandableInvoiceTableViewController.swift
//  eSegurado
//
//  Created by Higor Borjaille on 05/05/17.
//  Copyright © 2017 Evológica. All rights reserved.
//

import UIKit

class ExpandableInvoiceTableViewController: ExpandableCommonTable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "pt_BR")
        
        let numberFormatter = NumberFormatter()
        
        if let apolice = self.field as? Apolice {
            if let financeiro =  apolice.financeiro?.field {
                
                
                var valorTotal = financeiro.findAttribute("PremioTotal")?.data?.replacingOccurrences(of: ".", with: ",")
                valorTotal = currencyFormatter.string(from: numberFormatter.number(from: self.returnFormatedNumber(valorTotal))!)
                
                var valorLiquido = financeiro.findAttribute("PremioLiquido")?.data?.replacingOccurrences(of: ".", with: ",")
                valorLiquido = currencyFormatter.string(from: numberFormatter.number(from: self.returnFormatedNumber(valorLiquido))!)
                
                var fracionamento = financeiro.findAttribute("AdicionalFracionamento")?.data?.replacingOccurrences(of: ".", with: ",")
                fracionamento = currencyFormatter.string(from: numberFormatter.number(from: self.returnFormatedNumber(fracionamento))!)
                
                var custoEmissao = financeiro.findAttribute("CustoEmissao")?.data?.replacingOccurrences(of: ".", with: ",")
                custoEmissao = currencyFormatter.string(from: numberFormatter.number(from: self.returnFormatedNumber(custoEmissao))!)
                
                var iof = financeiro.findAttribute("IOF")?.data?.replacingOccurrences(of: ".", with: ",")
                iof = currencyFormatter.string(from: numberFormatter.number(from: self.returnFormatedNumber(iof))!)
                
                let convenio = financeiro.findAttribute("Convenio")?.data
                var dados = [
                    CellDescription(title: "Valor Total" , detail: valorTotal),
                    CellDescription(title: "Valor Líquido" , detail: valorLiquido),
                    CellDescription(title: "Fracionamento" , detail: fracionamento),
                    CellDescription(title: "Custo de Emissão" , detail: custoEmissao),
                    CellDescription(title: "IOF" , detail: iof),
                    CellDescription(title: "Convênio" , detail: convenio)
                ]
                
                if let liquidacaoPadrao = financeiro.childField("LiquidacaoPadrao") {
                    let forma = liquidacaoPadrao.findAttribute("Forma")?.data
                    
                    dados.append(CellDescription(title: "Forma de Líquidação" , detail: forma))
                    if forma == "DEBITO EM CONTA" {
                        if let contaCorrente = liquidacaoPadrao.childField("ContaCorrente") {
                            dados.append(CellDescription(title: "Banco" , detail: contaCorrente.findAttribute("Banco")?.data))
                            dados.append(CellDescription(title: "Agência" , detail: contaCorrente.findAttribute("Agencia")?.data))
                            dados.append(CellDescription(title: "Número da Conta" , detail: contaCorrente.findAttribute("NumeroConta")?.data))
                        }
                    }
                }
                
                sections.append(SectionDescription(title: "LIQUIDAÇÃO PADRÃO", detail: nil, imageName: "", items: dados, collapsed: false, cellType: CellType.headerThird))
                
                if let parcelamento = financeiro.childField("Parcelamento") {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    
                    var dados = [CellDescription]()
                    
                    if let dateString = parcelamento.findAttribute("VencimentoPrimeiraParcela")?.data {
                        let vencimento = dateFormatter.date(from: dateString)!
                        dateFormatter.dateStyle = .short
                        dateFormatter.doesRelativeDateFormatting = true
                        dados.append(CellDescription(title: "Vencimento" , detail: dateFormatter.string(from: vencimento)))
                    }
                    
                    dados.append(CellDescription(title: "Qtd. Parcelas" , detail: parcelamento.findAttribute("Quantidade")?.data))
                    
                    var valorParcela = parcelamento.findAttribute("Valor")?.data?.replacingOccurrences(of: ".", with: ",")
                    valorParcela = currencyFormatter.string(from: numberFormatter.number(from: self.returnFormatedNumber(valorParcela))!)
                    dados.append(CellDescription(title: "Valor da Parcela" , detail: valorParcela))
                    
                    sections.append(SectionDescription(title: "PARCELAMENTO", detail: nil, imageName: "", items: dados, collapsed: false, cellType: CellType.headerThird))
                    
                    dados.removeAll()
                    dados.append(CellDescription(title: nil , detail: "Número", titleSecond: nil, detailSecond: "Valor (R$)", titleThird: nil, detailThird: "Vencimento"))
                    
                    for parcela in parcelamento.childFields {
                        
                        let numero = parcela.findAttribute("Numero")?.data
                        let premio = parcela.findAttribute("PremioLiquido")?.data?.replacingOccurrences(of: ".", with: ",")
                        
                        if let vencStr = parcela.findAttribute("Vencimento")?.data {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                            
                            let vencimento = dateFormatter.date(from: vencStr)!
                            
                            dateFormatter.dateStyle = .short
                            dateFormatter.doesRelativeDateFormatting = true
                            let vencimentoStr = dateFormatter.string(from: vencimento)
                            
                            dados.append(CellDescription(title: nil , detail: numero, titleSecond: nil, detailSecond: premio, titleThird: nil, detailThird: vencimentoStr))
                        }
                    }
                    
                    sections.append(SectionDescription(title: "PARCELAS", detail: nil, imageName: "", items: dados, collapsed: false, cellType: CellType.headerThird))
                }
                
                
            }
        }
        
    }
    
    func addLineOverHeader(label: UILabel) {
        let lineView = UIView ()
        lineView.backgroundColor = Colors.primary
        label.addSubview(lineView)
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: lineView, attribute: .bottom, relatedBy: .equal, toItem: label, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: lineView, attribute: .leading, relatedBy: .equal, toItem: label, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: lineView, attribute: .trailing, relatedBy: .equal, toItem: label, attribute: .trailing, multiplier: 1.0, constant: 0.0).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
    }
    
    func returnFormatedNumber(_ str: String?) -> String {
        if let str = str {
            if str.characters.count > 0 {
                return str.replacingOccurrences(of: ".", with: ",")
            }
        }
        return "0,00"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            let sectionIndex = indexPath.section
            switch sections[sectionIndex].cellType {
            case .headerFirst:
                return 65
            case .headerSecond:
                return 50
            case .headerThird:
                return 50
            default:
                break
            }
        }
        return 50 // for cells
    }

}

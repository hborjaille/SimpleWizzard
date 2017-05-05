//
//  ExpandableInvoiceTableViewController.swift
//  eSegurado
//
//  Created by Higor Borjaille on 05/05/17.
//  Copyright © 2017 Evológica. All rights reserved.
//

import UIKit

class ExpandableGeneralTableViewController: ExpandableCommonTable {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        
        if let apolice = self.field as? Apolice {
            var dados = [CellDescription]()
            
            if let dataEmissao = apolice.dataEmissao as Date? {
                dados.append(CellDescription(title: "Emissão" , detail: dateFormatter.string(from: dataEmissao)))
            }
            
            if let inicioVigencia = apolice.inicioVigencia as Date?, let fimVigencia = apolice.fimVigencia as Date? {
                dados.append(CellDescription(title: "Vigência" , detail: dateFormatter.string(from: inicioVigencia) + " - " + dateFormatter.string(from: fimVigencia)))
            }
            
            let generalSection = SectionDescription(title: "Processo SUSEP", detail: apolice.numeroApoliceSUSEP, imageName: "", items: dados, collapsed: false, cellType: CellType.cellFirst)
            let proponenteSection = SectionDescription(title: "PROPONENTE", detail: nil, imageName: "", items: nil, collapsed: true, cellType: CellType.headerThird)
            proponenteSection.field = apolice.proponente
            let corretores = SectionDescription(title: "CORRETORES", detail: nil, imageName: "", items: nil, collapsed: true, cellType: CellType.headerThird)
            corretores.field = apolice.corretores
            
            sections.append(contentsOf: [generalSection, proponenteSection, corretores])
        }
        
        if let proponente = self.field as? Proponente {
            // Dados Proponente
            var dados = [CellDescription]()
            
            let cpf = proponente.cpfCNPJ ?? ""
            if cpf.characters.count < 15 {
                dados.append(CellDescription(title: "CPF/CNPJ" , detail: TextFieldCpfMask.formatStringNumber(cpf, mask:"111.111.111-11", pattern: "1")))
            } else {
                dados.append(CellDescription(title: "CPF/CNPJ" , detail: TextFieldCpfMask.formatStringNumber(cpf, mask:"11.111.111/1111-11", pattern: "1")))
            }
            
            dados.append(CellDescription(title: "Física/Jurídica" , detail: proponente.tipo))
            
            if let dataNascimento = proponente.dataNascimento as Date? {
                dados.append(CellDescription(title: "Data de Nascimento" , detail: dateFormatter.string(from: dataNascimento)))
            }
            
            dados.append(CellDescription(title: "Sexo" , detail: proponente.sexo))
            dados.append(CellDescription(title: "Física/Jurídica" , detail: proponente.tipoAtividade))
            
            if let endereco = proponente.endereco {
                dados.append(CellDescription(title: "Física/Jurídica" , detail: endereco.logradouro! + ", " + endereco.bairro! + ", " + endereco.cidade!))
            }
            
            sections.append(SectionDescription(title: "Nome", detail: proponente.nome, imageName: "", items: dados, collapsed: false, cellType: CellType.cellFirst))
        }
        
        if let corretores = self.field as? NSSet? {
            if let corretores = corretores {
                for c in corretores {
                    let corretor = c as! Corretor
                    let dados = [
                        CellDescription(title: "Código SUSEP" , detail: corretor.codigoSUSEP),
                        CellDescription(title: "Matrícula Indicador" , detail: corretor.matriculaIndicador),
                        CellDescription(title: "Filial" , detail: corretor.filial),
                        CellDescription(title: "Participação" , detail: corretor.participacao),
                        CellDescription(title: "Principal" , detail: corretor.principal)
                    ]
                    sections.append(SectionDescription(title: corretor.nome ?? "", detail: nil, imageName: "", items: dados, collapsed: true, cellType: CellType.headerSecond))
                }
            }
        }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            if let apolice = field as? Apolice {
                let sectionIndex = indexPath.section
                switch sections[sectionIndex].cellType {
                case .headerThird:
                    let controller = storyboard?.instantiateViewController(withIdentifier: "generalSID") as! ExpandableGeneralTableViewController
                    switch sections[sectionIndex].title! {
                    case "PROPONENTE":
                        controller.title = "Proponente"
                        controller.field = apolice.proponente
                        break
                    case "CORRETORES":
                        controller.title = "Corretores"
                        controller.field = apolice.corretores
                        break
                    default:
                        return
                    }
                    
                    self.navigationController?.pushViewController(controller, animated: true)
                    break
                default:
                    break
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            let sectionIndex = indexPath.section
            switch sections[sectionIndex].cellType {
            case .headerFirst:
                return 65
            case .headerSecond:
                return 60
            case .headerThird:
                return 50
            default:
                break
            }
        }
        return 50 // for cells
    }
}

//
// MARK: - Section Header Delegate
//

extension ExpandableGeneralTableViewController {
    
    override func toggleSection(_ header: UITableViewCell, section: Int) {
        
        if let header = header as? ExpandableTableViewHeaderSecond {
            let collapsed = !sections[section].collapsed
            
            // Toggle collapse
            sections[section].collapsed = collapsed
            header.setCollapsed(collapsed)
            
            //tableView.reloadData()
            tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        }
    }
}

//
//  AutomobilExpandableTableViewController.swift
//  eSegurado
//
//  Created by Eduardo Motta on 18/01/17.
//  Copyright © 2017 Evológica. All rights reserved.
//

import UIKit
import CurioSwift

class ExpandableItemTableViewController: ExpandableCommonTable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections.removeAll()
        
        if let itens = policy?.itens?.allObjects as? [Item] {
            let headerColapsed = itens.count < 2 ? false : true
            
            // Loads data to be presented
            if let policy = self.policy {
                switch policy.codigoTipo {
                case 1: // Prestamista
                    break
                case 2: // BAP
                    break
                case 3: // Automovel
                    for item in itens {
                        let aut = item.itemSegurado?.field
                        
                        var cellItens: [CellDescription]
                        
                        if let dadosAut = aut?.childField("DadosItem") {
                            guard let anoFabricacao = dadosAut.findAttribute("AnoFabricacao")?.data else { break }
                            guard let anoModelo = dadosAut.findAttribute("AnoModelo")?.data else { break }
                            
                            switch UIDevice.current.userInterfaceIdiom {
                            case .phone:
                                // It's an iPhone
                                cellItens = [
                                    CellDescription(title: "Código FIPE",detail: dadosAut.findAttribute("CodigoFIPE")?.data ?? ""),
                                    CellDescription(title: "Modelo",detail: dadosAut.findAttribute("Modelo")?.data ?? ""),
                                    CellDescription(title: "Ano Fabricação/Modelo",detail: anoFabricacao + "/" + anoModelo ),
                                    CellDescription(title: "Chassi", detail: dadosAut.findAttribute("Chassi")?.data ?? ""),
                                    CellDescription(title: "Placa",detail: dadosAut.findAttribute("Placa")?.data ?? ""),
                                    CellDescription(title: "Cor",detail: dadosAut.findAttribute("Cor")?.data ?? ""),
                                    CellDescription(title: "Região",detail: dadosAut.findAttribute("Regiao")?.data ?? ""),
                                    CellDescription(title: "CI",detail: dadosAut.findAttribute("CodigoIdentiticacao")?.data ?? ""),
                                    CellDescription(title: "Zero Km?",detail: dadosAut.findAttribute("ZeroKm")?.data ?? ""),
                                    CellDescription(title: "Garantia",detail: dadosAut.findAttribute("Garantia")?.data ?? ""),
                                    CellDescription(title: "Procedência",detail: dadosAut.findAttribute("Procedencia")?.data ?? ""),
                                    CellDescription(title: "Bônus",detail: dadosAut.findAttribute("ClasseBonus")?.data ?? ""),
                                    CellDescription(title: "Categoria Automóvel",detail: dadosAut.findAttribute("CategoriaAuto")?.data ?? ""),
                                    CellDescription(title: "Categoria RCF",detail: dadosAut.findAttribute("CategoriaRCF")?.data ?? ""),
                                    CellDescription(title: "Capacidade",detail: dadosAut.findAttribute("Capacidade")?.data ?? ""),
                                    CellDescription(title: "Unidade",detail: dadosAut.findAttribute("Unidade")?.data ?? ""),
                                    CellDescription(title: "Cat Conforme CRVL",detail: dadosAut.findAttribute("CategoriaConforme")?.data ?? ""),
                                    CellDescription(title: "Terceiro Eixo",detail: dadosAut.findAttribute("TerceiroEixo")?.data ?? ""),
                                    CellDescription(title: "Combustível",detail: dadosAut.findAttribute("Combustivel")?.data ?? "")
                                ]
                                sections.append(SectionDescription(title: aut?.findAttribute("Descricao")?.data ?? "", detail: nil, imageName: "auto", items: cellItens, collapsed: headerColapsed, cellType: CellType.headerFirst))
                                
                            case .pad:
                                // It's an iPad
                                cellItens = [
                                    CellDescription(title: "Código FIPE",detail: dadosAut.findAttribute("CodigoFIPE")?.data ?? "",
                                                    titleSecond: "Ano Fabricação/Modelo", detailSecond: anoFabricacao + "/" + anoModelo,
                                                    titleThird: "Chassi", detailThird: dadosAut.findAttribute("Chassi")?.data ?? ""),
                                    
                                    CellDescription(title: "Modelo", detail: dadosAut.findAttribute("Modelo")?.data ?? ""),
                                    
                                    CellDescription(title: "Placa", detail: dadosAut.findAttribute("Placa")?.data,
                                                    titleSecond: "Cor", detailSecond: dadosAut.findAttribute("Cor")?.data,
                                                    titleThird: "Região", detailThird: dadosAut.findAttribute("Regiao")?.data),
                                    
                                    CellDescription(title: "CI", detail: dadosAut.findAttribute("CodigoIdentiticacao")?.data,
                                                    titleSecond: "Zero Km?", detailSecond: dadosAut.findAttribute("ZeroKm")?.data,
                                                    titleThird: "Garantia", detailThird: dadosAut.findAttribute("Garantia")?.data),
                                    
                                    CellDescription(title: "Procedência", detail: dadosAut.findAttribute("Procedencia")?.data,
                                                    titleSecond: "Categoria Automóvel", detailSecond: dadosAut.findAttribute("CategoriaAuto")?.data,
                                                    titleThird: "Categoria RCF", detailThird: dadosAut.findAttribute("CategoriaRCF")?.data),
                                    
                                    CellDescription(title: "Bônus", detail: dadosAut.findAttribute("ClasseBonus")?.data,
                                                    titleSecond: "Capacidade", detailSecond: dadosAut.findAttribute("Capacidade")?.data,
                                                    titleThird: "Unidade", detailThird: dadosAut.findAttribute("Unidade")?.data),
                                    
                                    CellDescription(title: "Cat Conforme CRVL", detail: dadosAut.findAttribute("CategoriaConforme")?.data,
                                                    titleSecond: "Terceiro Eixo", detailSecond: dadosAut.findAttribute("TerceiroEixo")?.data,
                                                    titleThird: "Combustível", detailThird: dadosAut.findAttribute("Combustivel")?.data)
                                ]
                                sections.append(SectionDescription(title: aut?.findAttribute("Descricao")?.data ?? "", detail: nil, imageName: "auto", items: cellItens, collapsed: headerColapsed, cellType: CellType.headerFirst))
                                
                            default: break
                            }
                            
                            fillCobServClau(aut, isCollapsed: headerColapsed)
                        }
                    }
                    break
                case 4: // VGBL
                    break
                case 5: // BIL
                    break
                case 6: // PTR
                    break
                default: // Vida Grupo
                    break
                }
                
                // Desabilita "collapse" do cabecalho principal em caso de haver somente um
                disableToggleSection = countTopHeaders() == 1 ? true : false
            }
        }
        
        if let field = self.field as? Field {
            switch self.title! {
            case "Coberturas":
                let currencyFormatter = NumberFormatter()
                currencyFormatter.numberStyle = .currency
                currencyFormatter.locale = Locale(identifier: "pt_BR")
                
                for cobertura in field.childFields {
                    let importanciaSegurada = cobertura.findAttribute("ImportanciaSegurada")?.data?.replacingOccurrences(of: ".", with: ",") ?? ""
                    let franquia = cobertura.findAttribute("ValorFranquia")?.data?.replacingOccurrences(of: ".", with: ",") ?? ""
                    
                    let numberFormatter = NumberFormatter()
                    let valorImportanciaSegurada = numberFormatter.number(from: importanciaSegurada)!
                    let valorFranquia = numberFormatter.number(from: franquia)!
                    
                    let dadosCob = [
                        CellDescription(title: "Importância Segurada" , detail: currencyFormatter.string(from: valorImportanciaSegurada)),
                        CellDescription(title: "Franquia" , detail: cobertura.findAttribute("DescricaoFranquia")?.data ?? ""),
                        CellDescription(title: "Valor Franquia" , detail: currencyFormatter.string(from: valorFranquia))
                    ]
                    sections.append(SectionDescription(title: cobertura.findAttribute("Descricao")?.data ?? "", detail: nil, imageName: "", items: dadosCob, cellType: CellType.headerSecond))
                }
                break
            case "Serviços":
                for servico in field.childFields {
                    let dadosSer = [
                        CellDescription(title: "Classe" , detail: servico.findAttribute("Classe")?.data ?? "")
                    ]
                    sections.append(SectionDescription(title: servico.findAttribute("Tipo")?.data ?? "", detail: nil, imageName: "", items: dadosSer, cellType: CellType.headerSecond))
                }
                break
            case "Cláusulas":
                for clausula in field.childFields {
                    let dadosCla = [
                        CellDescription(title: "Número" , detail: clausula.findAttribute("Numero")?.data ?? "")
                    ]
                    sections.append(SectionDescription(title: clausula.findAttribute("Descricao")?.data ?? "", detail: nil, imageName: "", items: dadosCla, cellType: CellType.headerSecond))
                }
                break
            case "Perfil":
                for per in field.childFields {
                    let dadosCla = [
                        CellDescription(title: nil , detail: per.findAttribute("Resposta")?.data ?? "")
                    ]
                    sections.append(SectionDescription(title: per.findAttribute("Pergunta")?.data ?? "", detail: nil, imageName: "", items: dadosCla, cellType: CellType.headerSecond))
                }
                break
            default:
                break
            }
        }
        
        tableView.reloadData()
    }
    
    func countTopHeaders () -> Int {
        var count = 0
        for sec in sections {
            if sec.cellType == .headerFirst {
                count += 1
            }
        }
        return count
    }
    
    func fillCobServClau(_ item: Field?, isCollapsed: Bool) {
        // Coberturas
        if let coberturas = item?.childField("Coberturas") {
            let section = SectionDescription(title: "COBERTURAS", detail: nil, imageName: "", items: nil, collapsed: true, cellType: CellType.headerThird, hidden: isCollapsed)
            section.field = coberturas
            sections.append(section)
        }
        
        // Serviços
        if let servicos = item?.childField("Servicos") {
            let section = SectionDescription(title: "SERVIÇOS", detail: nil, imageName: "", items: nil, collapsed: true, cellType: CellType.headerThird, hidden: isCollapsed)
            section.field = servicos
            sections.append(section)
        }
        
        // Clausulas
        if let clausulas = item?.childField("Clausulas") {
            let section = SectionDescription(title: "CLÁUSULAS", detail: nil, imageName: "", items: nil, collapsed: true, cellType: CellType.headerThird, hidden: isCollapsed)
            section.field = clausulas
            sections.append(section)
        }
        
        // Perguntas
        if let perfil = item?.childField("Perfil") {
            let section = SectionDescription(title: "PERFIL", detail: nil, imageName: "", items: nil, collapsed: true, cellType: CellType.headerThird, hidden: isCollapsed)
            section.field = perfil
            sections.append(section)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            let sectionIndex = indexPath.section
            switch sections[sectionIndex].cellType {
            case .headerThird:
                let controller = storyboard?.instantiateViewController(withIdentifier: "itemsSID") as! ExpandableItemTableViewController
                controller.field = sections[sectionIndex].field as? Field
                switch sections[sectionIndex].title! {
                case "COBERTURAS":
                    controller.title = "Coberturas"
                    break
                case "SERVIÇOS":
                    controller.title = "Serviços"
                    break
                case "CLÁUSULAS":
                    controller.title = "Cláusulas"
                    break
                case "PERFIL":
                    controller.title = "Perfil"
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

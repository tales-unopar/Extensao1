//
//  PlannerViewModel.swift
//  PlannerApp
//
//  Created by Tales on 16/09/23.
//

import SwiftUI

class PlannerViewModel: ObservableObject {
    // General
    @Published
    var rentTotal: Double = 0.0
    @Published
    var musiciansTotal: Double = 0.0
    @Published
    var ticketsTotal: Double = 0.0
    @Published
    var estimatedPublicTotal: Double = 0.0
    
    // Rent
    @Published
    var rentString: String = ""
    @Published
    var isValidInput: Bool = false
    @Published
    var savedOnce: Bool = false
    
    // Musicians
    @Published
    var musicians: [Musician] = []
    
    // Tickets
    @Published
    var ticketsCount: String = ""
    
    @Published
    var ticketsPrice: String = ""
    
    @Published
    var isValidPrice: Bool = false
    
    @Published
    var savedOnceTicket: Bool = false
    
    @Published
    var isValidCount: Bool = false
    
    @Published
    var savedOnceCount: Bool = false
    
    
    func getTotal() -> String {
        let total = rentTotal + musiciansTotal
        
        return String(total)
    }
    
    func getPositive() -> String {
        let total = (ticketsTotal * estimatedPublicTotal) - (rentTotal + musiciansTotal)
        
        return String(total)
    }
    
    func clear() {
        rentTotal = 0.0
        musiciansTotal = 0.0
        ticketsTotal = 0.0
        estimatedPublicTotal = 0.0
        rentString = ""
        isValidInput = false
        savedOnce = false
        musicians = []
        ticketsCount = ""
        ticketsPrice = ""
        isValidPrice = false
        savedOnceTicket = false
        isValidCount = false
        savedOnceCount = false
    }
}


struct Musician: Identifiable, Equatable {
    var id = UUID().uuidString
    var name: String
    var price: String
}

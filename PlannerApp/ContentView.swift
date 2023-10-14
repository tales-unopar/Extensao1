//
//  ContentView.swift
//  PlannerApp
//
//  Created by Tales on 16/09/23.
//

import SwiftUI

// MARK: Home

struct ContentView: View {
    @ObservedObject
    var viewModel: PlannerViewModel = PlannerViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: RentDetail(viewModel: viewModel)){
                        HStack {
                            Text("Aluguel")
                        }
                    }
                    
                    NavigationLink(destination: MusiciansDetail(viewModel: viewModel)){
                        HStack {
                            Text("Cachês")
                        }
                    }
                    
                    NavigationLink(destination: TicketsDetail(viewModel: viewModel)){
                        HStack {
                            Text("Ingressos")
                        }
                    }
                    
                    NavigationLink(destination: AttendanceDetail(viewModel: viewModel)){
                        HStack {
                            Text("Público")
                        }
                    }
                }
                
                Section("Resumo") {
                    Text("Total investido: \(viewModel.getTotal()) ")
                    Text("Retorno Esperado \(viewModel.getPositive())")
                }
                .listRowSeparator(.hidden)
                
                Section {
                    Button("Limpar") {
                        viewModel.clear()
                    }
                }
            }
            .navigationTitle("Planejamento")
        }
    }
}

// MARK: Details

struct RentDetail: View {
    @ObservedObject
    var viewModel: PlannerViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Qual o valor estimado?")
                
                HStack {
                    Text("R$")
                    TextField("Valor", text: $viewModel.rentString)
                        .onChange(of: viewModel.rentString) { string in
                            validate(input: string)
                        }
                        .frame(alignment: .center)
                        .border(.secondary)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
            }
            
            Button(viewModel.savedOnce ? (viewModel.isValidInput ? "Salvar" : "Salvo") : "Salvar") {
                viewModel.rentTotal = Double(viewModel.rentString)!
                viewModel.isValidInput = false
                viewModel.savedOnce = true
            }
            .disabled(!viewModel.isValidInput)
        }
        .padding()
    }
    
    private func validate(input: String) {
        if let _ = Double(viewModel.rentString) {
            viewModel.isValidInput = true
        } else {
            viewModel.isValidInput = false
        }
    }
}

struct MusiciansDetail: View {
    @ObservedObject
    var viewModel: PlannerViewModel

    var body: some View {
        ZStack {
            List($viewModel.musicians) { musician in
                Section {
                    HStack {
                        Text("Nome")
                        TextField("", text: musician.name)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    HStack {
                        Text("Valor")
                        TextField("", text: musician.price)
                            .keyboardType(.numbersAndPunctuation)
                            .textFieldStyle(.roundedBorder)
                    }
                }
            }

            VStack {
                Spacer()
                
                Button("Adicionar músico") {
                    let newMusician = Musician(name: "", price: "")
                    viewModel.musicians.append(newMusician)
                }
            }
        }
        .onChange(of: viewModel.musicians) { newValue in
            viewModel.musiciansTotal = newValue.reduce(0.0, { partialResult, musician in
                return partialResult + (Double(musician.price) ?? 0.0)
            })
        }
    }

}

struct TicketsDetail: View {
    @ObservedObject
    var viewModel: PlannerViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Quanto custará cada ingresso?")
                TextField("", text: $viewModel.ticketsPrice)
                    .textFieldStyle(.roundedBorder)
            }
            .onChange(of: viewModel.ticketsPrice) { newValue in
                validate(input: newValue)
            }
            
            Button(viewModel.savedOnceTicket ? (viewModel.isValidPrice ? "Salvar" : "Salvo") : "Salvar") {
                viewModel.ticketsTotal = Double(viewModel.ticketsPrice)!
                viewModel.isValidPrice = false
                viewModel.savedOnceTicket = true
            }
            .disabled(!viewModel.isValidPrice)
        }
        .padding()
    }
    
    private func validate(input: String) {
        if let _ = Double(viewModel.ticketsPrice) {
            viewModel.isValidPrice = true
        } else {
            viewModel.isValidPrice = false
        }
    }
}

struct AttendanceDetail: View {
    @ObservedObject
    var viewModel: PlannerViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Qual a estimativa de público?")
                TextField("", text: $viewModel.ticketsCount)
                    .textFieldStyle(.roundedBorder)
            }
            .onChange(of: viewModel.ticketsCount) { newValue in
                validate(input: newValue)
            }
            
            Button(viewModel.savedOnceCount ? (viewModel.isValidCount ? "Salvar" : "Salvo") : "Salvar") {
                viewModel.estimatedPublicTotal = Double(viewModel.ticketsCount)!
                viewModel.isValidCount = false
                viewModel.savedOnceCount = true
            }
            .disabled(!viewModel.isValidCount)
        }
        .padding()
    }
    
    private func validate(input: String) {
        if let _ = Double(viewModel.ticketsCount) {
            viewModel.isValidCount = true
        } else {
            viewModel.isValidCount = false
        }
    }
}

// MARK: Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

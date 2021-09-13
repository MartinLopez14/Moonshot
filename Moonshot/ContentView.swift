//
//  ContentView.swift
//  Moonshot
//
//  Created by Martin Lopez Uribe on 16/12/20.
//

import SwiftUI

struct ContentView: View {
    
    struct User: Codable {
        var name: String
        var address: Address
    }

    struct Address: Codable {
        var street: String
        var city: String
    }
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State var missionAstronauts: [Int:[String]] = [:]
    
    @State var showAstronauts = false;
    var buttonText: String {
        if showAstronauts {
            return "Show Launch Date"
        }
        return "Show Astronauts"
    }
    
    mutating func getMissionAstronauts() {
        for mission in missions {
            var missionAstros = [String]()
            for member in mission.crew {
                if let match = astronauts.first(where: { $0.id == member.name }) {
                    missionAstros.append(match.name)
                } else {
                    fatalError("Missing \(member)")
                }
            }
            missionAstronauts[mission.id] = missionAstros;
        }
    }
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if self.showAstronauts {
                            List(missionAstronauts[mission.id]!) { astro in
                                Text(astro)
                            }
                        } else {
                            Text(mission.formattedLaunchDate)
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button("\(buttonText)", action: {
                self.showAstronauts.toggle()
            }))
            .onAppear(perform: getMissionAstronauts)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

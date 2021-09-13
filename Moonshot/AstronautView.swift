//
//  AstronautView.swift
//  Moonshot
//
//  Created by Martin Lopez Uribe on 17/12/20.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    let missionId: Int
    let missions: [Mission] = Bundle.main.decode("missions.json")
    var otherMissions = [Mission]()
    
    init(astronaut: Astronaut, missionId: Int) {
        self.astronaut = astronaut
        self.missionId = missionId
        
        for mission in missions {
            if mission.id != missionId {
                innerLoop: for member in mission.crew {
                    if astronaut.id == member.name {
                        otherMissions.append(mission)
                        break innerLoop
                    }
                }
            }
        }
        
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                    
                    Text("Other Missions")
                    ForEach(self.otherMissions, id: \.id) { mission in
                        Text("\(mission.displayName)")
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static var previews: some View {
        
        let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
        
        AstronautView(astronaut: astronauts[0], missionId: 1)
    }
}

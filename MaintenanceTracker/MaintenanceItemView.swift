//
//  MaintenanceItemView.swift
//  MaintenanceTracker
//
//  Created by Daniel Ratner on 12/14/20.
//  Copyright © 2020 Daniel Ratner. All rights reserved.
//


//Item view for maintenance in content view
import SwiftUI

struct MaintenanceItemView: View {
    
       var title:String = ""
       var createdAt:String = ""
       var milleage:String = ""
       
       var body: some View {
        //how the values are displayed
           HStack{
               VStack(alignment: .leading){
                   Text(title)
                    .font(.headline)
                   Text(createdAt.prefix(10))
                    .font(.caption)
                   Text(milleage)
                    .font(.caption)
                
               }
           }
       }
}

#if DEBUG
struct MaintenanceItemView_Previews: PreviewProvider {
    static var previews: some View {
        MaintenanceItemView(title: "Oil", createdAt: "Today", milleage: "40,000")
    }
}
#endif

//
//  DetailView.swift
//  MaintenanceTracker
//
//  Created by Daniel Ratner on 12/14/20.
//  Copyright © 2020 Daniel Ratner. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    //Get variable to display
  let maintenanceItem: MaintenanceItem
  
  var body: some View {
    Form {
        //Show information, may add edit options.
            Section(header: Text("Maintenance Details")) {
                VStack(alignment: .leading){
                    Text(maintenanceItem.title!)
                        .font(.headline)
                    Text("Details: " + maintenanceItem.itemDescription!)
                    Text("Milleage: " + maintenanceItem.milleage!)
                    Text("Date:  \(maintenanceItem.createdAt!)")
            }
        }
    }
    
    }


}

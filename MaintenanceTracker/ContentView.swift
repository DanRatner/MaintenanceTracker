//
//  ContentView.swift
//  MaintenanceTracker
//
//  Created by Daniel Ratner on 12/14/20.
//  Copyright © 2020 Daniel Ratner. All rights reserved.
//





import SwiftUI
import Combine


struct ContentView: View {
    
    //Setting up the environment for the managed objects
    @Environment(\.managedObjectContext) var managedObjectContext
    
    //Fetching the data for the Maintenance Items
    @FetchRequest(fetchRequest: MaintenanceItem.getAllMaintenanceItems()) var maintenanceItems:FetchedResults<MaintenanceItem>
    
    
    
    // Variables for creting new maintenance items
    // These will be used temporarily to store
    // Data from the form, and then pass into new object.
    @State private var newMaintenanceItem = ""
    @State private var newMaintenanceItemMilleage = ""
    @State private var newMaintenanceItemDescription = ""
    
    
    
    var body: some View {
        
        
        NavigationView{
            
            List{
                
                //Title (Will add car name)
                Section(header: Text("Record Maintenance")){
                    
                    VStack{
                        
                        //Title of maintenance, required
                        //Stores as variable
                        TextField("Title", text: self.$newMaintenanceItem)
                        
                        //Milleage, not required
                        TextField("Milleage", text: self.$newMaintenanceItemMilleage)
                            //Set as keypad so user knows not to add in anything else
                            .keyboardType(.numberPad)
                            
                            //Filter out anything that is not an integer
                            .onReceive(Just(newMaintenanceItemMilleage)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.newMaintenanceItemMilleage = filtered
                            }
                        }
                        
                        
                        HStack{
                            
                            //Maintenance Description. Not required.
                            TextField("Description", text: self.$newMaintenanceItemDescription)
                            
                            //Button to store the new data
                            Button(action: {
                                let theMaintenanceItem = MaintenanceItem(context: self.managedObjectContext)
                                theMaintenanceItem.title = self.newMaintenanceItem
                                theMaintenanceItem.milleage = self.newMaintenanceItemMilleage
                                theMaintenanceItem.itemDescription = self.newMaintenanceItemDescription
                                theMaintenanceItem.createdAt = Date()
                                
                                do {
                                    try self.managedObjectContext.save()
                                }catch{
                                    print(error)
                                }
                                
                                //Clear the values that are printed
                                self.newMaintenanceItem = ""
                                self.newMaintenanceItemMilleage = ""
                                self.newMaintenanceItemDescription = ""
                                
                            }){
                                //Create an icon for the button
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                    .imageScale(.large)
                            }
                            //Set as disbaled until both title and milleage are filled.
                            .disabled(newMaintenanceItem.isEmpty || newMaintenanceItemMilleage.isEmpty)
                            }
                    }
                }.font(.headline)
                
                //Display history of maintenance itemms
                Section(header: Text("History")) {
                    ForEach(self.maintenanceItems) {maintenanceItem in
                        //navigate to detail view for each item
                    NavigationLink(destination: DetailView(maintenanceItem: maintenanceItem)) {
                    
                     //Display item with title... notice not full date displayed
                    MaintenanceItemView(title: maintenanceItem.title!, createdAt: "\(maintenanceItem.createdAt!)", milleage: "Milleage: \(maintenanceItem.milleage!)")
                        }}.onDelete {indexSet in
                        let deleteItem = self.maintenanceItems[indexSet.first!]
                        self.managedObjectContext.delete(deleteItem)
                        
                        do {
                            try self.managedObjectContext.save()
                        }catch{
                            print(error)
                        }
                    }
                    
                    
                    
                }
                
            }
            .navigationBarTitle(Text("Maintenance"))
            .navigationBarItems(trailing: EditButton())
        }
    }
}




#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

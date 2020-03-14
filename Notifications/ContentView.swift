//
//  ContentView.swift
//  Notifications
//
//  Created by Alejandro Franco on 12/03/20.
//  Copyright © 2020 Alejandro Franco. All rights reserved.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @State var show = false
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: Detail(show: self.$show), isActive: self.$show) {
                    Text("")
                }
                Button(action: {
                    self.send()
                }) {
                    Text("Send Notification")
                }.navigationBarTitle("Home")
            }.onAppear {
                NotificationCenter.default.addObserver(forName: NSNotification.Name("Detail"), object: nil, queue: .main) { (_) in
                    self.show = true
                }
            }
        }
    }
    
    func send() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (_, _) in
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Message"
        content.body = "New notification from Alex"
        
        let open = UNNotificationAction(identifier: "open", title: "Open", options: .foreground)
        
        let cancel = UNNotificationAction(identifier: "cancel", title: "Cancel", options: .destructive)
        
        let categories = UNNotificationCategory(identifier: "action", actions: [open, cancel], intentIdentifiers: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([categories])
        
        content.categoryIdentifier = "action"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let req = UNNotificationRequest(identifier: "req", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Detail: View {
    @Binding var show: Bool
    
    var body: some View {
        Text("Detail")
            .navigationBarTitle("Detail View")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
            Button(action: {
                self.show = false
            }, label: {
                Image(systemName: "arrow.left").font(.title)
            }))
    }
}

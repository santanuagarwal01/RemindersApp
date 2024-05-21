//
//  MyListsView.swift
//  RemindersApp
//
//  Created by Santanu Agarwal on 20/05/24.
//

import SwiftUI

struct MyListsView: View {
    let myLists: FetchedResults<MyList>
    
    var body: some View {
        NavigationStack {
            if myLists.isEmpty {
                Spacer()
                Text("No reminders found")
            } else {
                ForEach(myLists) { list in
                    NavigationLink(value: list) {
                        VStack {
                            MyListCellView(myList: list)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)
                                .font(.title3)
                            Divider()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationDestination(for: MyList.self) { myList in
                    MyListDetailView(myList: myList)
                }
            }
        }
    }
}


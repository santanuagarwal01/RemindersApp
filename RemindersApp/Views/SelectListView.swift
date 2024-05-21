//
//  SelectListView.swift
//  RemindersApp
//
//  Created by Santanu Agarwal on 21/05/24.
//

import SwiftUI

struct SelectListView: View {
    
    @Binding var selectedList: MyList?
    @FetchRequest(sortDescriptors: []) private var myListResults: FetchedResults<MyList>

    
    var body: some View {
        List(myListResults) { myList in
            HStack {
                HStack {
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .foregroundStyle(Color(uiColor: myList.color))
                    Text(myList.name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedList = myList
                }
                
                Spacer()
                
                if selectedList == myList {
                    Image(systemName: "checkmark")
                }
            }
            Text(myList.name)
        }
    }
}

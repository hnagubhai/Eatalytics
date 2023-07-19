//
//  ExploreView.swift
//  Eatalytics
//
//  Created by Hemanth Nagubhai on 6/22/23.
//

import SwiftUI

struct Explore: View {
    
    @State var size = "Medium"
    @State var currentTab = "All"
    
    @State var items = [
        
        Item(title: "Stylish Table Lamp", price: "$20.00", subTitle: "We have amazing quality Lamp wide range.", image: "lamp"),
        Item(title: "Modern Chair", price: "$60.00", subTitle: "New style of tables for your home and office.", image: "chair"),
        Item(title: "Wodden Stool", price: "$35.00", subTitle: "Amazing Stylish in multiple Most selling item of this.", image: "stool"),
    ]

    @GestureState var isDragging = false
    
    // adding bookmark items...
    
    @State var bookmark : [Item] = []
    
    var body: some View {
        
        VStack{
            
            HStack{
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Explore")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Menu(content: {
                    
                    Button(action: {size = "Small"}) {
                        
                        Text("Small")
                    }
                    
                    Button(action: {size = "Medium"}) {
                        
                        Text("Medium")
                    }
                    
                    Button(action: {size = "Large"}) {
                        
                        Text("Large")
                    }
                    
                }) {
                    
                    Label(title: {
                        Text(size)
                            .foregroundColor(.white)
                    }) {
                        
                        Image(systemName: "slider.vertical.3")
                            .foregroundColor(.white)
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(Color.black)
                    .clipShape(Capsule())
                }

                Spacer()
                
                Button(action: {}) {
                    
                    Image(systemName: "bookmark")
                        .font(.title)
                        .foregroundColor(.black)
                }
                .overlay(
                
                    // bookmark Count....
                    Text("\(bookmark.count)")
                        .font(.caption)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .frame(width: 20, height: 20)
                        .background(Color("Dark"))
                        .clipShape(Circle())
                        .offset(x: 15, y: -22)
                    // disbling if no items...
                        .opacity(bookmark.isEmpty ? 0 : 1)
                )
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom,10)
            
            ScrollView{
                
                VStack{
                    
                    HStack(spacing: 0){
                        
                        ForEach(tabs,id: \.self){tab in
                            
                            Button(action: {currentTab = tab}) {
                                
                                Text(tab)
                                    .fontWeight(.bold)
                                    .foregroundColor(currentTab == tab ? .black : .gray)
                            }
                            
                            if tab != tabs.last{
                                Spacer(minLength: 0)
                            }
                        }
                    }
                    .padding()
                    
                    ForEach(items.indices){index in
                        
                        // Card View...
                        
                        ZStack{
                            
                            Color("tab")
                                .cornerRadius(20)
                            
                            Color("Color")
                                .cornerRadius(20)
                                .padding(.trailing,65)
                            
                            // Button...
                            
                            HStack{
                                
                                Spacer()
                                
                                                                
                                Button(action: {
                                    addBookmark(index: index)
                                }) {
                                    
                                    // changing bookmark image..
                                    Image(systemName: checkBookmark(index: index) ? "bookmark.fill" :  "bookmark")
                                        .font(.title)
                                        .foregroundColor(.white)
                                    // default frame...
                                        .frame(width: 65)
                                }
                            }
                            
                            CardView(item: items[index])
                            // drag gesture....
                                .offset(x: items[index].offset)
                                .gesture(
                                    DragGesture()
                                        .updating($isDragging, body: { (value, state, _) in
                                            
                                            // so we can validate for correct drag..
                                            state = true
                                            onChanged(value: value, index: index)
                                        }).onEnded({ (value) in
                                    onEnd(value: value, index: index)
                                }))
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                }
                .padding(.bottom,100)
            }
        }
        .background(Color("Light").edgesIgnoringSafeArea(.all))
    }
    
    // checking bookmark and adding item...
    
    func checkBookmark(index: Int)-> Bool{
        
        return bookmark.contains { (item) -> Bool in
            
            return item.id == items[index].id
        }
    }
    
    func addBookmark(index: Int){
        
        if checkBookmark(index: index){
            
            bookmark.removeAll { (item) -> Bool in
                return item.id == items[index].id
            }
        }
        else{
            
            bookmark.append(items[index])
        }
        
        // closing after added...
        withAnimation{
        
            items[index].offset = 0
        }
    }
    
    func onChanged(value: DragGesture.Value,index: Int){
        
        if value.translation.width < 0 && isDragging{
            
            items[index].offset = value.translation.width
        }
    }
    
    // onEnd is not working properly...
    // may be its bug...
    // to avoid this we using update property on Drag Gesture...
    func onEnd(value: DragGesture.Value,index: Int){
        
        withAnimation{
            
            // 65 + 65 = 130....
            if -value.translation.width >= 100{
                
                items[index].offset = -130
            }
            else{
            
            
                items[index].offset = 0
            }
        }
    }
}

var tabs = ["Tables","Chairs","Lamps","All"]

struct Explore_Previews: PreviewProvider {
    static var previews: some View {
        Explore()
    }
}

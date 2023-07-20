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
        //appetizer
        Item(title: "Apple & Brie Upside-Down Tarts", price: "231 Calories", subTitle: "40 Minutes, https://www.eatingwell.com/recipe/8053762/apple-brie-upside-down-tarts/", image: "apple"),
        //appetizer
        Item(title: "Air-Fryer Buffalo Wings", price: "302 Calories", subTitle: "70 Minutes, https://www.eatingwell.com/recipe/274220/air-fryer-buffalo-wings/", image: "wings"),
        //main
        Item(title: "Chicken Curry Stuffed Sweet Potatoes", price: "257 Calories", subTitle: "30 Minutes, https://www.eatingwell.com/recipe/275785/chicken-curry-stuffed-sweet-potatoes/", image: "curry"),//main
        Item(title: "Chickpea Pasta with Mushrooms & Kale", price: "340 Calories", subTitle: "30 Minutes, https://www.eatingwell.com/recipe/7939117/chickpea-pasta-with-mushrooms-kale/", image: "pasta"),
        //dessert
        Item(title: "Classic Fudge-Walnut Brownies", price: "186 Calories", subTitle: "45 Minutes, https://www.eatingwell.com/recipe/238086/classic-fudge-walnut-brownies/", image: "brownies"),
        //dessert
        Item(title: "Lemon-Blueberry Poke Cake", price: "335 Calories", subTitle: "100 Minutes, https://www.eatingwell.com/recipe/7994194/lemon-blueberry-poke-cake/", image: "cake"),
        //drink
        Item(title: "Homemade Pumpkin Spice Latte", price: "207 Calories", subTitle: "5 Minutes, https://feelgoodfoodie.net/recipe/homemade-pumpkin-spice-latte/", image: "latte"),
        //drink
        Item(title: "Iced Matcha Latte", price: "176 Calories", subTitle: "5 Minutes, https://feelgoodfoodie.net/recipe/homemade-pumpkin-spice-latte/", image: "matcha"),
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

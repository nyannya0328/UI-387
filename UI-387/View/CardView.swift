//
//  CardView.swift
//  UI-387
//
//  Created by nyannyan0328 on 2021/12/09.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var model : HomeViewModel
    var user : User
    
    @State var offset : CGFloat = 0
    @GestureState var isDraggging : Bool = false
    
    @State var isEnd : Bool = false
    var body: some View {
        GeometryReader{proxy in
            
            ZStack{
                
                let size = proxy.size
                let index = CGFloat(model.getIndex(user: user))
                
                let topOffset = (index <= 2 ? index : 2) * 15
                
                Image(user.profilePick)
                    .resizable()
                    .aspectRatio(contentMode:.fill)
                    .frame(width: size.width - topOffset, height: size.height)
                    .cornerRadius(10)
                    .offset(y: -topOffset)
                   
                
                
                
            }
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            
        }
        .offset(x: offset)
        .rotationEffect(.init(degrees: getRotation(angel: 10)))
        .contentShape(Rectangle().trim(from: 0, to: isEnd ? 0 : 1))
        .gesture(
        
        DragGesture()
            .updating($isDraggging, body: { _, out, _ in
                out = true
            })
            .onChanged({ value in
                
                let translation = value.translation.width
                
                offset = (isDraggging ? translation : .zero)
            })
            .onEnded({ value in
                
                let width = getRect().width - 50
                let translation = value.translation.width
                
                let checkStatus = (translation > 0 ? translation : -translation)
                
                
                if checkStatus > (width / 2){
                    
                    
                    
                    offset = (translation > 0 ? width : -width) * 2
                    
                    endSwipactions()
                    
                    
                    if translation > 0{
                        
                        rightSwip()
                        
                    }
                    else{
                        
                        leftSwip()
                        
                    }
                    
                    
                    
                    
                    
                }
                else{
                    
                    
                    offset = .zero
                }
                
                
                
                
                
                
            })
        
        )
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON"), object: nil)) { data in
            
            
            guard let info = data.userInfo else{return}
            
            let id = info["id"] as? String ?? ""
            let rightSwip = info["rightSwip"] as? Bool ?? false
            
            let width = getRect().width - 50
            
            
            if user.id == id{
                
                
                withAnimation{
                    
                    offset = (rightSwip ? width : -width)
                    
                    endSwipactions()
                    
                    
                    
                    if rightSwip{
                        
                        
                        self.rightSwip()
                        
                    }
                    else{
                        
                        leftSwip()
                        
                    }
                    
                    
                    
                    
                }
                
            }
            
            
            
        }
        
    }
    
    
    func endSwipactions(){
        
        withAnimation(.none){isEnd = true}
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            
            if let _ = model.dispalying_user?.first{
                
                let _ = withAnimation{
                    
                    model.dispalying_user?.removeFirst()
                    
                    
                }
                
                
            }
            
            
        }
        
        
    }
    
    func rightSwip(){
        
        
    }
    
    func leftSwip(){
        
        
    }
    
    

    
    
    
    func getRotation(angel : Double)->Double{
        
        let rotation = (offset / getRect().width * angel)
        return rotation
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

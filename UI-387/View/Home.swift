//
//  Home.swift
//  UI-387
//
//  Created by nyannyan0328 on 2021/12/09.
//

import SwiftUI

struct Home: View {
    @StateObject var model = HomeViewModel()
    var body: some View {
        VStack{
            
            Button {
                
            } label: {
                
                Image("menu")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .frame(maxWidth:.infinity,alignment: .leading)
                    
            }
            .padding()
            .overlay(
            
            Text("Discover")
                .font(.title.bold())
             
            
            )
            .foregroundColor(.black)
            
            ZStack{
                
                if let users = model.dispalying_user{
                    
                    if users.isEmpty{
                        
                        
                        Image("User2")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                    }
                    else{
                        
                        
                        ForEach(users.reversed()){user in
                            
                            
                            CardView(user: user)
                                .environmentObject(model)
                        }
                        
                        
                        
                    }
                    
                    
                }
                else{
                    
                    ProgressView()
                }
                
                
                
            }
            .padding()
            .padding(.top,30)
            .padding(.vertical)
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            
            
            
            HStack{
                
                
                Button {
                    
                } label: {
                    
                    Image(systemName: "arrow.uturn.backward")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(13)
                        .background(Color("Gray"))
                        .clipShape(Circle())
                }
                
                Button {
                    
                    doSwipe()
                    
                } label: {
                    
                    Image(systemName: "xmark")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color("Blue"))
                        .clipShape(Circle())
                }
                
                Button {
                    
                   
                    
                } label: {
                    
                    Image(systemName: "star.fill")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(13)
                        .background(Color("Yellow"))
                        .clipShape(Circle())
                }


                
                Button {
                    
                    doSwipe(rigthSwip: true)
                    
                } label: {
                    
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color("Pink"))
                        .clipShape(Circle())
                }




                
                
            }
            .padding(.bottom)
            .disabled(model.dispalying_user?.isEmpty ?? false)
            .opacity(model.dispalying_user?.isEmpty ?? false ? 0.6 : 1)
            
            

            
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
    }
    
    func doSwipe(rigthSwip : Bool = false){
        
        
        guard let first = model.dispalying_user?.first else {return}
        
        
        NotificationCenter.default.post(name: Notification.Name("ACTIONFROMBUTTON"), object: nil,userInfo: [
        
        
            "id" : first.id,
            "rightSwip" : rigthSwip
        
        
        
        ])
        
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

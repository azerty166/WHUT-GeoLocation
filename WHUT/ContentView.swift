//
//  ContentView.swift
//  WHUT
//
//  Created by Nic Demai on 12/3/20.
//

import SwiftUI

struct ContentView: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var bottomState = CGSize.zero
    var body: some View {
        
        ZStack {
            TittleView()
                .blur(radius:show ? 20:0)
                .opacity(showCard ? 0.4:1)
                .offset( y: showCard ? -200:0)
                .animation(Animation.easeInOut.delay(0.1))
            
            BackCardView(show: $show)
                .frame(width: showCard ? 320: 340, height: 220)
                .background(show ? Color(#colorLiteral(red: 0.2565460205, green: 0.170607686, blue: 0.84267658, alpha: 1)):Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20 )
                .offset(x: 0, y:show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(x: 0, y: showCard ? -180:0)
                .scaleEffect(showCard ? 1: 0.9)
                .rotationEffect(.degrees(show ? 0:10))
                .rotationEffect(.degrees(showCard ? -10:0))
                .rotation3DEffect(
                    .degrees(showCard ? 0 : 10),
                    axis: (x: 10.0, y: 0.0, z: 0.0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))
            
            BackCardView(show: $show)
                .frame(width: 340, height: 220)
                .background(show ? Color("card3"):Color(#colorLiteral(red: 0.2565460205, green: 0.170607686, blue: 0.84267658, alpha: 1)))
                .cornerRadius(20)
                .shadow(radius: 20 )
                .offset(x: 0, y: show ? -200: -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(x: 0, y: showCard ? -140:0)
                .scaleEffect(showCard ? 1:0.95)
                .rotationEffect(Angle.degrees(show ? 0: 5))
                .rotationEffect(.degrees(showCard ? -5:0))
                .rotation3DEffect(
                    .degrees(showCard ? 0:5),
                    axis: (x: 10.0, y: 0.0, z: 0.0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))
            
            
            CardView()
                .frame(width:showCard ? 370 : 340.0,height: 220)
                .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 :20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                .shadow(radius: 20 )
                .offset(x: viewState.width, y: viewState.height)
                .offset(x: 0, y: showCard ? -100:0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0))
                .onTapGesture {
                    self.showCard.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            self.viewState = value.translation
                            self.show = true
                        }
                        .onEnded{ value in
                            self.viewState = .zero
                            self.show = false
                        }
                )
            
            BottomCardView()
                .offset(x: 0, y: showCard ? 360:1000)
                .offset(y: bottomState.height)
                .blur(radius:show ? 20:0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                .gesture(DragGesture()
                            .onChanged{ value in
                                self.bottomState = value.translation
                            }
                            .onEnded{ value in
                                if self.bottomState.height > 50{
                                    self.showCard = false
                                }
                                if self.bottomState.height < -100{
                                    self.bottomState.height = -300
                                }
                                else{
                                    self.bottomState = .zero
                                }
                            } )
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Successful")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text("Dec 25 - Jan 24")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo")
                    //.rotationEffect(Angle(degrees: 270))
            }
            .padding(.horizontal,20)
            .padding(.top)
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
        }
        
    }
}

struct BackCardView: View {
    @Binding var show : Bool
    var body: some View {
        VStack {
            Text(show ? "CS-PVT":"")
        }
        
        
       
    }
}

struct TittleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Authentication:")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding()
                Spacer()
            }
            Image(uiImage: #imageLiteral(resourceName: "Background1"))
            Spacer()
        }
    }
}

struct BottomCardView: View {
    var body: some View {
        VStack (spacing:20){
            Rectangle()
                .frame(width: 40, height: 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .opacity(0.1)
            Text("This is a certificate to prove that you have successfully authenticated your identity for the month of December-January. \n Together with this certificate you will be recieve an email confirming your authentication \n \n If you haven't recieved an email. Please go to Mafangshan office 402 before December 31st")
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            
            WatchRingsView()
            Spacer()
        }.padding()
        .frame(maxWidth:.infinity)
        .background(Color("background3"))
        .cornerRadius(30)
        .shadow(radius: 20 )
        
    }
}

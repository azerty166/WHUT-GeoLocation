//
//  Buttons.swift
//  WHUT
//
//  Created by Nic Demai on 12/4/20.
//

import SwiftUI

func haptic(type: UINotificationFeedbackGenerator.FeedbackType) {
    UINotificationFeedbackGenerator().notificationOccurred(type)
}

func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    let impactStyle = UIImpactFeedbackGenerator(style: style)
    impactStyle.impactOccurred()
}

struct Buttons: View {
    var body: some View {
        VStack(spacing: 50) {
            RectangleButton()
            CircleButton()
            PayButton()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
        .edgesIgnoringSafeArea(.all)
        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}

struct RectangleButton: View {
    @State var pressed = false
    
    var body: some View {
        Button(action: {
            self.pressed.toggle()
            haptic(type: .success)
        }) {
            Text("Button")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                .frame(width: 200, height: 60)
                .background(
                    ZStack {
                        pressed ? Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) : Color(#colorLiteral(red: 0.7450980392, green: 0.8, blue: 0.8980392157, alpha: 1))
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundColor(pressed ? Color(#colorLiteral(red: 0.7450980392, green: 0.8, blue: 0.8980392157, alpha: 1)) : Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .blur(radius: 4)
                            .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors: [Color(#colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .padding(2)
                            .blur(radius: 2)
                    }
            )
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 0, x: pressed ? -1 : 1, y: pressed ? -1 : 1)
            .shadow(color: pressed ? Color(#colorLiteral(red: 0.7450980392, green: 0.8, blue: 0.8980392157, alpha: 1)) : Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 20, x: -20, y: -20)
            .shadow(color: pressed ? Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) : Color(#colorLiteral(red: 0.7294117647, green: 0.7843137255, blue: 0.8941176471, alpha: 1)), radius: 20, x: 20, y: 20)
            .overlay(
                HStack {
                    VStack {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 24, weight: .light, design: .rounded))
                            .foregroundColor(Color.white)
                            .opacity(pressed ? 0 : 1)
                    }
                    .frame(width: pressed ? 64 : 54, height: pressed ? 4 : 50)
                    .background(Color(#colorLiteral(red: 0.4196078431, green: 0.2980392157, blue: 0.9490196078, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0.4196078431, green: 0.2980392157, blue: 0.9490196078, alpha: 1)).opacity(0.5), radius: 10, x: 10, y: 10)
                    .offset(x: pressed ? 70 : -10, y: pressed ? 16 : 0)
                    
                    Spacer()
                }
            )
        }
    }
}

struct CircleButton: View {
    @State var pressed = false
    @State var tap = false
    
    var body: some View {
        Button(action: {
            
        }) {
            VStack {
                ZStack {
                    Image(systemName: "sun.max")
                        .font(.system(size: 44, weight: .light, design: .rounded))
                        .foregroundColor(Color(#colorLiteral(red: 0.1607843137, green: 0.2039215686, blue: 0.2862745098, alpha: 1)))
                        .offset(x: pressed ? -90 : 0, y: pressed ? -90 : 0)
                        .rotation3DEffect(Angle(degrees: pressed ? 30 : 0), axis: (x: 10, y: 0, z: 0))
                    Image(systemName: "moon")
                        .font(.system(size: 44, weight: .light, design: .rounded))
                        .foregroundColor(Color(#colorLiteral(red: 0.1607843137, green: 0.2039215686, blue: 0.2862745098, alpha: 1)))
                        .offset(x: pressed ? 0 : 90, y: pressed ? 0 : 90)
                        .rotation3DEffect(Angle(degrees: pressed ? 0 : 30), axis: (x: 10, y: 0, z: 0))
                }
            }
            .frame(width: 100, height: 100)
            .background(
                ZStack {
                    Color(#colorLiteral(red: 0.7450980392, green: 0.8, blue: 0.8980392157, alpha: 1))
                    Circle()
                        .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .blur(radius: pressed ? 8 : 2)
                        .offset(x: pressed ? 4 : -4, y: pressed ? 4 : -4)
                }
            )
                .clipShape(Circle())
                .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 0, x: pressed ? -1 : 1, y: pressed ? -1 : 1)
                .shadow(color: pressed ? Color(#colorLiteral(red: 0.7450980392, green: 0.8, blue: 0.8980392157, alpha: 1)) : Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 20, x: -20, y: -20)
                .shadow(color: pressed ? Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) : Color(#colorLiteral(red: 0.7294117647, green: 0.7843137255, blue: 0.8941176471, alpha: 1)), radius: 20, x: 20, y: 20)
                .scaleEffect(tap ? 1.2 : 1)
                .gesture(
                    LongPressGesture().onChanged { value in
                        self.tap = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self.tap = false
                        }
                        impact(style: .light)
                    }
                    .onEnded { value in
                        self.pressed.toggle()
                        impact(style: .heavy)
                    }
            )
        }
    }
}

struct PayButton: View {
    @State var pressed = false
    @GestureState var tap = false
    
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 0.5)
            .updating($tap) { currentstate, gestureState,
                transaction in
                gestureState = currentstate
                impact(style: .light)
        }
        .onEnded { finished in
            self.pressed.toggle()
            impact(style: .heavy)
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                Image("fingerprint")
                    .scaleEffect(pressed ? 0 : 1)
                    .opacity(pressed ? 0: 1)
                
                Image("fingerprint-2")
                    .clipShape(Rectangle().offset(y: tap ? 1 : 50))
                    .scaleEffect(pressed ? 0 : 1)
                    .opacity(pressed ? 0: 1)
                
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 44, weight: .light, design: .rounded))
                    .foregroundColor(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                    .rotation3DEffect(Angle(degrees: pressed ? 0 : 30), axis: (x: 10, y: 0, z: 0))
                    .scaleEffect(pressed ? 1 : 0)
                    .opacity(pressed ? 1: 0)
            }
        }
        .frame(width: 120, height: 120)
        .background(
            ZStack {
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(pressed ? #colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(pressed ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9019607843, green: 0.9294117647, blue: 0.9882352941, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                Circle()
                    .stroke(Color.clear, lineWidth: 10)
                    .shadow(color: Color(#colorLiteral(red: 0.7256438732, green: 0.7787529826, blue: 0.8831245303, alpha: 1)), radius: pressed ? 10 : 3, x: pressed ? 5 : -5, y: pressed ? 5 : -5)
                Circle()
                    .stroke(Color.clear, lineWidth: 10)
                    .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 3, x: pressed ? -3 : 3, y: pressed ? -3 : 3)
            }
        )
        .overlay(
            Circle()
                .trim(from: tap ? 0.001 : 1, to: 1)
            .stroke(
                LinearGradient(gradient: Gradient(colors: [Color(pressed ? #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.4196078431, green: 0.2980392157, blue: 0.9490196078, alpha: 1)), Color(pressed ? #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 5, lineCap: .round)
            )
            .frame(width: 88, height: 88)
            .rotationEffect(Angle(degrees: 90))
            .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
            .shadow(color: Color(pressed ? #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.4196078431, green: 0.2980392157, blue: 0.9490196078, alpha: 1)).opacity(0.3), radius: 5, x: 0, y: 3)
                .animation(.easeInOut)
        )
            .clipShape(Circle())
            .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 0, x: pressed ? -1 : 1, y: pressed ? -1 : 1)
            .shadow(color: pressed ? Color(#colorLiteral(red: 0.7450980392, green: 0.8, blue: 0.8980392157, alpha: 1)) : Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), radius: 20, x: -20, y: -20)
            .shadow(color: pressed ? Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) : Color(#colorLiteral(red: 0.7294117647, green: 0.7843137255, blue: 0.8941176471, alpha: 1)), radius: 20, x: 20, y: 20)
            .scaleEffect(tap ? 1.2 : 1)
            .gesture(longPress)
    }
}

//
//  HomeView.swift
//  WHUT
//
//  Created by Nic Demai on 12/4/20.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    @State var showUpdate = false
    @Binding var showContent: Bool
    // CourseView
    @ObservedObject var store = CourseStore()
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @Binding var showSection: Bool
    
    var body: some View {
        ZStack {
            VStack {
                LinearGradient(gradient: Gradient(colors: [Color("background2"), Color("background1")]), startPoint: .top, endPoint: .bottom)
                    .frame(height: 200)
                Spacer()
            }
            .background(Color("background1"))
            .clipShape(RoundedRectangle(cornerRadius: showProfile ? 30 : 0, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
            .edgesIgnoringSafeArea(.all)
            
            // CourseList
            Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).opacity(Double(self.activeView.height/1000))
                .edgesIgnoringSafeArea(.all)
                .statusBar(hidden: active ? true : false)
                .animation(.linear)
            
            ScrollView {
                VStack {
                    HStack(spacing: 12) {
//                        Text("WHUT \nStudent Portal")
//                            .modifier(FontModifier(size: 28, weight: .bold))
//
                        Image(uiImage: #imageLiteral(resourceName: "title"))
                            .resizable()
                            .colorMultiply(.primary)
                            .frame(width: 220, height: 50.0)
                            .animation(nil)
                        
                        Spacer()
                        
                        AvatarView(showProfile: $showProfile)
                        
                        Button(action: { self.showUpdate.toggle() }) {
                            Image(systemName: "bell")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color.primary)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color("background3"))
                        .clipShape(Circle())
                        .shadow(color: Color("primary").opacity(0.1), radius: 1, x: 0, y: 1)
                        .shadow(color: Color("primary").opacity(0.2), radius: 10, x: 0, y: 10)
                        .sheet(isPresented: self.$showUpdate) {
                            UpdateList()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.leading, 14)
                    .padding(.top, 30)
                    .blur(radius: active ? 20 : 0)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        WatchRingsView()
                            .padding(.horizontal, 30)
                            .padding(.bottom, 30)
                            .onTapGesture {
                                self.showContent = true
                        }
                    }
                    .blur(radius: active ? 20 : 0)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(sections) { section in
                                GeometryReader { geometry in
                                    SectionView(section: section)
                                        .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX) - 30) / -getAngleMultiplier(), axis: (x: 0, y: 10, z: 0))
                                        .onTapGesture {
                                            self.showSection.toggle()
                                    }
                                }
                                .frame(width: 275, height: 275)
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 60)
                        .padding(.top, 10)
                    }
                    .blur(radius: active ? 20 : 0)
                    
                    // CourseList
                    VStack(spacing: 40) {
                        Text("Courses")
                            .font(.system(.title))
                            .fontWeight(.bold)
                            .alignmentGuide(.leading, computeValue: { _ in -30})
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .offset(y: 20)
                            .blur(radius: active ? 20 : 0)
                        
                        ForEach(self.store.courses.indices, id: \.self) { index in
                            GeometryReader { geometry in
                                ZStack {
                                    CourseView(
                                        show: self.$store.courses[index].show,
                                        course: self.store.courses[index],
                                        active: self.$active,
                                        index: index,
                                        activeIndex: self.$activeIndex,
                                        activeView: self.$activeView
                                    )
                                        .offset(y: self.store.courses[index].show ? -geometry.frame(in: .global).minY : 0)
                                        .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                        .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                                }
                            }
                            .frame(height: getCardHeight())
                            .frame(maxWidth: self.active ? 712 : getCardWidth())
                        }
                    }
                    .offset(y: -50)
                    
                    Spacer()
                }
                .frame(width: screen.width)
                .padding(.bottom, 300)
                // CourseList
                .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(false), showSection: .constant(false))
        .environmentObject(UserStore())
    }
}

struct SectionView: View {
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .foregroundColor(.white)
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .lineLimit(3)
                    .frame(width: 160, alignment: .leading)
                Spacer()
                Image(section.logo)
            }
            Text(section.text)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Image(uiImage: section.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(Color(section.color))
        .cornerRadius(30)
        .shadow(color: Color(section.color).opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: UIImage
    var color: UIColor
}

let sections = [
    Section(title: "Office Notice Emails", text: "2 Unread emails", logo: "Logo1", image: #imageLiteral(resourceName: "Card2"), color: #colorLiteral(red: 0.4156862745, green: 0.3333333333, blue: 0.9882352941, alpha: 1)),
    Section(title: "Attendance Results", text: "3 Classes Missed", logo: "Logo1", image: #imageLiteral(resourceName: "Card4"), color: #colorLiteral(red: 0.968627451, green: 0.2156862745, blue: 0.3411764706, alpha: 1)),
    Section(title: "Transcript Results", text: "102 Credit Score", logo: "Logo1", image: #imageLiteral(resourceName: "Card3"), color: #colorLiteral(red: 0.07843137255, green: 0.7450980392, blue: 0.9921568627, alpha: 1)),
    Section(title: "Airport Pickup and Dorm Reservation", text: "No Reservation", logo: "Logo1", image: #imageLiteral(resourceName: "Card2"), color: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)),
    Section(title: "School Map and Navigation", text: "Locate your classes", logo: "Logo1", image: #imageLiteral(resourceName: "Background1"), color: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)),
    Section(title: "Office Application Notes", text: "20 Notes Submited", logo: "Logo1", image: #imageLiteral(resourceName: "Card6"), color: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))
]

struct WatchRingsView: View {
    var body: some View {
        HStack(spacing: 30) {
            HStack(spacing: 20) {
                RingView(color1: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), width: 44, height: 44, percent: 100, show: .constant(true))
                VStack(alignment: .leading, spacing: 4) {
                    Text("Authenticated").font(.subheadline).fontWeight(.bold)
                    Text("December 25 - January 24").font(.caption)
                }
            }
            .padding(8)
            .background(Color("background3"))
            .modifier(CornerModifier(radius: 20))
            .modifier(ShadowModifier(color: Color("primary"), radius: 10))
            
        
        }
    }
}

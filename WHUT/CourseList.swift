//
//  CourseList.swift
//  WHUT
//
//  Created by Nic Demai on 12/4/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct CourseList: View {
//    @State var courses = courseData
    @ObservedObject var store = CourseStore()
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    
    var body: some View {
        ZStack {
            Color.black.opacity(Double(self.activeView.height/500))
                .edgesIgnoringSafeArea(.all)
                .statusBar(hidden: active ? true : false)
                .animation(.linear)
            
            ScrollView {
                VStack(spacing: 30) {
                    Text("Courses")
                        .font(.system(.largeTitle))
                        .fontWeight(.bold)
                        .alignmentGuide(.leading, computeValue: { _ in -30})
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                        .animation(nil)
                    
                    ForEach(store.courses.indices, id: \.self) { index in
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
                                .rotationEffect(Angle(degrees: Double(self.activeView.height / -10)))
                                .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                            }
                        }
                        .frame(height: getCardHeight())
                        .frame(maxWidth: self.active ? 712 : getCardWidth())
                    }
                }
                .frame(width: screen.width)
                .padding(.bottom, 300)
                .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0))
            }
        }
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var text: String
    var image: URL
    var logo: UIImage
    var color: UIColor
    var show: Bool
}

var courseData = [
    Course(title: "XML-Technology ", subtitle: "7 Weeks", text: "For those of you who don’t know about XML, let us explain: XML stands for Extensible Markup Language. Yes, we know it technically should be EML, but XML just sounds cooler. XML is not a programming language, which is used to implement algorithms, but rather it’s a markup language, which is used for giving logical structure to a set of information.\n\n\nThere has been a lot of excited talk about XML since the ’90s, given its ability to separate information from its presentation. While most of you have heard about XML and how it is used to present information on a browser, it can also define the type of information being presented. Pretty cool, huh? You’re also able to define your own set of tags. XML has become increasingly popular because of its ease in displaying information on a mobile device and its versatility in transferring data between different organizations.", image: URL(string: "https://dl.dropbox.com/s/pmggyp7j64nvvg8/Certificate%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false),
    Course(title: "Data Mining", subtitle: "8 Weeks", text: "There has been a lot of excited talk about XML since the ’90s, given its ability to separate information from its presentation. While most of you have heard about XML and how it is used to present information on a browser, it can also define the type of information being presented. Pretty cool, huh? You’re also able to define your own set of tags. XML has become increasingly popular because of its ease in displaying information on a mobile device and its versatility in transferring data between different organizations.", image: URL(string: "https://dl.dropbox.com/s/i08umta02pa09ns/Card3%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false),
    Course(title: "Information Security", subtitle: "4 Weeks", text: "In this course you will explore information security through some introductory material and gain an appreciation of the scope and context around the subject. This includes a brief introduction to cryptography, security management and network and computer security that allows you to begin the journey into the study of information security and develop your appreciation of some key information security concepts.\n The course concludes with a discussion around a simple model of the information security industry and explores skills, knowledge and roles so that you can determine and analyse potential career opportunities in this developing profession and consider how you may need to develop personally to attain your career goals.\n After completing the course you will have gained an awareness of key information security principles regarding information, confidentiality, integrity and availability. You will be able to explain some of the key aspects of information risk and security management, in addition, summarise some of the key aspects in computer and network security, including some appreciation of threats, attacks, exploits and vulnerabilities. You will also gain an awareness of some of the skills, knowledge and roles/careers opportunities within the information security industry.", image: URL(string: "https://dl.dropbox.com/s/6z67xs71hbyy6ds/Card4%402x.png?dl=0")!, logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), show: false)
]

struct CourseView: View {
    @Binding var show: Bool
    var course: Course
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading,spacing: 30) {
                Text(course.text)
                
                Text("About this course")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
                    .foregroundColor(Color("secondary"))
                
                Text("Minimal coding experience required, such as in HTML and CSS. Please note that Xcode 11 and Catalina are essential. Once you get everything installed, it'll get a lot friendlier! I added a bunch of troubleshoots at the end of this page to help you navigate the issues you might encounter.")
                .foregroundColor(Color("secondary"))
            }
            .padding(30)
            .offset(y: show ? 460 : 0)
            .frame(maxWidth: show ? .infinity : getCardWidth())
            .frame(maxHeight: show ? screen.height : 280, alignment: .top)
            .background(Color("background3"))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .lineLimit(3)
                            .foregroundColor(.white)
                            .animation(nil)
                        Text(course.subtitle.uppercased())
                            .foregroundColor(Color.white.opacity(0.7))
                            .animation(nil)
                    }
                    Spacer()
                    ZStack {
                        Image(uiImage: course.logo)
                            .opacity(show ? 0 : 1)
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0)
                    }
                }
                Spacer()
                WebImage(url: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 414)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
            .frame(height: show ? 460 : 280)
            .frame(maxWidth: show ? .infinity : getCardWidth())
            .background(Color(course.color))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
//            .gesture(
//                show ?
//                    DragGesture()
//                        .onChanged { value in
//                            guard !self.show else { return }
//                            guard value.translation.height < 300 else { return }
//                            guard value.translation.height > 0 else { return }
//
//
//                            self.activeView = value.translation
//                    }
//                    .onEnded { value in
//                        if self.activeView.height > 30 {
//                            self.show = false
//                            self.active = false
//                            self.activeIndex = -1
//                        }
//                        self.activeView = .zero
//                    }
//                    : nil
//            )
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                
                if self.show {
                    self.activeIndex = self.index
                } else {
                    self.activeIndex = -1
                }
            }
            
//            Text("\(self.activeView.height)").offset(y: 100)
            
            if show {
                CourseDetail(course: course, show: $show, active: $active, activeIndex: $activeIndex)
                    .background(Color("background1"))
                    .animation(.linear(duration: 0))
            }
        }
//        .gesture(
//            show ?
//                DragGesture()
//                    .onChanged { value in
//                        guard value.translation.height > 0 else { return }
//                        guard value.translation.height < 300 else { return }
//
//                        self.activeView = value.translation
//                }
//                .onEnded { value in
//                    if self.activeView.height > 30 {
//                        self.show = false
//                        self.active = false
//                        self.activeIndex = -1
//                    }
//                    self.activeView = .zero
//                }
//                : nil
//        )
        .frame(height: show ? screen.height : 280)
        .scaleEffect(1 - self.activeView.height / 1000)
        .rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10)), axis: (x: 10, y: 0, z: 0))
        .hueRotation(Angle(degrees: Double(self.activeView.height)))
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
    }
}

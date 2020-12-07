//
//  CourseDetail.swift
//  WHUT
//
//  Created by Nic Demai on 12/4/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct CourseDetail: View {
    var course: Course
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    @State var appear = false
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(course.title)
                                .font(.system(size: 24, weight: .bold))
                                .lineLimit(3)
                                .foregroundColor(.white)
                            Text(course.subtitle.uppercased())
                                .foregroundColor(Color.white.opacity(0.7))
                        }
                        Spacer()
                        ZStack {
                            VStack {
                                Image(systemName: "xmark")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36)
                            .background(Color.black)
                            .clipShape(Circle())
                            .onTapGesture {
                                self.show = false
                                self.active = false
                                self.activeIndex = -1
                            }
                        }
                    }
                    .opacity(appear ? 1 : 0)
                    .animation(.linear(duration: 1))
                    .onAppear {
                        self.appear = true
                    }
                    
                    Spacer()
                    
                    WebImage(url: course.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(height: 140, alignment: .top)
                }
                .padding(30)
                .padding(.top, 44)
                .frame(height: 460)
                .frame(maxWidth: 712)
                .background(Color(course.color))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
                
                VStack(alignment: .leading,spacing: 30) {
                    Text(course.text)
                        .foregroundColor(Color("secondary"))
                    
                    Text("Requirements")
                    .font(.title)
                    .fontWeight(.bold)
                    
                    Text("It is recomended that for all the courses regarding Computer Science the student come with a computer as the working machines provided by the school are subkjected to formating. To avoid the loss of content please come with your own computer")
                        .foregroundColor(Color("secondary"))
                    
                    Text("Teacher's Information")
                    .font(.title)
                    .fontWeight(.bold)
                    
                    Text("Name: *** \nPhone No: 131******** \nEmail: ********@qq.com \nOffice Number: ****")
                        .foregroundColor(Color("secondary"))
                }
                .padding(30)
                .padding(.bottom, 100)
                .frame(maxWidth: 712)
            }
            .frame(width: screen.width)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CourseDetail_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetail(course: courseData[0], show: .constant(true), active: .constant(true), activeIndex: .constant(-1))
    }
}

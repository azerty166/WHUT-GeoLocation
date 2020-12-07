//
//  UpdateDetail.swift
//  WHUT
//
//  Created by Nic Demai on 12/4/20.
//

import SwiftUI

struct UpdateDetail: View {
    var update: Update
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    VStack(alignment: .center, spacing: 30) {
                        Text(update.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .offset(y: -70)
                        Image(update.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 414)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    
                    Text(update.text)
                        .lineSpacing(4)
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                }
                .background(Color("background1"))
                .frame(minHeight: screen.height)
            }
        }
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail(update: updateData[0])
    }
}

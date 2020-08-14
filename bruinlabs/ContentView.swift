//
//  ContentView.swift
//  bruinlabs
//
//  Created by Daniel Hu on 7/14/20.
//  Copyright © 2020 Daniel Hu. All rights reserved.
//

import SwiftUI
import Firebase

//*****************//
//Completed Reviews//
//*****************//

struct completedReviews: Identifiable{
    var id = UUID()
    var sReview: String
}

//***********//
//Main Screen//
//***********//

struct ContentView: View {
    
    var body: some View{
        NavigationView {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                VStack{
                NavigationLink(destination: AthleticClubsList()) {
                    Text("Club Sports")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .foregroundColor(.textblue)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                        )
                }.buttonStyle(DefaultButtonStyle())
                    .offset(y: -125)
                
                NavigationLink(destination: ConsultingClubsList()) {
                    Text("Consulting Clubs")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .foregroundColor(.textblue)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                        )
                }.buttonStyle(PlainButtonStyle())
                    .offset(y: -75)
                
                NavigationLink(destination: CulturalClubsList()) {
                    Text("Cultural Clubs")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .foregroundColor(.textblue)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                        )
                }.buttonStyle(DefaultButtonStyle())
                    .offset(y: -25)
                
                NavigationLink(destination: TechClubsList()) {
                    Text("Tech Clubs")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .foregroundColor(.textblue)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                        )
                }.buttonStyle(PlainButtonStyle())
                    .offset(y: 25)
                
                NavigationLink(destination: FratSorList()) {
                    Text("Fraternities and Sororities")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .foregroundColor(.textblue)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                        )
                }.buttonStyle(DefaultButtonStyle())
                    .offset(y: 75)
                
                NavigationLink(destination: PFratsList()) {
                    Text("Professional Fraternities")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .foregroundColor(.textblue)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                        )
                }.buttonStyle(PlainButtonStyle())
                    .offset(y: 125)
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




//**************//
//Athletic Clubs//
//**************//

struct AthleticClubs: Identifiable {
    var id: Int
    
    let clubName, clubImage, description: String
}

struct AthleticClubsList: View {
    
    let athleticClubs: [AthleticClubs] = [
        .init(id: 0, clubName: "UCLA Club Boxing", clubImage: "boxing", description: "    UCLA boxing is a club sport that competes under the National Collegiate Boxing Association (NCBA). No experience nor desire to fight is necessary! Join if you want to learn boxing basics, get a great workout in, or eventually want to get in the ring to fight. Our club is led by a coach who is a full time boxing trainer, and the original founder of the club."),
    ]
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
                List(athleticClubs){ club in
                    NavigationLink(destination: AthleticClubsDescriptionView(club: club)){
                        VStack{
                            AthleticClubsItemRow(club: club)
                        }
                    }
                } .navigationBarTitle("Athletic Clubs")
            )
    }
}

struct AthleticClubsItemRow: View{
    let club: AthleticClubs
    
    var body: some View{
        HStack {
            Image(club.clubImage)
                .resizable()
                .clipShape(Circle())
                .frame(width: 70, height: 70)
                .clipped()
            VStack(alignment: .leading){
                Text(club.clubName).font(.headline)
            }.padding(.leading, 8)
        }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
    }
}

struct AthleticClubsCircleImage: View {
    let club: AthleticClubs
    
    var body: some View {
        Image(club.clubImage)
            .resizable()
            .frame(width: 225.0, height: 225.0)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
    }
}

struct AthleticClubsDescriptionView: View {
    
    let club: AthleticClubs
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                ScrollView{
                    AthleticClubsCircleImage(club: club)
                        .padding(.bottom, -100)
                        .offset(y: 130)
            
                    VStack(alignment: .leading) {
                        Text(club.clubName)
                            .font(.title)
                            .offset(y: 240)
                            .padding()
                        Text(club.description)
                            .font(.body)
                            .offset(y: 215)
                            .padding()
                    }
                }
                    NavigationLink(destination: AthleticClubsReviewsView(club: club)){
                        Text("See reviews")
                            .offset(y: -10)
                    }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct AthleticClubsReviewsView: View{
    @State private var review = ""
    @ObservedObject private var viewReviews = ReviewsViewModel()
    
    
    let club: AthleticClubs
    
    var body: some View{
         LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
            VStack{
                List(viewReviews.reviews){ userReviews in
                    VStack(alignment: .leading){
                        Text(userReviews.sReview)
                    }
                }
                .navigationBarTitle("Reviews")
                .onAppear(){
                    self.viewReviews.fetchData(org: self.club.clubName)
                }
            
            VStack {
                TextField("Write a review!", text: $review)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
                Button(action: {
                    let reviewList = [
                        "review":self.review
                    ]
                    
                    let docRef = Firestore.firestore().document("\(self.club.clubName) reviews/\(UUID().uuidString)")
                    print("Setting data...")
                    docRef.setData(reviewList){ (error) in
                        if let error = error {
                            print("ERROR = \(error)")
                        } else {
                            print("Data uploaded successfully!")
                            self.review = ""
                        }
                    }
                }){
                    Text("Submit Review")
                        .offset( y: -10)
                }
            
            }
            )
    }
}

//****************//
//Consulting Clubs//
//****************//

struct ConsultingClubs: Identifiable {
    var id: Int
    
    let clubName, clubImage, description: String
}

struct ConsultingClubsList: View {
    
    let consultingClubs: [ConsultingClubs] = [
        .init(id: 0, clubName: "Bruin Consulting", clubImage: "bruinconsulting", description: "     Bruin Consulting (BC) is a student run, non-profit consulting organization. BC is run by UCLA’s most talented and business oriented undergraduates in order to provide implementable consultancy services for its clients. Our mission is thus: we are focused on building value for our community of client organizations and UCLA students. To our clients, we provide innovative, yet tangible solutions which lead to optimized decision making and increased productivity. To our students, we emphasize professional and personal growth by developing analytical and creative intellectual capital."),
        .init(id: 1, clubName: "TAMID", clubImage: "tamid", description: "   TAMID is a non-profit organization that helps students develop their professional skills through an education program that focuses on both consulting and investing. We do pro-bono work for innovative Israeli startups on projects involving anything from market research to product development. TAMID has no political or religious affiliations and is open to all majors.")
    ]
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
                List(consultingClubs){ club in
                    NavigationLink(destination: ClubDescriptionView(club: club)){
                        VStack{
                            ClubItemRow(club: club)
                        }
                    }
                } .navigationBarTitle("Consulting Clubs")
            )
    }
}

struct ClubItemRow: View{
    let club: ConsultingClubs
    
    var body: some View{
        HStack {
            Image(club.clubImage)
                .resizable()
                .clipShape(Circle())
                .frame(width: 70, height: 70)
                .clipped()
            VStack(alignment: .leading){
                Text(club.clubName).font(.headline)
            }.padding(.leading, 8)
        }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
    }
}

struct ClubCircleImage: View {
    let club: ConsultingClubs
    
    var body: some View {
        Image(club.clubImage)
            .resizable()
            .frame(width: 225.0, height: 225.0)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
    }
}

struct ClubDescriptionView: View {
    
    let club: ConsultingClubs
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                ScrollView{
                    ClubCircleImage(club: club)
                        .padding(.bottom, -100)
                        .offset(y: 130)
            
                    VStack(alignment: .leading) {
                        Text(club.clubName)
                            .font(.title)
                            .offset(y: 240)
                            .padding()
                        Text(club.description)
                            .font(.body)
                            .offset(y: 215)
                            .padding()
                    }
                }
                    NavigationLink(destination: ClubReviewsView(club: club)){
                        Text("See reviews")
                            .offset(y: -10)
                    }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ClubReviewsView: View{
    @State private var review = ""
    @ObservedObject private var viewReviews = ReviewsViewModel()
    
    let club: ConsultingClubs
    
    var body: some View{
       LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
           .edgesIgnoringSafeArea(.vertical)
           .overlay(
           VStack{
               List(viewReviews.reviews){ userReviews in
                   VStack(alignment: .leading){
                       Text(userReviews.sReview)
                   }
               }
               .navigationBarTitle("Reviews")
               .onAppear(){
                   self.viewReviews.fetchData(org: self.club.clubName)
               }
           
           VStack {
               TextField("Write a review!", text: $review)
               .padding()
               .textFieldStyle(RoundedBorderTextFieldStyle())
           }
               Button(action: {
                   let reviewList = [
                       "review":self.review
                   ]
                   
                   let docRef = Firestore.firestore().document("\(self.club.clubName) reviews/\(UUID().uuidString)")
                   print("Setting data...")
                   docRef.setData(reviewList){ (error) in
                       if let error = error {
                           print("ERROR = \(error)")
                       } else {
                           print("Data uploaded successfully!")
                           self.review = ""
                       }
                   }
               }){
                   Text("Submit Review")
                       .offset( y: -10)
               }
           
           }
           )
    }
}

//**************//
//Cultural Clubs//
//**************//

struct CulturalClubs: Identifiable {
    var id: Int
    
    let clubName, clubImage, description: String
}

struct CulturalClubsList: View {
    
    let culturalClubs: [CulturalClubs] = [
        .init(id: 0, clubName: "Samahang Pilipino", clubImage: "samahang", description: "   Samahang Pilipino was founded in 1972 as a response to an observed lack of Pilipinx representation on campus and an apparent need for a community space. Issues that Samahang Pilipino and Samahang Pilipino Board were established to address the lack of relevant historical and cultural education, limited access to higher education, and low retention rates for students of color. Our historical contributions include being part of the Asian Coalition which fought for ethnic studies at UCLA, promoting cultural nights and cultural graduations, and helping to establish Filipino studies as a field."),
        .init(id: 1, clubName: "KASA (Korean American Student Association)", clubImage: "kasa", description: "   Our mission is to serve, improve, and educate UCLA's students and its robust community through Korean-American heritage. We are dedicated to being a strong, proud, diverse, and unified student organization of exemplary leaders.")
    ]
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
                List(culturalClubs){ club in
                    NavigationLink(destination: CulturalClubDescriptionView(club: club)){
                        VStack{
                            CulturalClubItemRow(club: club)
                        }
                    }
                } .navigationBarTitle("Cultural Clubs")
            )
    }
}

struct CulturalClubItemRow: View{
    let club: CulturalClubs
    
    var body: some View{
        HStack {
            Image(club.clubImage)
                .resizable()
                .clipShape(Circle())
                .frame(width: 70, height: 70)
                .clipped()
            VStack(alignment: .leading){
                Text(club.clubName).font(.headline)
            }.padding(.leading, 8)
        }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
    }
}

struct CulturalClubCircleImage: View {
    let club: CulturalClubs
    
    var body: some View {
        Image(club.clubImage)
            .resizable()
            .frame(width: 225.0, height: 225.0)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
    }
}

struct CulturalClubDescriptionView: View {
    
    let club: CulturalClubs
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                ScrollView{
                    CulturalClubCircleImage(club: club)
                        .padding(.bottom, -100)
                        .offset(y: 130)
            
                    VStack(alignment: .leading) {
                        Text(club.clubName)
                            .font(.title)
                            .offset(y: 240)
                            .padding()
                        Text(club.description)
                            .font(.body)
                            .offset(y: 215)
                            .padding()
                    }
                }
                    NavigationLink(destination: CulturalClubReviewsView(club: club)){
                        Text("See reviews")
                            .offset(y: -10)
                    }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct CulturalClubReviewsView: View{
    @State private var review = ""
    @ObservedObject private var viewReviews = ReviewsViewModel()
    
    let club: CulturalClubs
    
    var body: some View{
        LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
            VStack{
                List(viewReviews.reviews){ userReviews in
                    VStack(alignment: .leading){
                        Text(userReviews.sReview)
                    }
                }
                .navigationBarTitle("Reviews")
                .onAppear(){
                    self.viewReviews.fetchData(org: self.club.clubName)
                }
            
            VStack {
                TextField("Write a review!", text: $review)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
                Button(action: {
                    let reviewList = [
                        "review":self.review
                    ]
                    
                    let docRef = Firestore.firestore().document("\(self.club.clubName) reviews/\(UUID().uuidString)")
                    print("Setting data...")
                    docRef.setData(reviewList){ (error) in
                        if let error = error {
                            print("ERROR = \(error)")
                        } else {
                            print("Data uploaded successfully!")
                            self.review = ""
                        }
                    }
                }){
                    Text("Submit Review")
                        .offset( y: -10)
                }
            
            }
            )
    }
}

//**********//
//Tech Clubs//
//**********//

struct TechClubs: Identifiable {
    var id: Int
    
    let clubName, clubImage, description: String
}

struct TechClubsList: View {
    
    let techClubs: [TechClubs] = [
        .init(id: 0, clubName: "Dev-X", clubImage: "devx", description: "    DevX is a student run incubator that allows students of all backgrounds to build real-world projects in a startup environment. We focus on tackling problems both within the UCLA community. By joining DevX, you will be surrounded with like-minded students that develop solutions and make ventures on improving the college experience. If you choose to join, you’ll be paired with a Product Manager and develop a strong network with startup-oriented students."),
    ]
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
                List(techClubs){ club in
                    NavigationLink(destination: TechClubDescriptionView(club: club)){
                        VStack{
                            TechClubItemRow(club: club)
                        }
                    }
                } .navigationBarTitle("Tech Clubs")
            )
    }
}

struct TechClubItemRow: View{
    let club: TechClubs
    
    var body: some View{
        HStack {
            Image(club.clubImage)
                .resizable()
                .clipShape(Circle())
                .frame(width: 70, height: 70)
                .clipped()
            VStack(alignment: .leading){
                Text(club.clubName).font(.headline)
            }.padding(.leading, 8)
        }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
    }
}

struct TechClubCircleImage: View {
    let club: TechClubs
    
    var body: some View {
        Image(club.clubImage)
            .resizable()
            .frame(width: 225.0, height: 225.0)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
    }
}

struct TechClubDescriptionView: View {
    
    let club: TechClubs
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                ScrollView{
                    TechClubCircleImage(club: club)
                        .padding(.bottom, -100)
                        .offset(y: 130)
            
                    VStack(alignment: .leading) {
                        Text(club.clubName)
                            .font(.title)
                            .offset(y: 240)
                            .padding()
                        Text(club.description)
                            .font(.body)
                            .offset(y: 215)
                            .padding()
                    }
                }
                    NavigationLink(destination: TechClubReviewsView(club: club)){
                        Text("See reviews")
                            .offset(y: -10)
                    }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct TechClubReviewsView: View{
    @State private var review = ""
    @ObservedObject private var viewReviews = ReviewsViewModel()
    
    let club: TechClubs
    
    var body: some View{
        LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
            VStack{
                List(viewReviews.reviews){ userReviews in
                    VStack(alignment: .leading){
                        Text(userReviews.sReview)
                    }
                }
                .navigationBarTitle("Reviews")
                .onAppear(){
                    self.viewReviews.fetchData(org: self.club.clubName)
                }
            
            VStack {
                TextField("Write a review!", text: $review)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
                Button(action: {
                    let reviewList = [
                        "review":self.review
                    ]
                    
                    let docRef = Firestore.firestore().document("\(self.club.clubName) reviews/\(UUID().uuidString)")
                    print("Setting data...")
                    docRef.setData(reviewList){ (error) in
                        if let error = error {
                            print("ERROR = \(error)")
                        } else {
                            print("Data uploaded successfully!")
                            self.review = ""
                        }
                    }
                }){
                    Text("Submit Review")
                        .offset( y: -10)
                }
            
            }
            )
    }
}

//******************//
//Professional Frats//
//******************//

struct PFrats: Identifiable {
    var id: Int
    
    let orgName, estDate, letters, orgImage, description: String
}

struct PFratsList: View {
    
    let pFrats: [PFrats] = [
        .init(id: 0, orgName: "Delta Sigma Pi", estDate: "est. 1907", letters: "ΔΣΠ", orgImage: "dsp", description: "    As the premier business fraternity on campus, we are not only dedicated to business but also to community service events, social events, and other extracurricular activities.  The 50+ brothers comprising the Xi Omicron Chapter are some of the most highly motivated students at UCLA. The members of the fraternity are both outstanding individuals and strong team players. Each year, we draw in numerous students to our professional events and workshops. Implemented to further their knowledge of the business world, these events help provide the tools in developing prospective careers.")
    ]
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
                List(pFrats){ org in
                    NavigationLink(destination: PFratsDescriptionView(org: org)){
                        VStack{
                            PFratsItemRow(org: org)
                        }
                    }
                } .navigationBarTitle("Professional Frats")
            )
    }
}

struct PFratsItemRow: View{
    let org: PFrats
    
    var body: some View{
        HStack {
            Image(org.orgImage)
                .resizable()
                .clipShape(Circle())
                .frame(width: 70, height: 70)
                .clipped()
            VStack(alignment: .leading){
                Text(org.orgName).font(.headline)
            }.padding(.leading, 8)
        }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
    }
}

struct PFratsCircleImage: View {
    let org: PFrats
    
    var body: some View {
        Image(org.orgImage)
            .resizable()
            .frame(width: 225.0, height: 225.0)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
    }
}

struct PFratsDescriptionView: View {
    
    let org: PFrats
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                ScrollView{
                    PFratsCircleImage(org: org)
                        .padding(.bottom, -100)
                        .offset(y: 130)
            
                    VStack(alignment: .leading) {
                        Text(org.orgName + " - " + org.letters)
                            .font(.title)
                            .offset(y: 240)
                            .padding()
                        HStack {
                            Text(org.estDate)
                                .font(.subheadline)
                                .offset(y: 215)
                                .padding()
                            Spacer()
                        }
                        Text(org.description)
                            .font(.body)
                            .offset(y: 205)
                            .padding()
                    }
                }
                    NavigationLink(destination: PFratsReviewsView(org: org)){
                        Text("See reviews")
                            .offset(y: -10)
                    }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct PFratsReviewsView: View{
    @State private var review = ""
    @ObservedObject private var viewReviews = ReviewsViewModel()
    
    let org: PFrats
    
    var body: some View{
        LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
            VStack{
                List(viewReviews.reviews){ userReviews in
                    VStack(alignment: .leading){
                        Text(userReviews.sReview)
                    }
                }
                .navigationBarTitle("Reviews")
                .onAppear(){
                    self.viewReviews.fetchData(org: self.org.orgName)
                }
            
            VStack {
                TextField("Write a review!", text: $review)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
                Button(action: {
                    let reviewList = [
                        "review":self.review
                    ]
                    
                    let docRef = Firestore.firestore().document("\(self.org.orgName) reviews/\(UUID().uuidString)")
                    print("Setting data...")
                    docRef.setData(reviewList){ (error) in
                        if let error = error {
                            print("ERROR = \(error)")
                        } else {
                            print("Data uploaded successfully!")
                            self.review = ""
                        }
                    }
                }){
                    Text("Submit Review")
                        .offset( y: -10)
                }
            
            }
            )
    }
}

//****************//
//Frats/Sororities//
//****************//

struct FratSor: Identifiable {
    var id: Int
    
    let fsorg, image, initials : String
}

struct FratSorList: View {
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack{
                NavigationLink(destination: AGCView()) {
                Text("Asian Greek Council (AGC)")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .foregroundColor(.textblue)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                    )
                }.buttonStyle(PlainButtonStyle())
                    .offset(y: -150)
                
                NavigationLink(destination: IFCView()) {
                Text("Interfraternity Council (IFC)")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .foregroundColor(.textblue)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                    )
                }.buttonStyle(PlainButtonStyle())
                    .offset(y: -50)
                
                NavigationLink(destination: NPCView()) {
                Text("Panhellenic Council (NPC)")
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .foregroundColor(.textblue)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                    )
                }.buttonStyle(PlainButtonStyle())
                    .offset(y: 50)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct FSItemRow: View{
    let org: FratSor
    
    var body: some View{
        HStack {
            Image(org.image)
                .resizable()
                .clipShape(Circle())
                .frame(width: 70, height: 70)
                .clipped()
            VStack(alignment: .leading){
                Text(org.fsorg).font(.headline)
            }.padding(.leading, 8)
        }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
    }
}

//*****************//
//IFC Organizations//
//*****************//

struct IFC: Identifiable{
    var id: Int
    
    let orgName, estDate, letters, imageName, description: String
    
}

struct IFCView: View {
    
    let ifc: [IFC] = [
        .init(id: 0, orgName: "Delta Sigma Phi", estDate: "est. 1920", letters: "ΔΣΦ",
              imageName: "deltasigmaphi", description: "    Since 1920, Delta Sigma Phi has served as the paradigm for brotherhood in our longstanding tradition of creating better men for better lives. Rushing Delta Sigma Phi would connect you to an active brotherhood of over eighty members who are rooted in diversity and inclusion, in which lifelong friendships are formed within countless social, philanthropic, and community service events. Guided by the core values of culture, friendship, and harmony, join us in the pursuit of becoming a better man.")
    ]
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
                List(ifc){ org in
                    NavigationLink(destination: IFCDescriptionView(org: org)){
                        VStack{
                            IFCItemRow(org: org)
                        }
                    }
                } .navigationBarTitle("IFC Organizations")
            )
    }
}

struct IFCItemRow: View{
    let org: IFC
    
    var body: some View{
        HStack {
            Image(org.imageName)
                .resizable()
                .clipShape(Circle())
                .frame(width: 70, height: 70)
                .clipped()
            VStack(alignment: .leading){
                Text(org.orgName).font(.headline)
                Text(org.estDate).font(.subheadline)
            }.padding(.leading, 8)
        }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
    }
}

struct IFCCircleImage: View {
    let org: IFC
    
    var body: some View {
        Image(org.imageName)
            .resizable()
            .frame(width: 225.0, height: 225.0)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
    }
}

struct IFCDescriptionView: View {
    
    let org: IFC
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                ScrollView{
                    IFCCircleImage(org: org)
                        .padding(.bottom, -100)
                        .offset(y: 130)
            
                    VStack(alignment: .leading) {
                        Text(org.orgName + " - " + org.letters)
                            .font(.title)
                            .offset(y: 240)
                            .padding()
                        HStack {
                            Text(org.estDate)
                                .font(.subheadline)
                                .offset(y: 215)
                                .padding()
                            Spacer()
                        }
                        Text(org.description)
                            .font(.body)
                            .offset(y: 205)
                            .padding()
                    }
                }
                    NavigationLink(destination: IFCReviewsView(org: org)){
                        Text("See reviews")
                            .offset(y: -10)
                    }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct IFCReviewsView: View{
    @State private var review = ""
    @ObservedObject private var viewReviews = ReviewsViewModel()
    
    let org: IFC
    
    var body: some View{
        LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
            VStack{
                List(viewReviews.reviews){ userReviews in
                    VStack(alignment: .leading){
                        Text(userReviews.sReview)
                    }
                }
                .navigationBarTitle("Reviews")
                .onAppear(){
                    self.viewReviews.fetchData(org: self.org.orgName)
                }
            
            VStack {
                TextField("Write a review!", text: $review)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
                Button(action: {
                    let reviewList = [
                        "review":self.review
                    ]
                    
                    let docRef = Firestore.firestore().document("\(self.org.orgName) reviews/\(UUID().uuidString)")
                    print("Setting data...")
                    docRef.setData(reviewList){ (error) in
                        if let error = error {
                            print("ERROR = \(error)")
                        } else {
                            print("Data uploaded successfully!")
                            self.review = ""
                        }
                    }
                }){
                    Text("Submit Review")
                        .offset( y: -10)
                }
            
            }
            )
    }
}

//*****************//
//NPC Organizations//
//*****************//

struct NPC: Identifiable{
    var id: Int
    
    let orgName, estDate, letters, imageName, description: String
    
}

struct NPCView: View {
    
    let npc: [NPC] = [
        .init(id: 0, orgName: "Alpha Phi", estDate: "est. 1927", letters: "ΑΦ",
              imageName: "alphaphi", description: "     At a time when society looked upon women only as daughters, wives, and mothers not in need of higher education, our ten Founders were pioneers of the coeducational system. Attending school with the handicap of implied, if not open, opposition, our Founders sought support from each other. They felt the need for a place of conference, socialization, and communal support for women obtaining higher education and facing many of the same challenges. They formed Alpha Phi on October 10, 1872 at Syracuse University. Today, Alpha Phi continues to provide a tie which unites a circle of friends for women young and old all around the world.  Our chapter, Beta Delta, was founded at UCLA in 1927 and is proud to be one of the 160 Alpha Phi collegiate chapters nationwide.")
    ]
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
                List(npc){ org in
                    NavigationLink(destination: NPCDescriptionView(org: org)){
                        VStack{
                            NPCItemRow(org: org)
                        }
                    }
                } .navigationBarTitle("NPC Organizations")
            )
    }
}

struct NPCItemRow: View{
    let org: NPC
    
    var body: some View{
        HStack {
            Image(org.imageName)
                .resizable()
                .clipShape(Circle())
                .frame(width: 70, height: 70)
                .clipped()
            VStack(alignment: .leading){
                Text(org.orgName).font(.headline)
                Text(org.estDate).font(.subheadline)
            }.padding(.leading, 8)
        }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
    }
}

struct NPCCircleImage: View {
    let org: NPC
    
    var body: some View {
        Image(org.imageName)
            .resizable()
            .frame(width: 225.0, height: 225.0)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
    }
}

struct NPCDescriptionView: View {
    
    let org: NPC
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                ScrollView{
                    NPCCircleImage(org: org)
                        .padding(.bottom, -100)
                        .offset(y: 130)
            
                    VStack(alignment: .leading) {
                        Text(org.orgName + " - " + org.letters)
                            .font(.title)
                            .offset(y: 240)
                            .padding()
                        HStack {
                            Text(org.estDate)
                                .font(.subheadline)
                                .offset(y: 215)
                                .padding()
                            Spacer()
                        }
                        Text(org.description)
                            .font(.body)
                            .offset(y: 205)
                            .padding()
                    }
                }
                    NavigationLink(destination: NPCReviewsView(org: org)){
                        Text("See reviews")
                            .offset(y: -10)
                    }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct NPCReviewsView: View{
    @State private var review = ""
    @ObservedObject private var viewReviews = ReviewsViewModel()
    
    let org: NPC
    
    var body: some View{
        LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
            VStack{
                List(viewReviews.reviews){ userReviews in
                    VStack(alignment: .leading){
                        Text(userReviews.sReview)
                    }
                }
                .navigationBarTitle("Reviews")
                .onAppear(){
                    self.viewReviews.fetchData(org: self.org.orgName)
                }
            
            VStack {
                TextField("Write a review!", text: $review)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
                Button(action: {
                    let reviewList = [
                        "review":self.review
                    ]
                    
                    let docRef = Firestore.firestore().document("\(self.org.orgName) reviews/\(UUID().uuidString)")
                    print("Setting data...")
                    docRef.setData(reviewList){ (error) in
                        if let error = error {
                            print("ERROR = \(error)")
                        } else {
                            print("Data uploaded successfully!")
                            self.review = ""
                        }
                    }
                }){
                    Text("Submit Review")
                        .offset( y: -10)
                }
            
            }
            )
    }
}

//*****************//
//AGC Organizations//
//*****************//

struct AGC: Identifiable{
    var id: Int
    
    let orgName, estDate, letters, imageName, description: String
    
}

struct AGCView: View {
    
    let agc: [AGC] = [
        .init(id: 0, orgName: "Chi Alpha Delta", estDate: "est. 1929",letters: "ΧΑΔ", imageName: "cad", description: ""),
        .init(id: 1, orgName: "Omega Sigma Tau", estDate: "est. 1966", letters: "ΩΣΤ", imageName: "omega", description: "   Omega Sigma Tau is the first and largest Asian-interest fraternity at UCLA. Now entering its 54th year, our fraternity aims to instill the ideals of Brotherhood, Class, Confidence, Excellence, and Diversity in all of its brothers. From its roots as a small social organization, Omega Sigma Tau has grown into a powerful academic support system, a robust professional network, and most importantly, a family for all of its brothers."),
        .init(id: 2, orgName: "Theta Kappa Phi", estDate: "est. 1959", letters: "ΘΚΦ", imageName: "tkp", description: "     Founded in 1959, UCLA Theta Kappa Phi is an asian interest sorority that is open to all individuals. Thetas offers extensive social networking with organizations all over the west coast, alumnae connections in all fields of expertise, and scholarship opportunities for academic excellence and outstanding service. Thetas strive to provide a safe space and support system for all women. If you’re looking for a spontaneous, motivated, and driven sisterhood, please consider Theta Kappa Phi.")
    ]
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
                List(agc){ org in
                    NavigationLink(destination: AGCDescriptionView(org: org)){
                        VStack{
                            AGCItemRow(org: org)
                        }
                    }
                } .navigationBarTitle("AGC Organizations")
            )
    }
}

struct AGCItemRow: View{
    let org: AGC
    
    var body: some View{
        HStack {
            Image(org.imageName)
                .resizable()
                .clipShape(Circle())
                .frame(width: 70, height: 70)
                .clipped()
            VStack(alignment: .leading){
                Text(org.orgName).font(.headline)
                Text(org.estDate).font(.subheadline)
            }.padding(.leading, 8)
        }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
    }
}

struct AGCCircleImage: View {
    let org: AGC
    
    var body: some View {
        Image(org.imageName)
            .resizable()
            .frame(width: 225.0, height: 225.0)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
    }
}

struct AGCDescriptionView: View {
    
    let org: AGC
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                ScrollView{
                    AGCCircleImage(org: org)
                        .padding(.bottom, -100)
                        .offset(y: 130)
            
                    VStack(alignment: .leading) {
                        Text(org.orgName + " - " + org.letters)
                            .font(.title)
                            .offset(y: 240)
                            .padding()
                        HStack {
                            Text(org.estDate)
                                .font(.subheadline)
                                .offset(y: 215)
                                .padding()
                            Spacer()
                        }
                        Text(org.description)
                            .font(.body)
                            .offset(y: 205)
                            .padding()
                    }
                }
                    NavigationLink(destination: AGCReviewsView(org: org)){
                        Text("See reviews")
                            .offset(y: -10)
                    }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct AGCReviewsView: View{
    @State private var review = ""
    @ObservedObject private var viewReviews = ReviewsViewModel()
    
    let org: AGC
    
    var body: some View{
        LinearGradient(gradient: Gradient(colors: [.bruinblue, .white, .bruinyellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
            VStack{
                List(viewReviews.reviews){ userReviews in
                    VStack(alignment: .leading){
                        Text(userReviews.sReview)
                    }
                }
                .navigationBarTitle("Reviews")
                .onAppear(){
                    self.viewReviews.fetchData(org: self.org.orgName)
                }
            
            VStack {
                TextField("Write a review!", text: $review)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
                Button(action: {
                    let reviewList = [
                        "review":self.review
                    ]
                    
                    let docRef = Firestore.firestore().document("\(self.org.orgName) reviews/\(UUID().uuidString)")
                    print("Setting data...")
                    docRef.setData(reviewList){ (error) in
                        if let error = error {
                            print("ERROR = \(error)")
                        } else {
                            print("Data uploaded successfully!")
                            self.review = ""
                        }
                    }
                }){
                    Text("Submit Review")
                        .offset( y: -10)
                }
            
            }
            )
    }
}

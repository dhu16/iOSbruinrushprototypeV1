//
//  ContentView.swift
//  bruinlabs
//
//  Created by Daniel Hu on 7/14/20.
//  Copyright © 2020 Daniel Hu. All rights reserved.
//

import SwiftUI
import Firebase

//**************//
//Structs to use//
//**************//

struct UCLAorgs: Identifiable {
    var id: Int
    
    let orgType: String
}

struct AcademicClubs: Identifiable {
    var id: Int
    
    let clubName, clubImage, description: String
}

struct FratSor: Identifiable {
    var id: Int
    
    let fsorg, image, initials : String
}

struct AGC: Identifiable{
    var id: Int
    
    let orgName, estDate, letters, imageName, description: String
    
}

struct NPC: Identifiable{
    var id: Int
    
    let orgName, estDate, letters, imageName, description: String
    
}

struct completedReviews: Identifiable{
    var id = UUID()
    var sReview: String
}

//***********//
//Main Screen//
//***********//

struct ContentView: View {
 
    //probably redundant will delete
    let organizations: [UCLAorgs] = [
        .init(id: 0, orgType: "Academic Clubs"),
        .init(id: 1, orgType: "Club Sports"),
        .init(id: 2, orgType: "Fraternities and Sororities"),
        .init(id: 3, orgType: "Professional Fraternities"),
        
    ]
    
    var body: some View{
        NavigationView {
            VStack{
                NavigationLink(destination: FratSorList()) {
                    Text("Fraternities and Sororities")
                }.buttonStyle(PlainButtonStyle())
            
                NavigationLink(destination: AcademicClubsList()) {
                    Text("Academic Clubs")
                }.buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//**************//
//Academic Clubs//
//**************//

struct AcademicClubsList: View {
    
    let academicClubs: [AcademicClubs] = [
        .init(id: 0, clubName: "Bruin Consulting", clubImage: "bruinconsulting", description: "Bruin Consulting (BC) is a student run, non-profit consulting organization. BC is run by UCLA’s most talented and business oriented undergraduates in order to provide implementable consultancy services for its clients. Our mission is thus: we are focused on building value for our community of client organizations and UCLA students. To our clients, we provide innovative, yet tangible solutions which lead to optimized decision making and increased productivity. To our students, we emphasize professional and personal growth by developing analytical and creative intellectual capital."),
        .init(id: 1, clubName: "Dev-X", clubImage: "devx", description: "    DevX is a student run incubator that allows students of all backgrounds to build real-world projects in a startup environment. We focus on tackling problems both within the UCLA community. By joining DevX, you will be surrounded with like-minded students that develop solutions and make ventures on improving the college experience. If you choose to join, you’ll be paired with a Product Manager and develop a strong network with startup-oriented students."),
        .init(id: 2, clubName: "Samahang Pilipino", clubImage: "samahang", description: "   Samahang Pilipino was founded in 1972 as a response to an observed lack of Pilipinx representation on campus and an apparent need for a community space. Issues that Samahang Pilipino and Samahang Pilipino Board were established to address the lack of relevant historical and cultural education, limited access to higher education, and low retention rates for students of color. Our historical contributions include being part of the Asian Coalition which fought for ethnic studies at UCLA, promoting cultural nights and cultural graduations, and helping to establish Filipino studies as a field."),
        .init(id: 3, clubName: "TAMID", clubImage: "tamid", description: "   TAMID is a non-profit organization that helps students develop their professional skills through an education program that focuses on both consulting and investing. We do pro-bono work for innovative Israeli startups on projects involving anything from market research to product development. TAMID has no political or religious affiliations and is open to all majors.")
    ]
    
    var body: some View {
        NavigationView{
            List(academicClubs){ club in
                NavigationLink(destination: ClubDescriptionView(club: club)){
                        ClubItemRow(club: club)
                }
            }.navigationBarTitle("Academic Clubs")
        }
    }
}

struct ClubItemRow: View{
    let club: AcademicClubs
    
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
    let club: AcademicClubs
    
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
    
    let club: AcademicClubs
    
    var body: some View {
        VStack {
            ScrollView{
                ClubCircleImage(club: club)
                .padding(.bottom, -100)
                    .offset(y: -30)
            
                VStack(alignment: .leading) {
                    Text(club.clubName)
                        .font(.title)
                        .offset(y: 80)
                        .padding()
                    Text(club.description)
                        .font(.body)
                        .offset(y: 40)
                        .padding()
                }
            }
            //NavigationView{
                NavigationLink(destination: ClubReviewsView(club: club)){
                    Text("See reviews")
                        .offset(y: -5)
                }
        }
    }
}

struct ClubReviewsView: View{
    @State private var review = ""
    @ObservedObject private var viewReviews = ReviewsViewModel()
    
    let club: AcademicClubs
    
    var body: some View{
        VStack{
            NavigationView{
                List(viewReviews.reviews){ userReviews in
                    VStack(alignment: .leading){
                        Text(userReviews.sReview)
                    }
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
    }
}

//****************//
//Frats/Sororities//
//****************//

struct FratSorList: View {
    
    //prob redundant will delete
    let fratsor: [FratSor] = [
        .init(id: 0, fsorg: "Asian Greek Council (AGC)", image: "agc", initials: "AGC"),
        .init(id: 1, fsorg: "Interfraternity Council (IFC)", image: "ifc", initials: "IFC"),
        .init(id: 2, fsorg: "Latinx Greek Council (LGC)", image: "lgc", initials: "LGC"),
        .init(id: 3, fsorg: "Multi-Interest Greek Council (MIGC)", image: "migc", initials: "MIGC"),
        .init(id: 4, fsorg: "National Pan-Hellenic Council (NPHC)", image: "nphc", initials: "NPHC"),
        .init(id: 0, fsorg: "Panhellenic Council (NPC)", image: "npc", initials: "NPC"),
    ]
    
    var body: some View {
        NavigationView {
            VStack{
                NavigationLink(destination: AGCView()) {
                Text("Asian Greek Council")
                }.buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: NPCView()) {
                Text("Panhellenic Council")
                }.buttonStyle(PlainButtonStyle())
            }
        }
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
//NPC Organizations//
//*****************//

struct NPCView: View {
    
    let npc: [NPC] = [
        .init(id: 0, orgName: "Alpha Phi", estDate: "est. 1927", letters: "",
              imageName: "alphaphi", description: " At a time when society looked upon women only as daughters, wives, and mothers not in need of higher education, our ten Founders were pioneers of the coeducational system. Attending school with the handicap of implied, if not open, opposition, our Founders sought support from each other. They felt the need for a place of conference, socialization, and communal support for women obtaining higher education and facing many of the same challenges. They formed Alpha Phi on October 10, 1872 at Syracuse University. Today, Alpha Phi continues to provide a tie which unites a circle of friends for women young and old all around the world.  Our chapter, Beta Delta, was founded at UCLA in 1927 and is proud to be one of the 160 Alpha Phi collegiate chapters nationwide.")
    ]
    
    var body: some View {
        NavigationView{
            List(npc){ org in
                NavigationLink(destination: NPCDescriptionView(org: org)){
                        NPCItemRow(org: org)
                }
            }.navigationBarTitle("NPC")
        }
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
        VStack {
            ScrollView{
                NPCCircleImage(org: org)
                .padding(.bottom, -100)
                    .offset(y: -30)
            
                VStack(alignment: .leading) {
                    Text(org.orgName + " - " + org.letters)
                        .font(.title)
                        .offset(y: 80)
                        .padding()
                    HStack {
                        Text(org.estDate)
                            .font(.subheadline)
                            .offset(y: 50)
                            .padding()
                        Spacer()
                    }
                    Text(org.description)
                        .font(.body)
                        .offset(y: 40)
                        .padding()
                }
            }
            //NavigationView{
                NavigationLink(destination: NPCReviewsView(org: org)){
                    Text("See reviews")
                        .offset(y: -5)
                }
        }
    }
}

struct NPCReviewsView: View{
    @State private var review = ""
    @ObservedObject private var viewReviews = ReviewsViewModel()
    
    let org: NPC
    
    var body: some View{
        VStack{
            NavigationView{
                List(viewReviews.reviews){ userReviews in
                    VStack(alignment: .leading){
                        Text(userReviews.sReview)
                    }
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
    }
}

//*****************//
//AGC Organizations//
//*****************//

struct AGCView: View {
    
    let agc: [AGC] = [
        .init(id: 0, orgName: "Chi Alpha Delta", estDate: "est. 1929",letters: "ΧΑΔ", imageName: "cad", description: ""),
        .init(id: 1, orgName: "Omega Sigma Tau", estDate: "est. 1966", letters: "ΩΣΤ", imageName: "omega", description: "   Omega Sigma Tau is the first and largest Asian-interest fraternity at UCLA. Now entering its 54th year, our fraternity aims to instill the ideals of Brotherhood, Class, Confidence, Excellence, and Diversity in all of its brothers. From its roots as a small social organization, Omega Sigma Tau has grown into a powerful academic support system, a robust professional network, and most importantly, a family for all of its brothers."),
        .init(id: 2, orgName: "Theta Kappa Phi", estDate: "est. 1959", letters: "ΘΚΦ", imageName: "tkp", description: "     Founded in 1959, UCLA Theta Kappa Phi is an asian interest sorority that is open to all individuals. Thetas offers extensive social networking with organizations all over the west coast, alumnae connections in all fields of expertise, and scholarship opportunities for academic excellence and outstanding service. Thetas strive to provide a safe space and support system for all women. If you’re looking for a spontaneous, motivated, and driven sisterhood, please consider Theta Kappa Phi.")
    ]
    
    var body: some View{
        NavigationView{
            List(agc){ org in
                NavigationLink(destination: AGCDescriptionView(org: org)){
                        AGCItemRow(org: org)
                }
            }.navigationBarTitle("AGC")
        }
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
        VStack {
            ScrollView{
                AGCCircleImage(org: org)
                .padding(.bottom, -100)
                    .offset(y: -30)
            
                VStack(alignment: .leading) {
                //Text("Omega Sigma Tau - ΩΣΤ")
                    Text(org.orgName + " - " + org.letters)
                        .font(.title)
                        .offset(y: 80)
                        .padding()
                    HStack {
                        Text(org.estDate)
                            .font(.subheadline)
                            .offset(y: 50)
                            .padding()
                        Spacer()
                    }
                    Text(org.description)
                        .font(.body)
                        .offset(y: 40)
                        .padding()
                }
            }
            //NavigationView{
                NavigationLink(destination: AGCReviewsView(org: org)){
                    Text("See reviews")
                        .offset(y: -5)
                }
            //}.offset(y:50)
        }
    }
}

struct AGCReviewsView: View{
    @State private var review = ""
    @ObservedObject private var viewReviews = ReviewsViewModel()
    
    let org: AGC
    
    var body: some View{
        VStack{
            NavigationView{
                List(viewReviews.reviews){ userReviews in
                    VStack(alignment: .leading){
                        Text(userReviews.sReview)
                    }
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
    }
}

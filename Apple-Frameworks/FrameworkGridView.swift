//
//  FrameworkGridView.swift
//  Apple-Frameworks
//
//  Created by Apoorva Mallikarjuna Aradhya on 05/02/24.
//

import Foundation
import SwiftUI

struct FrameworkGridView: View{
    
    
    @StateObject var viewModel = FrameworkGridViewModel()
    
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View{
        NavigationView{
            ScrollView{
                TextField("Search", text: $viewModel.searchText)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .padding(.horizontal)

                
                LazyVGrid(columns: columns){
                    ForEach(viewModel.filteredFrameworks, id: \.id){
                        framework in FrameworkTitleView(framework: framework)
                            .onTapGesture {
                                viewModel.selectedFramework = framework
                            }
                    }
                }
            }
            .navigationTitle("🍎 Frameworks")
            .sheet(isPresented: $viewModel.isShowingDetailView) {
                FrameworkDetailView(framework: viewModel.selectedFramework!, isShowingDetailView: $viewModel.isShowingDetailView)
            }
        }
        
    }
}

struct FrameworkGridView_Previews: PreviewProvider{
    static var previews: some View{
        FrameworkGridView()
            .preferredColorScheme(.dark)
        
    }
}


struct FrameworkTitleView: View{
    let framework: Framework
    var body: some View{
        VStack{
            Image(framework.imageName)
                .resizable()
                .frame(width: 90, height: 90)
            Text(framework.name)
                .font(.title2)
                .fontWeight(.semibold)
                .scaledToFit()
                .minimumScaleFactor(0.6)
        }
        .padding()
    }
}

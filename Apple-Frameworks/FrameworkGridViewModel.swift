//
//  FrameworkGridViewModel.swift
//  Apple-Frameworks
//
//  Created by Apoorva Mallikarjuna Aradhya on 11/02/24.
//

import Foundation

import SwiftUI

final class FrameworkGridViewModel: ObservableObject {
    var selectedFramework: Framework?{
        didSet{
            isShowingDetailView = true
        }
    }
    @Published var isShowingDetailView = false
    
    @Published var searchText = ""

        // Assuming MockData.frameworks is your array of Framework objects
        private var allFrameworks = MockData.frameworks
        @Published var filteredFrameworks: [Framework] = []

        init() {
            // Initialize filteredFrameworks with allFrameworks
            filteredFrameworks = allFrameworks

            // Add a subscriber to update filteredFrameworks whenever searchText changes
            $searchText
                .map { searchText in
                    guard !searchText.isEmpty else {
                        return self.allFrameworks
                    }
                    return self.allFrameworks.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                }
                .assign(to: &$filteredFrameworks)
        }
}

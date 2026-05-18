//
//  MainSearchView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/16.
//

import Logging
import SwiftUI
import SwiftData

struct MainSearchView: View {
    
    // MARK: - Environment
    @Environment(\.modelContext) private var modelContext
    
    // MARK: - State
    @State private var viewModel: MainSearchViewModel
    @State private var isStoryPresented: Bool = false
    @State private var selectedGroup: StoryGroup?
    @State private var viewedStories: [Int] = []
    
    // MARK: - Namespace
    @Namespace private var animation
    
    // MARK: - Private
    private let logger = Logger(label: "MainSearchView")
    private let factory: ServiceFactoryProtocol
    
    // MARK: - Init
    init(viewModel: MainSearchViewModel, factory: ServiceFactoryProtocol) {
        self.viewModel = viewModel
        self.factory = factory
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            StoriesHStackView(viewedStories: $viewedStories,
                              selectedGroup: $selectedGroup,
                              isPresented: $isStoryPresented,
                              animation: animation)
            
            MainSearchInputView(viewModel: $viewModel, citySearchViewModel: makeCitySearchViewModel())
            
            if viewModel.areCitiesSelected {
                NavigationLink {
                    RouteListView(viewModel: makeRouteListViewModel(), carrierInfoService: factory.carrierInfoService)
                } label: {
                    MainSearchSearchButton()
                }
            }
            
            Spacer()
            
                .onAppear  {
                    viewedStories = getViewedStories()
                }
                .onChange(of: isStoryPresented) { _, newValue in
                    if !newValue {
                        viewedStories = getViewedStories()
                    }
                }
        }
        .overlay {
            if let group = selectedGroup, isStoryPresented {
                MainStoriesView(stories: group.stories, isPresented: $isStoryPresented)
                    .matchedGeometryEffect(id: group.previewImage, in: animation)
            }
        }
    }
    
    private func makeRouteListViewModel() -> RouteListViewModel {
        let service = factory.scheduleService
        let repository = RouteRepository(modelContainer: modelContext.container)
        return RouteListViewModel(
            from: viewModel.fromStation,
            to: viewModel.toStation,
            scheduleService: service,
            repository: repository
        )
        
    }
    
    private func makeCitySearchViewModel() -> CitySearchViewModel {
        let service = factory.stationsService
        let repository = CitiesWithStationsRepository(modelContainer: modelContext.container)
        return CitySearchViewModel(repository: repository, stationsListService: service)
        
    }
    
    private func getViewedStories() -> [Int] {
        if let stories = UserDefaults.standard.array(forKey: UserDefaultsKeys.viewedStories) {
            return stories as? [Int] ?? []
        }
        return []
    }
}

#Preview {
    MainSearchView(viewModel: MainSearchViewModel(), factory: MockServiceFactory())
}


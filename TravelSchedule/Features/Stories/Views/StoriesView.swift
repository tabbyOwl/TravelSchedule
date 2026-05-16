//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/21.
//
import SwiftUI

struct StoriesView: View {
    //MARK: - State
    @State private var currentStoryIndex: Int = 0
    @State private var currentProgress: CGFloat = 0
    
    //MARK: - Bindings
    @Binding private var isPresented: Bool
    
    //MARK: - Private properties
    private let stories: [Story]
    private var timerConfiguration: TimerConfiguration { .init(storiesCount: stories.count) }
    
    //MARK: - Init
    init(isPresented: Binding<Bool>, stories: [Story]) {
        _isPresented = isPresented
        self.stories = stories
    }
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesTabView(currentStoryIndex: $currentStoryIndex, stories: stories)
                .onChange(of: currentStoryIndex) { oldValue, newValue in
                    didChangeCurrentIndex(oldIndex: oldValue, newIndex: newValue)
                }

            StoriesProgressBar(
                storiesCount: stories.count,
                timerConfiguration: timerConfiguration,
                currentProgress: $currentProgress
            )
            .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            .onChange(of: currentProgress) { _, newValue in
                didChangeCurrentProgress(newProgress: newValue)
            }
        }
        .onAppear {
            if let first = stories.first {
                saveStory(id: first.id)
            }
        }
    }
    
    //MARK: - Private methods
    private func saveStory(id: Int) {
        var viewed = Set(UserDefaults.standard.array(forKey: UserDefaultsKeys.viewedStories) as? [Int] ?? [])
        viewed.insert(id)
        UserDefaults.standard.set(Array(viewed), forKey: UserDefaultsKeys.viewedStories)
    }

    private func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard oldIndex != newIndex else { return }
        
        saveStory(id: stories[newIndex].id)
        
        let progress = timerConfiguration.progress(for: newIndex)
        guard abs(progress - currentProgress) >= 0.01 else { return }
        withAnimation {
           
            currentProgress = progress
        }
       
    }

    private func didChangeCurrentProgress(newProgress: CGFloat) {
        if newProgress >= 1.0 {
            withAnimation(.linear(duration: 0.1)) {
                isPresented = false
                
            }
        }
        let index = timerConfiguration.index(for: newProgress)
        guard index != currentStoryIndex else { return }
        withAnimation {
            currentStoryIndex = index
        }
    }
    
}

#Preview {
    StoriesView(isPresented: .constant(false),
                stories: mockStoryGroups[0].stories)
}


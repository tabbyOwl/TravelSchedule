//
//  StoryStackCellViewModel.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/4/28.
//

final class StoryStackCellViewModel {
    
    //MARK: - Private properties
    private let _preview: String
    private let _title: String?
    private let _isViewed: Bool
    
    //MARK: - Init
    init(preview: String, title: String?, isViewed: Bool) {
        self._preview = preview
        self._title = title
        self._isViewed = isViewed
    }
    
    var preview: String {
        _preview
    }
    
    var title: String {
        _title ?? ""
    }
    
    var isViewed: Bool {
        _isViewed
    }
}

//
//  InfiniteScrollViewModel.swift
//  ChrisUI
//
//  View model for managing infinite scroll list state
//

import Foundation

/// View model for managing infinite scroll pagination state
///
/// This observable class manages the state for infinite scrolling lists,
/// including loading states, page tracking, and data fetching.
@Observable
public class InfiniteScrollViewModel<Item: Identifiable> {
    /// Current page of data
    public var items: [Item] = []
    /// Whether data is currently being loaded
    public var isLoading: Bool = false
    /// Current page number
    public var currentPage: Int = 1
    /// Total number of pages available
    public var totalPages: Int = 1
    /// Error message if loading fails
    public var errorMessage: String?

    /// Initializes the view model
    public init() {}

    /// Whether more items are available to load
    public var hasMore: Bool {
        currentPage < totalPages
    }

    /// Loads the next page of data
    /// - Parameter fetchPage: Async function to fetch data for a page
    public func loadNextPage(
        fetchPage: @escaping (Int) async throws -> ([Item], Int)
    ) async {
        guard hasMore && !isLoading else { return }

        isLoading = true
        errorMessage = nil

        do {
            let (newItems, totalPages) = try await fetchPage(currentPage + 1)
            self.items.append(contentsOf: newItems)
            self.currentPage += 1
            self.totalPages = totalPages
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    /// Refreshes the data from the first page
    /// - Parameter fetchPage: Async function to fetch data for a page
    public func refresh(
        fetchPage: @escaping (Int) async throws -> ([Item], Int)
    ) async {
        isLoading = true
        errorMessage = nil
        currentPage = 1

        do {
            let (newItems, totalPages) = try await fetchPage(1)
            self.items = newItems
            self.totalPages = totalPages
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}

//
//  BookController.swift
//  Reading List
//
//  Created by patelpra on 12/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    // MARK: - Books empty array
    private(set) var books: [Book] = []
    
    // MARK: - Computed property
    private var readingListFileURL: URL? {
        
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documentDirectory.appendingPathComponent("ReadingList.plist")
    }
    // MARK: - 
    var readBooks: [Book] {
        return self.books.filter { ($0.hasBeenRead == true) }
    }
    
    var unreadBooks: [Book] {
        return self.books.filter { ($0.hasBeenRead == false ) }
    }
    
    // MARK: - CRUD (Create, Read, Update, Delete)
    func createBook(withTitle title: String, withReasonToRead reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(at index: Int, book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].hasBeenRead = !books[index].hasBeenRead
        saveToPersistentStore()
    }
    
    func updateBook(for book: Book, withTitle title: String, withReasonToRead reasonToRead: String) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].title = title
        books[index].reasonToRead = reasonToRead
        saveToPersistentStore()
    }
    
    // MARK: - Save to disk
    func saveToPersistentStore() {
        guard let url = self.readingListFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    // MARK: - Load from disk
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListFileURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let booksData = try Data(contentsOf: url)
            let decodedBooks = PropertyListDecoder()
            self.books = try decodedBooks.decode([Book].self, from: booksData)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
}



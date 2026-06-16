//
//  BooksViewModel.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 10/06/26.
//

import Foundation
import Observation

@Observable
final class BooksViewModel {
    var books: [BooksModel] = [
        BooksModel(
            title: "Sapiens",
            author: "Yuval Noah Harari",
            coverImage: "Sapiens",
            pages: 443,
            year: 2011,
            about: "Sapiens explores the history of humankind, tracing the journey from early hunter-gatherers to modern civilizations. Yuval Noah Harari examines how biology, culture, and shared beliefs shaped societies, economies, and technologies. The book offers a thought-provoking perspective on humanity's past and future.",
            status: true
        ),
        
        BooksModel(
            title: "Atomic Habits",
            author: "James Clear",
            coverImage: "AtomicHabits",
            pages: 320,
            year: 2018,
            about: "Atomic Habits explains how small, consistent actions can lead to remarkable personal growth over time. James Clear introduces practical strategies for building positive habits, breaking negative ones, and designing environments that support success. The book focuses on sustainable improvement rather than dramatic change.",
            status: false
        ),
        
        BooksModel(
            title: "The Alchemist",
            author: "Paulo Coelho",
            coverImage: "TheAlchemist",
            pages: 208,
            year: 1988,
            about: "The Alchemist follows Santiago, a young shepherd who embarks on a journey in search of treasure. Along the way, he encounters challenges, mentors, and valuable life lessons that help him discover his personal legend. The novel explores themes of destiny, courage, and self-discovery.",
            status: false
        ),
        
        BooksModel(
            title: "Rich Dad Poor Dad",
            author: "Robert T. Kiyosaki",
            coverImage: "RichDadPoorDad",
            pages: 336,
            year: 1997,
            about: "Rich Dad Poor Dad contrasts two approaches to money and financial education through the author's experiences growing up. The book highlights the importance of financial literacy, investing, and building assets instead of relying solely on traditional employment. It challenges common beliefs about wealth and success.",
            status: true
        ),
        
        BooksModel(
            title: "Deep Work",
            author: "Cal Newport",
            coverImage: "DeepWork",
            pages: 304,
            year: 2016,
            about: "Deep Work argues that the ability to focus without distraction is becoming increasingly valuable in today's world. Cal Newport presents strategies for cultivating concentration, reducing interruptions, and producing high-quality work. The book emphasizes deliberate practice and meaningful productivity.",
            status: true
        )
    ]}

//
//  QuizViewModel.swift
//  QuizApp
//
//  Created by Ana Oganesiani on 03.11.24.
//

import Foundation

class QuizViewModel {
    var questions: [Question] = []
    
    init() {
        loadQuestions()
    }
    
    private func loadQuestions() {
        guard let url = Bundle.main.url(forResource: "Questions", withExtension: "json") else {
            print("Не удалось найти файл Questions.json")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode([Question].self, from: data)
            self.questions = response
        } catch {
            print("Ошибка при загрузке вопросов из JSON: \(error)")
        }
    }
}

/*
See LICENSE folder for this sample’s licensing information.

Abstract:
 Cria uma instância comum do classificador de exercícios.
 
 Para s
 
 O aplicativo usa apenas uma instância de qualquer maneira e usando uma propriedade estática inicializa
  o modelo no lançamento, em vez de quando a exibição principal é carregada.
*/

import CoreML

extension ExerciseClassifier {
    /// Creates a shared Exercise Classifier instance for the app at launch.
    static let shared: ExerciseClassifier = {
        // Use a default model configuration.
        let defaultConfig = MLModelConfiguration()

        // Create an Exercise Classifier instance.
        guard let exerciseClassifier = try? ExerciseClassifier(configuration: defaultConfig) else {
            // The app requires the action classifier to function.
            fatalError("Exercise Classifier failed to initialize.")
        }

        // Ensure the Exercise Classifier.Label cases match the model's classes.
        exerciseClassifier.checkLabels()

        return exerciseClassifier
    }()
}

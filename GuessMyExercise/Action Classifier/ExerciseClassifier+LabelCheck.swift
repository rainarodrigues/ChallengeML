/*
Adiciona uma verificação de tempo de execução para ver se o conhecimento do aplicativo corresponde aos rótulos do modelo.
*/

extension ExerciseClassifier {
    /// Ensures the apps knows all of the model's labels at runtime.
    func checkLabels() {
        let metadata = model.modelDescription.metadata
        guard let classLabels = model.modelDescription.classLabels else {
            fatalError("The model doesn't appear to be a classifier.")
        }

        print("Checking the class labels in `\(Self.self)` model:")

        if let author = metadata[.author] {
            print("\tAuthor: \(author)")
        }

        if let description = metadata[.description] {
            print("\tDescription: \(description)")
        }

        if let version = metadata[.versionString] {
            print("\tVersion: \(version)")
        }

        if let license = metadata[.license] {
            print("\tLicense: \(license)")
        }

        print("Labels:")
        for (number, modelLabel) in classLabels.enumerated() {
            guard let modelLabelString = modelLabel as? String else {
                print("The label `\(modelLabel)` is not a string.")
                fatalError("Action classifier labels should be strings.")
            }

            // Ensure ExerciseClassifier.Label supports the model's label.
            let label = Label(modelLabelString)
            print("  \(number): \(label.rawValue)")
        }

        if Label.allCases.count != classLabels.count {
            let difference = Label.allCases.count - classLabels.count
            print("Warning: \(Label.self) contains \(difference) extra class labels.")
        }
    }
}

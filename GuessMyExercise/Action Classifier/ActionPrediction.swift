/*
Basicamente esse arquivo ele vai trabalhar com rotulos da minha ação para prever o que ele tá
 entendendo de acordo com que tá sendo passado pela camera!
 Se o app está començando
 se tem uma pessoa
 Se quanto confiante é aquela pose que está sendo passada

*/

/// Bundles an action label with a confidence value.
/// - Tag: ActionPrediction
struct ActionPrediction {
    /// O nome da ação prevista pelo classificador de exercícios.
    let label: String

    /// A confiança do classificador de exercícios em sua previsão.
    let confidence: Double!

    /// A string that represents the confidence as percentage if applicable;
    /// otherwise `nil`.
    /// Tipo o valor do teste de confiabilidade daquela strig já que meu cod trabalha com a taxa de pocentagem daquelas possiçoes
    var confidenceString: String? {
        guard let confidence = confidence else {
            return nil
        }

        // Converta a confiança em uma string baseada em porcentagem.
        let percent = confidence * 100
        let formatString = percent >= 99.5 ? "%2.0f %%" : "%2.1f %%"
        return String(format: formatString, percent)
    }

    init(label: String, confidence: Double) {
        self.label = label
        self.confidence = confidence
    }
}

extension ActionPrediction {
    /// Define rótulos de previsão de espaço reservado além do escopo do

    /// action classifier model.
    private enum AppLabel: String {
        case starting = "Starting Up" // começão
        case noPerson = "No Person" // - nenhuma pessoa
        case lowConfidence = "Low Confidence" //- baixa confiança
    }

    /// Uma previsão que representa uma janela de tempo que não contém
    /// observações de pose de corpo humano suficientes.
    static let startingPrediction = ActionPrediction(.starting)

    /// Uma previsão que representa uma janela de tempo que não contém
    /// observações de pose de corpo humano suficientes.
    /// - Tag: noPersonPrediction
    static let noPersonPrediction = ActionPrediction(.noPerson)

    /// Uma previsão que toma o lugar da previsão real do
    /// Modelo de classificador de ação que tem uma confiança baixa.
    /// - Tag: baixaConfiançaPredição
    static let lowConfidencePrediction = ActionPrediction(.lowConfidence)

    /// Creates a prediction with an app-defined label.
    /// - Parameter otherLabel: A label defined by the application, not the
    /// action classifier model.
    /// Only the `lowConfidence()` and `noPerson()` type methods use this initializer.
    private init(_ otherLabel: AppLabel) {
        label = otherLabel.rawValue
        confidence = nil
    }

    /// A Boolean that indicates whether the label is from the action classifier model.
    ///
    /// isModelLabel and `isAppLabel` are mutually exclusive.
    var isModelLabel: Bool { !isAppLabel }

    /// A Boolean that indicates whether the label is from the app.
    ///
    /// `isAppLabel` and `isModelLabel` are mutually exclusive.
    var isAppLabel: Bool { confidence == nil }
}

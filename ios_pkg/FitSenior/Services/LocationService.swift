import Foundation

/// Serviço para reconhecimento de cidades e bairros brasileiros
class LocationService {
    static let shared = LocationService()
    
    // Principais cidades brasileiras
    private let cities: Set<String> = [
        "São Paulo", "Rio de Janeiro", "Brasília", "Salvador", "Fortaleza",
        "Belo Horizonte", "Manaus", "Curitiba", "Recife", "Goiânia",
        "Porto Alegre", "Belém", "Guarulhos", "Campinas", "São Luís",
        "São Gonçalo", "Maceió", "Duque de Caxias", "Natal", "Teresina",
        "Campo Grande", "Nova Iguaçu", "São Bernardo do Campo", "João Pessoa",
        "Santo André", "Osasco", "Jaboatão dos Guararapes", "São José dos Campos",
        "Ribeirão Preto", "Uberlândia", "Sorocaba", "Contagem", "Aracaju",
        "Feira de Santana", "Cuiabá", "Joinville", "Aparecida de Goiânia",
        "Londrina", "Juiz de Fora", "Porto Velho", "Ananindeua", "Serra",
        "Niterói", "Caxias do Sul", "Campos dos Goytacazes", "Macapá",
        "Vila Velha", "Florianópolis", "São João de Meriti", "Mauá",
        "São José do Rio Preto", "Mogi das Cruzes", "Diadema", "Betim",
        "Carapicuíba", "Campina Grande", "Jundiaí", "Olinda", "Caruaru",
        "Santos", "Maringá", "Volta Redonda", "Cariacica", "Bauru",
        "Canoas", "Vitória", "Petrolina", "Paulista", "Ponta Grossa",
        "Franca", "Blumenau", "Ribeirão das Neves", "Uberaba", "Caucaia",
        "Petrópolis", "Várzea Grande", "Cascavel", "Anápolis", "Viamão",
        "Barueri", "Guarujá", "Praia Grande", "Taubaté", "São Caetano do Sul",
        "Vitória da Conquista", "Foz do Iguaçu", "Suzano", "Palmas", "Camaçari",
        "Juazeiro do Norte", "Itaquaquecetuba", "Araçatuba", "Rio Branco",
        "Cabo Frio", "Ilhéus", "Limeira", "Cabo de Santo Agostinho", "Camaragibe"
    ]
    
    // Principais bairros brasileiros (exemplos das principais cidades)
    private let neighborhoods: Set<String> = [
        // São Paulo
        "Centro", "Vila Mariana", "Pinheiros", "Jardins", "Moema", "Itaim Bibi",
        "Brooklin", "Vila Madalena", "Butantã", "Lapa", "Perdizes", "Higienópolis",
        "Bela Vista", "Consolação", "Liberdade", "Bom Retiro", "Brás", "Tatuapé",
        "Mooca", "Ipiranga", "Santo André", "São Bernardo", "Osasco",
        // Rio de Janeiro
        "Copacabana", "Ipanema", "Leblon", "Barra da Tijuca", "Botafogo",
        "Flamengo", "Laranjeiras", "Tijuca", "Maracanã", "Centro", "Lapa",
        "Santa Teresa", "Gávea", "Jardim Botânico", "Urca", "Recreio",
        // Belo Horizonte
        "Savassi", "Centro", "Funcionários", "Lourdes", "Pampulha", "Cidade Nova",
        // Curitiba
        "Centro", "Batel", "Água Verde", "Mercês", "Bigorrilho", "Boa Vista",
        // Porto Alegre
        "Centro", "Moinhos de Vento", "Bela Vista", "Bom Fim", "Cidade Baixa",
        // Recife
        "Boa Viagem", "Recife Antigo", "Pina", "Brasília Teimosa", "Casa Amarela",
        // Salvador
        "Barra", "Ondina", "Rio Vermelho", "Pelourinho", "Pituba", "Itapuã",
        // Fortaleza
        "Meireles", "Aldeota", "Praia de Iracema", "Dionísio Torres", "Centro",
        // Brasília
        "Asa Norte", "Asa Sul", "Lago Sul", "Lago Norte", "Sudoeste", "Noroeste"
    ]
    
    private init() {}
    
    /// Extrai cidade e bairro de uma string de localização
    func parseLocation(_ location: String) -> (city: String?, neighborhood: String?) {
        let normalized = location.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Procura por cidade
        var foundCity: String? = nil
        for city in cities {
            if normalized.localizedCaseInsensitiveContains(city) {
                foundCity = city
                break
            }
        }
        
        // Procura por bairro
        var foundNeighborhood: String? = nil
        for neighborhood in neighborhoods {
            if normalized.localizedCaseInsensitiveContains(neighborhood) {
                foundNeighborhood = neighborhood
                break
            }
        }
        
        // Se não encontrou cidade conhecida, tenta extrair do início da string
        if foundCity == nil {
            let components = normalized.components(separatedBy: CharacterSet(charactersIn: ", -"))
            if let firstComponent = components.first, firstComponent.count > 3 {
                // Pode ser uma cidade não listada
                foundCity = firstComponent.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        return (foundCity, foundNeighborhood)
    }
    
    /// Verifica se uma localização contém uma cidade específica
    func containsCity(_ location: String, city: String) -> Bool {
        return location.localizedCaseInsensitiveContains(city)
    }
    
    /// Verifica se uma localização contém um bairro específico
    func containsNeighborhood(_ location: String, neighborhood: String) -> Bool {
        return location.localizedCaseInsensitiveContains(neighborhood)
    }
    
    /// Lista todas as cidades conhecidas
    func getAllCities() -> [String] {
        return Array(cities).sorted()
    }
    
    /// Lista todos os bairros conhecidos
    func getAllNeighborhoods() -> [String] {
        return Array(neighborhoods).sorted()
    }
}


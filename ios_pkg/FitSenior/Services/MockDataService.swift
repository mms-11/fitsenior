import Foundation

/// Serviço para fornecer dados mockados das aulas baseados no frontend
class MockDataService {
    static let shared = MockDataService()
    
    private init() {}
    
    /// Retorna as aulas mockadas que correspondem ao frontend
    func getMockClasses() -> [Class] {
        let locationService = LocationService.shared
        
        return [
            Class(
                id: "1",
                professionalId: "prof-1",
                activity: "Ginástica ao Ar Livre",
                description: "Aulas de ginástica ao ar livre para idosos, focadas em alongamento, flexibilidade e fortalecimento muscular.",
                schedule: "Terça e Quinta, 8h",
                maxStudents: 12,
                location: "Parque da Cidade, São Paulo - SP",
                price: 80.0,
                demandId: nil,
                createdAt: Date(),
                imageUrl: "class-example-1",
                category: "outdoor",
                level: "Iniciante",
                rating: 4.9,
                instructor: "Prof. Maria Silva",
                city: locationService.parseLocation("Parque da Cidade, São Paulo - SP").city,
                neighborhood: locationService.parseLocation("Parque da Cidade, São Paulo - SP").neighborhood
            ),
            Class(
                id: "2",
                professionalId: "prof-2",
                activity: "Yoga para Idosos",
                description: "Aulas de yoga adaptadas para idosos, promovendo equilíbrio, flexibilidade e bem-estar mental.",
                schedule: "Segunda e Quarta, 10h",
                maxStudents: 8,
                location: "Studio Bem-Estar, Copacabana - Rio de Janeiro - RJ",
                price: 120.0,
                demandId: nil,
                createdAt: Date(),
                imageUrl: "class-example-2",
                category: "yoga",
                level: "Todos os níveis",
                rating: 5.0,
                instructor: "Prof. Ana Costa",
                city: locationService.parseLocation("Studio Bem-Estar, Copacabana - Rio de Janeiro - RJ").city,
                neighborhood: locationService.parseLocation("Studio Bem-Estar, Copacabana - Rio de Janeiro - RJ").neighborhood
            ),
            Class(
                id: "3",
                professionalId: "prof-3",
                activity: "Musculação Adaptada",
                description: "Treinamento de força adaptado para idosos, com equipamentos seguros e acompanhamento especializado.",
                schedule: "Seg, Qua, Sex, 15h",
                maxStudents: 6,
                location: "Academia Vida Ativa, Centro - Belo Horizonte - MG",
                price: 150.0,
                demandId: nil,
                createdAt: Date(),
                imageUrl: "class-example-3",
                category: "gym",
                level: "Intermediário",
                rating: 4.8,
                instructor: "Prof. João Santos",
                city: locationService.parseLocation("Academia Vida Ativa, Centro - Belo Horizonte - MG").city,
                neighborhood: locationService.parseLocation("Academia Vida Ativa, Centro - Belo Horizonte - MG").neighborhood
            ),
            Class(
                id: "4",
                professionalId: "prof-4",
                activity: "Caminhada em Grupo",
                description: "Caminhadas guiadas em grupo, promovendo socialização e atividade física leve.",
                schedule: "Todos os dias, 7h",
                maxStudents: 20,
                location: "Parque Municipal, Centro - Curitiba - PR",
                price: 60.0,
                demandId: nil,
                createdAt: Date(),
                imageUrl: "class-example-1",
                category: "outdoor",
                level: "Iniciante",
                rating: 4.7,
                instructor: "Prof. Carlos Lima",
                city: locationService.parseLocation("Parque Municipal, Centro - Curitiba - PR").city,
                neighborhood: locationService.parseLocation("Parque Municipal, Centro - Curitiba - PR").neighborhood
            ),
            Class(
                id: "5",
                professionalId: "prof-5",
                activity: "Pilates Sênior",
                description: "Aulas de pilates adaptadas para idosos, focadas em fortalecimento do core e melhoria da postura.",
                schedule: "Terça e Quinta, 14h",
                maxStudents: 10,
                location: "Espaço Saúde Plena, Vila Mariana - São Paulo - SP",
                price: 140.0,
                demandId: nil,
                createdAt: Date(),
                imageUrl: "class-example-2",
                category: "pilates",
                level: "Todos os níveis",
                rating: 4.9,
                instructor: "Prof. Beatriz Alves",
                city: locationService.parseLocation("Espaço Saúde Plena, Vila Mariana - São Paulo - SP").city,
                neighborhood: locationService.parseLocation("Espaço Saúde Plena, Vila Mariana - São Paulo - SP").neighborhood
            ),
            Class(
                id: "6",
                professionalId: "prof-6",
                activity: "Hidroginástica",
                description: "Exercícios aquáticos para idosos, proporcionando baixo impacto e fortalecimento muscular.",
                schedule: "Segunda, Quarta, Sexta, 9h",
                maxStudents: 15,
                location: "Clube Aquático, Barra da Tijuca - Rio de Janeiro - RJ",
                price: 130.0,
                demandId: nil,
                createdAt: Date(),
                imageUrl: "class-example-3",
                category: "water",
                level: "Iniciante",
                rating: 5.0,
                instructor: "Prof. Roberto Souza",
                city: locationService.parseLocation("Clube Aquático, Barra da Tijuca - Rio de Janeiro - RJ").city,
                neighborhood: locationService.parseLocation("Clube Aquático, Barra da Tijuca - Rio de Janeiro - RJ").neighborhood
            )
        ]
    }
}


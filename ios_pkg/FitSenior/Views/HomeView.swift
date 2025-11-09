import SwiftUI

struct HomeView: View {
    @State private var featuredClasses: [Class] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 40) {
                    // Hero Section
                    VStack(spacing: 20) {
                        // Imagem do logo
                        ZStack {
                            Color.clear
                                .frame(width: 120, height: 120)
                            
                            Image("Logo")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                        }
                        .compositingGroup()
                        .drawingGroup()
                        
                        Text("Conectando Idosos a Profissionais de Educação Física")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Text("Encontre aulas de atividade física perto de você, com profissionais qualificados e horários flexíveis.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        NavigationLink(destination: SearchClassesView()) {
                            Text("Começar Agora")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.teal)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        NavigationLink(destination: CreateClassView()) {
                            Text("Sou Profissional")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.systemGray6))
                                .foregroundColor(.primary)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 40)
                    
                    // Stats
                    HStack(spacing: 30) {
                        StatItem(value: "500+", label: "Alunos Ativos")
                        StatItem(value: "100+", label: "Profissionais")
                        StatItem(value: "50+", label: "Locais")
                    }
                    .padding()
                    
                    // Aulas Disponíveis
                    if !featuredClasses.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Aulas Disponíveis")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.horizontal)
                            
                            Text("Confira algumas das aulas mais populares na sua região")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(featuredClasses.prefix(3)) { classItem in
                                        ClassCard(classItem: classItem)
                                            .frame(width: 300)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("FitSênior")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                loadFeaturedClasses()
            }
        }
    }
    
    private func loadFeaturedClasses() {
        // Usar dados mockados locais para garantir compilação
        featuredClasses = getLocalMockClasses()
    }
    
    // Dados mockados locais usando apenas tipos nativos
    private func getLocalMockClasses() -> [Class] {
        return [
            Class(
                id: "1",
                professionalId: "prof-1",
                activity: "Ginástica ao Ar Livre",
                description: "Aulas de ginástica ao ar livre para idosos.",
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
                city: "São Paulo",
                neighborhood: nil
            ),
            Class(
                id: "2",
                professionalId: "prof-2",
                activity: "Yoga para Idosos",
                description: "Aulas de yoga adaptadas para idosos.",
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
                city: "Rio de Janeiro",
                neighborhood: "Copacabana"
            ),
            Class(
                id: "3",
                professionalId: "prof-3",
                activity: "Musculação Adaptada",
                description: "Treinamento de força adaptado para idosos.",
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
                city: "Belo Horizonte",
                neighborhood: "Centro"
            )
        ]
    }
}

struct StatItem: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.teal)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct ClassCard: View {
    let classItem: Class
    
    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 0) {
                // Imagem
                ClassImageView(imageName: classItem.imageUrl)
                    .frame(height: 180)
                    .clipped()
                
                // Badge de nível
                if let level = classItem.level {
                    HStack {
                        Spacer()
                        Text(level)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.trailing, 12)
                    .padding(.top, -20)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(classItem.activity)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    if let instructor = classItem.instructor {
                        Text(instructor)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "mappin")
                                .foregroundColor(.teal)
                            Text(classItem.location)
                                .font(.subheadline)
                        }
                        
                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(.teal)
                            Text(classItem.schedule)
                                .font(.subheadline)
                        }
                        
                        HStack {
                            Image(systemName: "person.2")
                                .foregroundColor(.teal)
                            Text("\(classItem.maxStudents) vagas disponíveis")
                                .font(.subheadline)
                        }
                        
                        if let rating = classItem.rating {
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                                Text(String(format: "%.1f", rating))
                                    .fontWeight(.semibold)
                                Text("(50+ avaliações)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                    HStack {
                        if let price = classItem.price {
                            Text("R$ \(Int(price))/mês")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.teal)
                        }
                        
                        Spacer()
                        
                        PrimaryButton(title: "Ver Detalhes") {}
                    }
                    .padding(.top, 8)
                }
                .padding()
            }
        }
    }
}


#Preview {
    HomeView()
}


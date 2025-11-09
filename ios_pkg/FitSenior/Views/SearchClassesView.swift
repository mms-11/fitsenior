import SwiftUI

// Definição local de ClassImageView (até ser adicionado ao target do Xcode)
struct ClassImageView: View {
    let imageName: String?
    
    @ViewBuilder
    var body: some View {
        if let imageName = imageName, let image = UIImage(named: imageName) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else {
            // Fallback usando cores nativas do SwiftUI quando não há imagem
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.teal.opacity(0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .overlay(
                Image(systemName: "photo")
                    .font(.system(size: 40))
                    .foregroundColor(.white.opacity(0.7))
            )
        }
    }
}

struct SearchClassesView: View {
    @State private var searchLocation = ""
    @State private var categoryFilter = "all"
    @State private var levelFilter = "all"
    @State private var classes: [Class] = []
    
    let categories = ["all": "Todas", "outdoor": "Ao Ar Livre", "yoga": "Yoga", 
                     "gym": "Musculação", "pilates": "Pilates", "water": "Hidroginástica"]
    
    let levels = ["all": "Todos", "Iniciante": "Iniciante", 
                 "Intermediário": "Intermediário", "Todos os níveis": "Flexível"]
    
    var filteredClasses: [Class] {
        let locationService = LocationService.shared
        
        return classes.filter { classItem in
            // Filtro de localização
            let matchesLocation = searchLocation.isEmpty || 
                classItem.location.localizedCaseInsensitiveContains(searchLocation) ||
                (classItem.city != nil && locationService.containsCity(searchLocation, city: classItem.city!)) ||
                (classItem.neighborhood != nil && locationService.containsNeighborhood(searchLocation, neighborhood: classItem.neighborhood!))
            
            // Filtro de categoria
            let matchesCategory = categoryFilter == "all" || classItem.category == categoryFilter
            
            // Filtro de nível
            let matchesLevel = levelFilter == "all" || classItem.level == levelFilter
            
            return matchesLocation && matchesCategory && matchesLevel
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Encontre Sua Aula")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Descubra atividades físicas próximas a você")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    // Filters
                    CardView {
                        VStack(spacing: 16) {
                            TextInput(
                                title: "Localização",
                                text: $searchLocation,
                                placeholder: "Digite sua localização...",
                                showSearchIcon: true
                            )
                            
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "line.3.horizontal.decrease.circle")
                                        .foregroundColor(.teal)
                                        .font(.caption)
                                    Text("Categoria")
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                }
                                
                                Picker("Categoria", selection: $categoryFilter) {
                                    ForEach(Array(categories.keys.sorted()), id: \.self) { key in
                                        Text(categories[key] ?? "").tag(key)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .accentColor(.teal)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "chart.bar")
                                        .foregroundColor(.teal)
                                        .font(.caption)
                                    Text("Nível")
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                }
                                
                                Picker("Nível", selection: $levelFilter) {
                                    ForEach(Array(levels.keys.sorted()), id: \.self) { key in
                                        Text(levels[key] ?? "").tag(key)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .accentColor(.teal)
                            }
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                    
                    // Results Count
                    Text("\(filteredClasses.count) \(filteredClasses.count == 1 ? "aula encontrada" : "aulas encontradas")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    // Classes Grid
                    if filteredClasses.isEmpty {
                        CardView {
                            VStack(spacing: 16) {
                                Text("Nenhuma aula encontrada com os filtros selecionados.")
                                    .foregroundColor(.secondary)
                                
                                OutlineButton(title: "Limpar Filtros") {
                                    searchLocation = ""
                                    categoryFilter = "all"
                                    levelFilter = "all"
                                }
                            }
                            .padding()
                        }
                        .padding(.horizontal)
                    } else {
                        ForEach(filteredClasses) { classItem in
                            ClassSearchCard(classItem: classItem)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationTitle("Buscar Aulas")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                loadClasses()
            }
        }
    }
    
    private func loadClasses() {
        // Usar dados mockados locais para garantir compilação
        classes = getLocalMockClasses()
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
            ),
            Class(
                id: "4",
                professionalId: "prof-4",
                activity: "Caminhada em Grupo",
                description: "Caminhadas guiadas em grupo.",
                schedule: "Todos os dias, 7h",
                maxStudents: 20,
                location: "Parque Municipal, Centro - Curitiba - PR",
                price: 60.0,
                demandId: nil,
                createdAt: Date(),
                // TODO: Adicionar imagem específica para esta aula
                imageUrl: nil, // "class-example-4" - adicionar imagem depois
                category: "outdoor",
                level: "Iniciante",
                rating: 4.7,
                instructor: "Prof. Carlos Lima",
                city: "Curitiba",
                neighborhood: "Centro"
            ),
            Class(
                id: "5",
                professionalId: "prof-5",
                activity: "Pilates Sênior",
                description: "Aulas de pilates adaptadas para idosos.",
                schedule: "Terça e Quinta, 14h",
                maxStudents: 10,
                location: "Espaço Saúde Plena, Vila Mariana - São Paulo - SP",
                price: 140.0,
                demandId: nil,
                createdAt: Date(),
                // TODO: Adicionar imagem específica para esta aula
                imageUrl: nil, // "class-example-5" - adicionar imagem depois
                category: "pilates",
                level: "Todos os níveis",
                rating: 4.9,
                instructor: "Prof. Beatriz Alves",
                city: "São Paulo",
                neighborhood: "Vila Mariana"
            ),
            Class(
                id: "6",
                professionalId: "prof-6",
                activity: "Hidroginástica",
                description: "Exercícios aquáticos para idosos.",
                schedule: "Segunda, Quarta, Sexta, 9h",
                maxStudents: 15,
                location: "Clube Aquático, Barra da Tijuca - Rio de Janeiro - RJ",
                price: 130.0,
                demandId: nil,
                createdAt: Date(),
                // TODO: Adicionar imagem específica para esta aula
                imageUrl: nil, // "class-example-6" - adicionar imagem depois
                category: "water",
                level: "Iniciante",
                rating: 5.0,
                instructor: "Prof. Roberto Souza",
                city: "Rio de Janeiro",
                neighborhood: "Barra da Tijuca"
            )
        ]
    }
}

struct ClassSearchCard: View {
    let classItem: Class
    
    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 0) {
                // Imagem
                ZStack(alignment: .topTrailing) {
                    ClassImageView(imageName: classItem.imageUrl)
                        .frame(height: 200)
                        .clipped()
                    
                    // Badge de nível
                    if let level = classItem.level {
                        Text(level)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(12)
                    }
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
                                .frame(width: 16)
                            Text(classItem.location)
                                .font(.subheadline)
                        }
                        
                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(.teal)
                                .frame(width: 16)
                            Text(classItem.schedule)
                                .font(.subheadline)
                        }
                        
                        HStack {
                            Image(systemName: "person.2")
                                .foregroundColor(.teal)
                                .frame(width: 16)
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
                    .padding(.top, 4)
                }
                .padding()
                
                Divider()
                
                HStack {
                    if let price = classItem.price {
                        Text("R$ \(Int(price))/mês")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.teal)
                    }
                    
                    Spacer()
                    
                    PrimaryButton(title: "Reservar") {}
                }
                .padding()
            }
        }
    }
}

#Preview {
    SearchClassesView()
}


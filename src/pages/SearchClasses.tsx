import { useState } from "react";
import { Card, CardContent, CardFooter, CardHeader } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { MapPin, Clock, Users, Star, Search, Filter } from "lucide-react";
import classImage1 from "@/assets/class-example-1.jpg";
import classImage2 from "@/assets/class-example-2.jpg";
import classImage3 from "@/assets/class-example-3.jpg";

const SearchClasses = () => {
  const [searchLocation, setSearchLocation] = useState("");
  const [categoryFilter, setCategoryFilter] = useState("all");
  const [levelFilter, setLevelFilter] = useState("all");

  // Mock data - em produção viria de um banco de dados
  const classes = [
    {
      id: 1,
      image: classImage1,
      title: "Ginástica ao Ar Livre",
      instructor: "Prof. Maria Silva",
      category: "outdoor",
      location: "Parque da Cidade",
      time: "Terça e Quinta, 8h",
      spots: 12,
      rating: 4.9,
      price: "R$ 80/mês",
      level: "Iniciante",
    },
    {
      id: 2,
      image: classImage2,
      title: "Yoga para Idosos",
      instructor: "Prof. Ana Costa",
      category: "yoga",
      location: "Studio Bem-Estar",
      time: "Segunda e Quarta, 10h",
      spots: 8,
      rating: 5.0,
      price: "R$ 120/mês",
      level: "Todos os níveis",
    },
    {
      id: 3,
      image: classImage3,
      title: "Musculação Adaptada",
      instructor: "Prof. João Santos",
      category: "gym",
      location: "Academia Vida Ativa",
      time: "Seg, Qua, Sex, 15h",
      spots: 6,
      rating: 4.8,
      price: "R$ 150/mês",
      level: "Intermediário",
    },
    {
      id: 4,
      image: classImage1,
      title: "Caminhada em Grupo",
      instructor: "Prof. Carlos Lima",
      category: "outdoor",
      location: "Parque Municipal",
      time: "Todos os dias, 7h",
      spots: 20,
      rating: 4.7,
      price: "R$ 60/mês",
      level: "Iniciante",
    },
    {
      id: 5,
      image: classImage2,
      title: "Pilates Sênior",
      instructor: "Prof. Beatriz Alves",
      category: "pilates",
      location: "Espaço Saúde Plena",
      time: "Terça e Quinta, 14h",
      spots: 10,
      rating: 4.9,
      price: "R$ 140/mês",
      level: "Todos os níveis",
    },
    {
      id: 6,
      image: classImage3,
      title: "Hidroginástica",
      instructor: "Prof. Roberto Souza",
      category: "water",
      location: "Clube Aquático",
      time: "Segunda, Quarta, Sexta, 9h",
      spots: 15,
      rating: 5.0,
      price: "R$ 130/mês",
      level: "Iniciante",
    },
  ];

  const filteredClasses = classes.filter((classItem) => {
    const matchesLocation = searchLocation === "" || 
      classItem.location.toLowerCase().includes(searchLocation.toLowerCase());
    const matchesCategory = categoryFilter === "all" || classItem.category === categoryFilter;
    const matchesLevel = levelFilter === "all" || classItem.level === levelFilter;
    
    return matchesLocation && matchesCategory && matchesLevel;
  });

  return (
    <div className="min-h-screen bg-gradient-hero">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <div className="mb-8 space-y-4">
          <h1 className="text-4xl md:text-5xl font-bold">Encontre Sua Aula</h1>
          <p className="text-xl text-muted-foreground">
            Descubra atividades físicas próximas a você
          </p>
        </div>

        {/* Filters */}
        <Card className="mb-8 shadow-soft">
          <CardContent className="p-6">
            <div className="grid md:grid-cols-3 gap-4">
              <div className="space-y-2">
                <Label htmlFor="location" className="text-base">
                  <Search className="w-4 h-4 inline mr-2" />
                  Localização
                </Label>
                <Input
                  id="location"
                  placeholder="Digite sua localização..."
                  value={searchLocation}
                  onChange={(e) => setSearchLocation(e.target.value)}
                  className="text-base h-12"
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="category" className="text-base">
                  <Filter className="w-4 h-4 inline mr-2" />
                  Categoria
                </Label>
                <Select value={categoryFilter} onValueChange={setCategoryFilter}>
                  <SelectTrigger id="category" className="text-base h-12">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">Todas as categorias</SelectItem>
                    <SelectItem value="outdoor">Ao Ar Livre</SelectItem>
                    <SelectItem value="yoga">Yoga</SelectItem>
                    <SelectItem value="gym">Musculação</SelectItem>
                    <SelectItem value="pilates">Pilates</SelectItem>
                    <SelectItem value="water">Hidroginástica</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="space-y-2">
                <Label htmlFor="level" className="text-base">Nível</Label>
                <Select value={levelFilter} onValueChange={setLevelFilter}>
                  <SelectTrigger id="level" className="text-base h-12">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">Todos os níveis</SelectItem>
                    <SelectItem value="Iniciante">Iniciante</SelectItem>
                    <SelectItem value="Intermediário">Intermediário</SelectItem>
                    <SelectItem value="Todos os níveis">Flexível</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Results Count */}
        <div className="mb-6">
          <p className="text-lg text-muted-foreground">
            {filteredClasses.length} {filteredClasses.length === 1 ? "aula encontrada" : "aulas encontradas"}
          </p>
        </div>

        {/* Classes Grid */}
        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
          {filteredClasses.map((classItem) => (
            <Card key={classItem.id} className="overflow-hidden hover:shadow-medium transition-all group">
              <div className="relative h-48 overflow-hidden">
                <img
                  src={classItem.image}
                  alt={classItem.title}
                  className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
                />
                <Badge className="absolute top-4 right-4 bg-secondary text-secondary-foreground">
                  {classItem.level}
                </Badge>
              </div>
              
              <CardHeader>
                <div className="space-y-2">
                  <h3 className="text-xl font-bold">{classItem.title}</h3>
                  <p className="text-muted-foreground">{classItem.instructor}</p>
                </div>
              </CardHeader>
              
              <CardContent className="space-y-3">
                <div className="flex items-center gap-2 text-sm">
                  <MapPin className="w-4 h-4 text-primary flex-shrink-0" />
                  <span>{classItem.location}</span>
                </div>
                <div className="flex items-center gap-2 text-sm">
                  <Clock className="w-4 h-4 text-primary flex-shrink-0" />
                  <span>{classItem.time}</span>
                </div>
                <div className="flex items-center gap-2 text-sm">
                  <Users className="w-4 h-4 text-primary flex-shrink-0" />
                  <span>{classItem.spots} vagas disponíveis</span>
                </div>
                <div className="flex items-center gap-2">
                  <Star className="w-4 h-4 fill-secondary text-secondary flex-shrink-0" />
                  <span className="font-semibold">{classItem.rating}</span>
                  <span className="text-muted-foreground text-sm">(50+ avaliações)</span>
                </div>
              </CardContent>
              
              <CardFooter className="flex items-center justify-between pt-6 border-t">
                <div className="text-2xl font-bold text-primary">{classItem.price}</div>
                <Button>Reservar</Button>
              </CardFooter>
            </Card>
          ))}
        </div>

        {filteredClasses.length === 0 && (
          <Card className="p-12 text-center">
            <p className="text-xl text-muted-foreground">
              Nenhuma aula encontrada com os filtros selecionados.
            </p>
            <Button 
              variant="outline" 
              className="mt-4"
              onClick={() => {
                setSearchLocation("");
                setCategoryFilter("all");
                setLevelFilter("all");
              }}
            >
              Limpar Filtros
            </Button>
          </Card>
        )}
      </div>
    </div>
  );
};

export default SearchClasses;

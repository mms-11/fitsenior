import { useState } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useToast } from "@/hooks/use-toast";
import { GraduationCap, MapPin, Calendar, DollarSign, Users, FileText } from "lucide-react";

const CreateClass = () => {
  const { toast } = useToast();
  const [formData, setFormData] = useState({
    title: "",
    description: "",
    category: "",
    location: "",
    schedule: "",
    maxStudents: "",
    price: "",
    level: "",
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    
    // Validação básica
    if (!formData.title || !formData.category || !formData.location || !formData.schedule) {
      toast({
        title: "Erro",
        description: "Por favor, preencha todos os campos obrigatórios.",
        variant: "destructive",
      });
      return;
    }

    // Em produção, aqui seria feita a requisição para salvar no banco
    toast({
      title: "Aula Cadastrada!",
      description: "Sua aula foi criada com sucesso e já está visível para os alunos.",
    });

    // Limpar formulário
    setFormData({
      title: "",
      description: "",
      category: "",
      location: "",
      schedule: "",
      maxStudents: "",
      price: "",
      level: "",
    });
  };

  const handleChange = (field: string, value: string) => {
    setFormData((prev) => ({ ...prev, [field]: value }));
  };

  return (
    <div className="min-h-screen bg-gradient-hero">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <div className="mb-8 space-y-4">
          <h1 className="text-4xl md:text-5xl font-bold">Cadastrar Nova Aula</h1>
          <p className="text-xl text-muted-foreground">
            Preencha as informações da sua aula para começar a receber alunos
          </p>
        </div>

        <div className="grid lg:grid-cols-3 gap-8">
          {/* Form */}
          <div className="lg:col-span-2">
            <Card className="shadow-medium">
              <CardHeader>
                <CardTitle className="text-2xl">Informações da Aula</CardTitle>
                <CardDescription className="text-base">
                  Quanto mais detalhes você fornecer, mais fácil será para os alunos encontrarem sua aula
                </CardDescription>
              </CardHeader>
              <CardContent>
                <form onSubmit={handleSubmit} className="space-y-6">
                  {/* Title */}
                  <div className="space-y-2">
                    <Label htmlFor="title" className="text-base">
                      <FileText className="w-4 h-4 inline mr-2" />
                      Título da Aula *
                    </Label>
                    <Input
                      id="title"
                      placeholder="Ex: Yoga para Iniciantes"
                      value={formData.title}
                      onChange={(e) => handleChange("title", e.target.value)}
                      className="text-base h-12"
                      required
                    />
                  </div>

                  {/* Description */}
                  <div className="space-y-2">
                    <Label htmlFor="description" className="text-base">
                      Descrição
                    </Label>
                    <Textarea
                      id="description"
                      placeholder="Descreva sua aula, metodologia, benefícios..."
                      value={formData.description}
                      onChange={(e) => handleChange("description", e.target.value)}
                      className="text-base min-h-32"
                      rows={5}
                    />
                  </div>

                  {/* Category and Level */}
                  <div className="grid md:grid-cols-2 gap-4">
                    <div className="space-y-2">
                      <Label htmlFor="category" className="text-base">
                        Categoria *
                      </Label>
                      <Select 
                        value={formData.category} 
                        onValueChange={(value) => handleChange("category", value)}
                      >
                        <SelectTrigger id="category" className="text-base h-12">
                          <SelectValue placeholder="Selecione..." />
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="outdoor">Ao Ar Livre</SelectItem>
                          <SelectItem value="yoga">Yoga</SelectItem>
                          <SelectItem value="gym">Musculação</SelectItem>
                          <SelectItem value="pilates">Pilates</SelectItem>
                          <SelectItem value="water">Hidroginástica</SelectItem>
                          <SelectItem value="dance">Dança</SelectItem>
                          <SelectItem value="stretch">Alongamento</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>

                    <div className="space-y-2">
                      <Label htmlFor="level" className="text-base">
                        <GraduationCap className="w-4 h-4 inline mr-2" />
                        Nível *
                      </Label>
                      <Select 
                        value={formData.level} 
                        onValueChange={(value) => handleChange("level", value)}
                      >
                        <SelectTrigger id="level" className="text-base h-12">
                          <SelectValue placeholder="Selecione..." />
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="Iniciante">Iniciante</SelectItem>
                          <SelectItem value="Intermediário">Intermediário</SelectItem>
                          <SelectItem value="Avançado">Avançado</SelectItem>
                          <SelectItem value="Todos os níveis">Todos os níveis</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                  </div>

                  {/* Location */}
                  <div className="space-y-2">
                    <Label htmlFor="location" className="text-base">
                      <MapPin className="w-4 h-4 inline mr-2" />
                      Localização *
                    </Label>
                    <Input
                      id="location"
                      placeholder="Ex: Parque da Cidade, Rua das Flores, 123"
                      value={formData.location}
                      onChange={(e) => handleChange("location", e.target.value)}
                      className="text-base h-12"
                      required
                    />
                  </div>

                  {/* Schedule */}
                  <div className="space-y-2">
                    <Label htmlFor="schedule" className="text-base">
                      <Calendar className="w-4 h-4 inline mr-2" />
                      Horários *
                    </Label>
                    <Input
                      id="schedule"
                      placeholder="Ex: Segunda e Quarta, 8h às 9h"
                      value={formData.schedule}
                      onChange={(e) => handleChange("schedule", e.target.value)}
                      className="text-base h-12"
                      required
                    />
                  </div>

                  {/* Max Students and Price */}
                  <div className="grid md:grid-cols-2 gap-4">
                    <div className="space-y-2">
                      <Label htmlFor="maxStudents" className="text-base">
                        <Users className="w-4 h-4 inline mr-2" />
                        Vagas Disponíveis
                      </Label>
                      <Input
                        id="maxStudents"
                        type="number"
                        placeholder="Ex: 15"
                        value={formData.maxStudents}
                        onChange={(e) => handleChange("maxStudents", e.target.value)}
                        className="text-base h-12"
                        min="1"
                      />
                    </div>

                    <div className="space-y-2">
                      <Label htmlFor="price" className="text-base">
                        <DollarSign className="w-4 h-4 inline mr-2" />
                        Valor Mensal (R$)
                      </Label>
                      <Input
                        id="price"
                        type="number"
                        placeholder="Ex: 120"
                        value={formData.price}
                        onChange={(e) => handleChange("price", e.target.value)}
                        className="text-base h-12"
                        min="0"
                        step="0.01"
                      />
                    </div>
                  </div>

                  {/* Submit Button */}
                  <Button type="submit" size="lg" className="w-full text-lg">
                    Cadastrar Aula
                  </Button>
                </form>
              </CardContent>
            </Card>
          </div>

          {/* Sidebar Info */}
          <div className="space-y-6">
            <Card className="shadow-soft">
              <CardHeader>
                <CardTitle>Dicas para o Sucesso</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4 text-sm">
                <div className="space-y-2">
                  <h4 className="font-semibold">📝 Título Atrativo</h4>
                  <p className="text-muted-foreground">
                    Use títulos claros que descrevam exatamente o tipo de atividade.
                  </p>
                </div>
                <div className="space-y-2">
                  <h4 className="font-semibold">📍 Localização Precisa</h4>
                  <p className="text-muted-foreground">
                    Forneça endereço completo para facilitar o encontro dos alunos.
                  </p>
                </div>
                <div className="space-y-2">
                  <h4 className="font-semibold">⏰ Horários Flexíveis</h4>
                  <p className="text-muted-foreground">
                    Ofereça opções de horários variados para atrair mais alunos.
                  </p>
                </div>
                <div className="space-y-2">
                  <h4 className="font-semibold">💰 Preço Justo</h4>
                  <p className="text-muted-foreground">
                    Pesquise valores praticados na sua região para ser competitivo.
                  </p>
                </div>
              </CardContent>
            </Card>

            <Card className="shadow-soft bg-accent">
              <CardContent className="p-6 space-y-4">
                <div className="text-center">
                  <div className="text-4xl font-bold text-primary">10%</div>
                  <div className="text-sm text-muted-foreground">Taxa da plataforma</div>
                </div>
                <p className="text-sm text-center text-muted-foreground">
                  Cobramos apenas quando você recebe um novo aluno. Sem taxas fixas!
                </p>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </div>
  );
};

export default CreateClass;

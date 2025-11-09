import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Header from "./components/Header";
import Index from "./pages/Index";
import SearchClasses from "./pages/SearchClasses";
import CreateClass from "./pages/CreateClass";
import Auth from "./pages/Auth";
import ProfessionalRegistration from "./pages/ProfessionalRegistration";
import Dashboard from "./pages/Dashboard";
import ClassManagement from "./pages/ClassManagement";
import Financial from "./pages/Financial";
import NotFound from "./pages/NotFound";

const queryClient = new QueryClient();

const App = () => (
  <QueryClientProvider client={queryClient}>
    <TooltipProvider>
      <Toaster />
      <Sonner />
      <BrowserRouter>
        <Header />
        <Routes>
          <Route path="/" element={<Index />} />
          <Route path="/buscar-aulas" element={<SearchClasses />} />
          <Route path="/cadastrar-aulas" element={<CreateClass />} />
          <Route path="/auth" element={<Auth />} />
          <Route
            path="/cadastro-profissional"
            element={<ProfessionalRegistration />}
          />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/turma/:id" element={<ClassManagement />} />
          <Route path="/financeiro" element={<Financial />} />
          {/* ADD ALL CUSTOM ROUTES ABOVE THE CATCH-ALL "*" ROUTE */}
          <Route path="*" element={<NotFound />} />
        </Routes>
      </BrowserRouter>
    </TooltipProvider>
  </QueryClientProvider>
);

export default App;

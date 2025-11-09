#!/bin/bash

echo "🔍 Verificando arquivos Swift no projeto..."
echo ""

# Listar todos os arquivos Swift
echo "📁 Arquivos Swift encontrados no sistema de arquivos:"
find FitSenior -name "*.swift" -type f | sort
echo ""

# Verificar arquivos novos que podem não estar no Xcode
echo "⚠️  Arquivos que podem precisar ser adicionados ao Xcode:"
echo ""

if [ -f "FitSenior/Services/LocationService.swift" ]; then
    echo "  ✅ FitSenior/Services/LocationService.swift"
else
    echo "  ❌ FitSenior/Services/LocationService.swift (NÃO ENCONTRADO)"
fi

if [ -f "FitSenior/Services/MockDataService.swift" ]; then
    echo "  ✅ FitSenior/Services/MockDataService.swift"
else
    echo "  ❌ FitSenior/Services/MockDataService.swift (NÃO ENCONTRADO)"
fi

if [ -f "FitSenior/Components/ClassImageView.swift" ]; then
    echo "  ✅ FitSenior/Components/ClassImageView.swift"
else
    echo "  ❌ FitSenior/Components/ClassImageView.swift (NÃO ENCONTRADO)"
fi

if [ -f "FitSenior/Extensions/Color+Theme.swift" ]; then
    echo "  ✅ FitSenior/Extensions/Color+Theme.swift"
else
    echo "  ❌ FitSenior/Extensions/Color+Theme.swift (NÃO ENCONTRADO)"
fi

echo ""
echo "📝 Próximos passos:"
echo "1. Abra o Xcode"
echo "2. Verifique se esses arquivos aparecem no Project Navigator"
echo "3. Se não aparecerem, adicione-os usando 'Add Files to FitSenior...'"
echo "4. Certifique-se de que o Target 'FitSenior' está marcado"
echo ""


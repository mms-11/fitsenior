# ✅ Imagens das Aulas Adicionadas

## 📸 O que foi feito:

Criei os Image Sets no `Assets.xcassets`:

1. ✅ `class-example-1.imageset/` - Contém `class-example-1.jpg`
2. ✅ `class-example-2.imageset/` - Contém `class-example-2.jpg`
3. ✅ `class-example-3.imageset/` - Contém `class-example-3.jpg`

## 🔧 Próximo Passo no Xcode:

**IMPORTANTE:** Você precisa adicionar esses Image Sets ao projeto Xcode:

### Opção 1: Adicionar via Xcode (Recomendado)

1. **Abra o Xcode**
2. **No Project Navigator**, encontre `FitSenior/Assets.xcassets`
3. **Clique com botão direito** em `Assets.xcassets`
4. Selecione **"Add Files to 'FitSenior'..."**
5. Navegue até: `FitSenior/Assets.xcassets/`
6. Selecione as 3 pastas:
   - `class-example-1.imageset`
   - `class-example-2.imageset`
   - `class-example-3.imageset`
7. **IMPORTANTE:**
   - ❌ **NÃO** marque "Copy items if needed"
   - ✅ Marque "Create folder references" (ou "Create groups")
   - ✅ Marque o target **"FitSenior"**
8. Clique em **"Add"**

### Opção 2: Recarregar no Xcode

1. **Feche o Xcode completamente**
2. **Reabra o projeto**
3. Os Image Sets devem aparecer automaticamente em `Assets.xcassets`

## ✅ Verificação:

Após adicionar:

1. **No Xcode**, você deve ver os Image Sets em:
   ```
   FitSenior/
   └── Assets.xcassets/
       ├── AppIcon.appiconset/
       ├── Logo.imageset/
       ├── class-example-1.imageset/ ✅
       ├── class-example-2.imageset/ ✅
       └── class-example-3.imageset/ ✅
   ```

2. **Compile o projeto** (⌘ + B)
3. **Execute o app** no simulador
4. **Navegue até as aulas** - as imagens devem aparecer!

## 🎯 Mapeamento das Imagens:

As aulas mockadas já estão configuradas para usar essas imagens:

- **Aula 1** (Ginástica ao Ar Livre) → `class-example-1`
- **Aula 2** (Yoga para Idosos) → `class-example-2`
- **Aula 3** (Musculação Adaptada) → `class-example-3`
- **Aula 4** (Caminhada em Grupo) → `class-example-1`
- **Aula 5** (Pilates Sênior) → `class-example-2`
- **Aula 6** (Hidroginástica) → `class-example-3`

## 🔍 Troubleshooting:

### Imagens não aparecem no Xcode
- Feche e reabra o Xcode
- Os Image Sets devem aparecer automaticamente

### Imagens não aparecem no app
- Verifique se os Image Sets estão no target "FitSenior"
- Limpe o build: Product → Clean Build Folder (⇧ + ⌘ + K)
- Recompile: Product → Build (⌘ + B)

### Erro "Cannot find image"
- Verifique se o nome no código (`"class-example-1"`) corresponde ao nome do Image Set
- Certifique-se de que o Image Set está incluído no target


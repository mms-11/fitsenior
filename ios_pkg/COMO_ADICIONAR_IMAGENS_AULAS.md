# 📸 Como Adicionar Imagens das Aulas ao Projeto iOS

## 🎯 Objetivo
Adicionar as imagens `class-example-1.jpg`, `class-example-2.jpg` e `class-example-3.jpg` ao projeto iOS para que apareçam nas aulas mockadas.

## 📋 Método 1: Via Xcode (Recomendado)

### Passo 1: Preparar as Imagens
1. As imagens já existem em: `src/assets/`
   - `class-example-1.jpg`
   - `class-example-2.jpg`
   - `class-example-3.jpg`

### Passo 2: Adicionar ao Assets.xcassets no Xcode

Para cada imagem (`class-example-1`, `class-example-2`, `class-example-3`):

1. **Abra o Xcode**
2. **No Project Navigator**, encontre `FitSenior/Assets.xcassets`
3. **Clique com botão direito** em `Assets.xcassets`
4. Selecione **"New Image Set"**
5. **Renomeie** para:
   - `class-example-1` (para a primeira imagem)
   - `class-example-2` (para a segunda imagem)
   - `class-example-3` (para a terceira imagem)

6. **Para cada Image Set:**
   - Selecione o Image Set criado
   - No **Attributes Inspector** (painel direito):
     - **Render As**: "Original Image"
     - **Resizing**: "Preserve Vector Data" (se aplicável)
   
7. **Arraste a imagem correspondente:**
   - Para `class-example-1`: arraste `src/assets/class-example-1.jpg` para o slot "1x" ou "Universal"
   - Para `class-example-2`: arraste `src/assets/class-example-2.jpg` para o slot "1x" ou "Universal"
   - Para `class-example-3`: arraste `src/assets/class-example-3.jpg` para o slot "1x" ou "Universal"

### Passo 3: Verificar
- As imagens devem aparecer no Project Navigator dentro de `Assets.xcassets`
- Os nomes devem ser exatamente: `class-example-1`, `class-example-2`, `class-example-3`

## 📋 Método 2: Manualmente (Criando os Image Sets)

Se preferir criar manualmente, siga a estrutura do `Logo.imageset`:

1. Crie as pastas:
   - `FitSenior/Assets.xcassets/class-example-1.imageset/`
   - `FitSenior/Assets.xcassets/class-example-2.imageset/`
   - `FitSenior/Assets.xcassets/class-example-3.imageset/`

2. Copie as imagens para cada pasta

3. Crie o `Contents.json` em cada pasta (veja exemplo abaixo)

## ✅ Verificação

Após adicionar as imagens:

1. **Compile o projeto** (⌘ + B)
2. **Execute o app** no simulador
3. **Navegue até a tela de aulas**
4. As imagens devem aparecer nos cards das aulas

## 🔍 Troubleshooting

### Imagens não aparecem
- Verifique se os nomes estão corretos: `class-example-1`, `class-example-2`, `class-example-3`
- Certifique-se de que as imagens estão no formato correto (JPG/PNG)
- Limpe o build: Product → Clean Build Folder (⇧ + ⌘ + K)

### Erro "Cannot find image"
- Verifique se o Image Set está no `Assets.xcassets`
- Verifique se o nome no código corresponde ao nome do Image Set
- Certifique-se de que o Image Set está incluído no target "FitSenior"

## 📝 Nota

As aulas mockadas já estão configuradas para usar essas imagens:
- Aula 1, 4: `class-example-1`
- Aula 2, 5: `class-example-2`
- Aula 3, 6: `class-example-3`


# Verificador de Casos de COVID-19 por País

Este projeto foi desenvolvido como parte de uma avaliação técnica para demonstrar habilidades no desenvolvimento de aplicações em Delphi com integração a APIs REST. A aplicação consome dados da API pública de COVID-19 disponível em [COVID-19 Brazil API Docs](https://covid19-brazil-api-docs.vercel.app/) e exibe informações sobre casos de COVID-19 por país, incluindo casos confirmados, mortes e recuperados.

## Funcionalidades

### Interface Gráfica Intuitiva
- Exibição de dados em um grid estruturado, permitindo fácil leitura.
- Exibição dos campos principais: **nome do país**, **casos confirmados**, **mortes** e **recuperados**.

### Atualização dos Dados em Tempo Real
- A cada atualização, uma nova requisição é feita à API para garantir a veracidade e atualidade dos dados.
- Caso a API fosse paga ou limitada, seria necessário implementar um sistema de cache para reduzir o número de requisições e otimizar custos.

### Filtros e Ordenação
- Filtro por **nome do país**, com busca case-insensitive.
- Ordenação dinâmica por número de **casos confirmados**, **mortes** ou **recuperados**, oferecendo flexibilidade ao usuário.

### Tratamento de Erros
- Mensagens amigáveis para problemas de conexão ou respostas inválidas da API.

### Documentação e Comentários
- Código detalhadamente comentado para fácil entendimento.
- Este README inclui instruções básicas de uso e dependências.

## Como Usar

### Configuração
1. Certifique-se de ter uma conexão ativa com a internet para acessar a API.
2. Abra o projeto no Delphi e compile-o.

### Navegação
- A interface principal exibe os dados dos países no grid.
- Use o campo de busca para filtrar países por nome.
- Utilize o **RadioGroup** para ordenar os dados conforme preferir (**casos confirmados**, **mortes**, **recuperados**).

### Atualização dos Dados
- Clique no botão **"Buscar"** para realizar uma nova requisição e garantir que os dados estejam atualizados.

## Dependências
- **Delphi RAD Studio**: Ferramenta de desenvolvimento.
- **RESTRequest4Delphi**: Biblioteca para integração com APIs REST.
- **FireDAC**: Para manipulação de dados em memória (TFDMemTable).

## Observação
Este projeto demonstra o consumo de uma API aberta com foco em atualização constante. Caso a API fosse paga ou houvesse restrições, seria necessário implementar um sistema de cache ou validação do tempo da última requisição para reduzir o número de acessos.

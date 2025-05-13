Mãos Limpas 🧼

  Descrição •
  Funcionalidades •
  Tecnologias •
  Arquitetura •
  Instalação •
  Contribuição •
  Licença


📋 Descrição
Mãos Limpas é um aplicativo móvel desenvolvido em Flutter para auditoria de higienização das mãos em ambientes hospitalares. A aplicação permite o registro e acompanhamento de oportunidades de higienização, contribuindo para a melhoria dos protocolos de segurança e prevenção de infecções hospitalares.
✨ Funcionalidades

🔐 Autenticação segura - Sistema de login para controle de acesso
📊 Dashboard intuitivo - Visualização rápida de dados e métricas
🏥 Cadastros básicos - Gerenciamento de Setores, Turnos e Cargos
📝 Auditoria simplificada - Seleção de Setor e Turno para iniciar auditoria
🌐 Sincronização - Integração com API para envio e recebimento de dados
📱 Design responsivo - Interface adaptável a diferentes tamanhos de tela
🌍 Internacionalização - Estrutura preparada para múltiplos idiomas
💾 Armazenamento local - Funcionamento offline com SQLite

🛠️ Tecnologias

Flutter - Framework UI multiplataforma
Dart - Linguagem de programação
BLoC - Gerenciamento de estado
SQLite - Banco de dados local
Get_it - Injeção de dependência
UUID - Geração de identificadores únicos
Go Router - Navegação e roteamento

🏗️ Arquitetura
O projeto segue os princípios da Clean Architecture, organizado em camadas:
lib/
├── core/            # Utilitários e configurações globais
│   ├── routes/      # Configuração de rotas
│   └── utils/       # Funções utilitárias
├── data/            # Camada de dados
│   ├── datasources/ # Fontes de dados (local e remota)
│   ├── models/      # Modelos de dados
│   └── repositories/# Implementações de repositórios
├── di/              # Injeção de dependência
├── domain/          # Regras de negócio
│   ├── entities/    # Entidades de domínio
│   ├── repositories/# Interfaces de repositórios
│   └── usecases/    # Casos de uso
└── presentation/    # Interface do usuário
    ├── bloc/        # Gerenciamento de estado
    ├── pages/       # Telas do aplicativo
    └── widgets/     # Componentes reutilizáveis

📥 Instalação

Pré-requisitos

Flutter SDK (versão 3.0.0 ou superior)
Dart SDK (versão 2.17.0 ou superior)
Android Studio / VS Code com extensões Flutter e Dart


Clone o repositório
git clone https://github.com/seu-usuario/maos-limpas.git
cd maos-limpas


Instale as dependências
flutter pub get


Execute o aplicativo
flutter run



🤝 Contribuição
Contribuições são bem-vindas! Siga estes passos:

Faça um fork do projeto
Crie uma branch para sua featuregit checkout -b feature/nova-funcionalidade


Commit suas mudançasgit commit -m 'Adiciona nova funcionalidade'


Faça push para a branchgit push origin feature/nova-funcionalidade


Abra um Pull Request

📄 Licença
Este projeto está sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.


  Desenvolvido com ❤️ pela equipe Mãos Limpas

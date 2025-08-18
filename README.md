Loja de Carros — Banco de Dados 

Loja de Carros
Sistema de Gerenciamento de Concessionária

Descrição do Projeto

Este trabalho tem como objetivo criar um banco de dados para uma loja de carros.
O sistema foi pensado para organizar e controlar informações importantes, como:

Estoque de veículos e acessórios.
Cadastro de clientes e vendas realizadas.
Registro de parcelas e formas de pagamento.
Relatórios sobre vendas e desempenho da loja.
Com ele, é possível saber exatamente quais veículos estão disponíveis, quais já foram vendidos, e manter o histórico de cada cliente e compra.

Entidades e Relacionamentos

O banco de dados foi feito para evitar informações repetidas e manter a organização. Ele é composto por:

tb_clientes → Guarda os dados dos clientes (CPF único, telefone, endereço).
tb_marcas → Lista as marcas dos veículos.
tb_modelos → Modelos dos carros, ligados a uma marca.
tb_veiculos → Informações do carro (chassi, ano, cor, valor e status).
tb_acessorios → Lista de acessórios que podem ser vendidos com o carro.
tb_veiculo_acessorio → Liga veículos e acessórios (relação de muitos para muitos).
tb_vendas → Registro das vendas, ligando cliente e veículo.
tb_parcelas → Detalhes dos pagamentos de cada venda.

Regras importantes:

Um veículo só pode ser vendido uma vez.
Cada chassi é único.

As relações entre veículos e acessórios são feitas por uma tabela intermediária.
Chaves estrangeiras mantêm a integridade dos dados.
![consultas 01](https://github.com/user-attachments/assets/4424cb35-f0db-4bdb-954c-cf2eed47e106)
![consultas 02](https://github.com/user-attachments/assets/33f92879-b8f6-4e60-a13d-b3aa9794768d)
![consultas 03](https://github.com/user-attachments/assets/1a541efb-e4a7-4243-ad46-bdf9bda23f4a)




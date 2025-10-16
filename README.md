# 🏆 Projeto_Copa_DataBase

> Um banco de dados relacional para manipulação, consulta e análise de dados relacionados à Copa do Mundo.

---

## 🧭 Sumário

- [Visão Geral](#visão-geral)  
- [Funcionalidades](#funcionalidades)  
- [Arquitetura / Modelagem](#arquitetura--modelagem)  
- [Como Utilizar](#como-utilizar)  
  - [Pré-requisitos](#pré-requisitos)  
  - [Instalação / Execução](#instalação--execução)  
- [Scripts e Estrutura](#scripts-e-estrutura)  
- [Exemplos de Consulta](#exemplos-de-consulta)  
- [Contribuição](#contribuição)  
- [Licença](#licença)  
- [Contato](#contato)  

---

## ⚽ Visão Geral

O **Projeto_Copa_DataBase** é uma base de dados construída em **SQL (PostgreSQL ou compatível)**, com o objetivo de centralizar informações referentes à **Copa do Mundo** (seleções, jogos, resultados, estádios, etc.).  
O repositório contém scripts para:

- criação do **schema** (tabelas, relacionamentos e constraints)  
- inserção de dados (povoamento)  
- consultas SQL para extração de insights  

Esse projeto é ideal tanto para estudo acadêmico quanto para servir de base em sistemas de gestão ou análise esportiva.

---

## 🚀 Funcionalidades

- Modelo relacional normalizado  
- Scripts automáticos de criação e povoamento  
- Consultas SQL de exemplo para análise de dados  
- Estrutura simples, didática e extensível  

---

## 🏗️ Arquitetura / Modelagem

O modelo contempla entidades como:

- **Seleção / País**  
- **Jogos / Partidas**  
- **Estádios**  
- **Fases / Etapas do torneio**  
- **Resultados / Gols**

As relações entre as entidades garantem **integridade referencial**, permitindo consultas complexas — como:

> “Quais seleções mais marcaram gols?”  
> “Quais países já se enfrentaram em finais?”  
> “Qual a média de gols por partida em uma edição da Copa?”

---

## 💻 Como Utilizar

### Pré-requisitos

- **PostgreSQL** (ou outro SGBD relacional)  
- Terminal SQL ou ferramenta gráfica (pgAdmin, DBeaver, etc.)  

### Instalação / Execução

1. Clone este repositório:

   ```bash
   git clone https://github.com/laisso/Projeto_Copa_DataBase.git
   cd Projeto_Copa_DataBase

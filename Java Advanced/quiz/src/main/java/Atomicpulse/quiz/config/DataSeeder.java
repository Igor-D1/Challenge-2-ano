package Atomicpulse.quiz.config;

import Atomicpulse.quiz.model.CategoriaPergunta;
import Atomicpulse.quiz.model.NivelDificuldade;
import Atomicpulse.quiz.model.Pergunta;
import Atomicpulse.quiz.repository.PerguntaRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class DataSeeder {

    @Bean
    CommandLineRunner initDatabase(PerguntaRepository repository) {
        return args -> {
            if (repository.count() == 0) {
                Pergunta q1 = Pergunta.builder()
                        .enunciado("Qual e a principal missao da empresa estatal AMazul?")
                        .opcaoA("Desenvolver tecnologias estrategicas para os programas nucleares da Marinha e do Brasil")
                        .opcaoB("Fabricar exclusivamente satelites comerciais")
                        .opcaoC("Gerenciar o transporte publico rodoviario nacional")
                        .opcaoD("Produzir paineis solares residenciais")
                        .respostaCorretaIndex(0)
                        .dificuldade(NivelDificuldade.FACIL)
                        .categoria(CategoriaPergunta.AMAZUL_E_MARINHA)
                        .build();

                Pergunta q2 = Pergunta.builder()
                        .enunciado("Qual e o principal beneficio da producao de radiofarmacos pela tecnologia nuclear?")
                        .opcaoA("Diagnostico precoce e tratamento do cancer na medicina nuclear")
                        .opcaoB("Aumento da velocidade de conexao de internet")
                        .opcaoC("Purificacao de combustiveis fosseis")
                        .opcaoD("Geracao de energia em baterias automotivas")
                        .respostaCorretaIndex(0)
                        .dificuldade(NivelDificuldade.FACIL)
                        .categoria(CategoriaPergunta.MEDICINA_NUCLEAR)
                        .build();

                Pergunta q3 = Pergunta.builder()
                        .enunciado("Qual e o nome do primeiro submarino de propulsao nuclear brasileiro do projeto PROSUB?")
                        .opcaoA("Submarino Alvaro Alberto (SN-BR)")
                        .opcaoB("Submarino Riachuelo")
                        .opcaoC("Submarino Humaita")
                        .opcaoD("Submarino Tonelero")
                        .respostaCorretaIndex(0)
                        .dificuldade(NivelDificuldade.MEDIO)
                        .categoria(CategoriaPergunta.SUBMARINO_ALVARO_ALBERTO)
                        .build();

                Pergunta q4 = Pergunta.builder()
                        .enunciado("Qual empreendimento nuclear garantira a autossuficiencia do Brasil na producao de radiofarmacos?")
                        .opcaoA("Reator Multiproposito Brasileiro (RMB)")
                        .opcaoB("Usina de Angra 1")
                        .opcaoC("Usina de Angra 2")
                        .opcaoD("Centro de Lancamento de Alcantara")
                        .respostaCorretaIndex(0)
                        .dificuldade(NivelDificuldade.MEDIO)
                        .categoria(CategoriaPergunta.MEDICINA_NUCLEAR)
                        .build();

                Pergunta q5 = Pergunta.builder()
                        .enunciado("Como a propulsao nuclear beneficia a autonomia de um submarino militar?")
                        .opcaoA("Permite imersao por periodos quase ilimitados sem necessitar de reabastecimento frequente")
                        .opcaoB("Aumenta a capacidade de transporte de passageiros civis")
                        .opcaoC("Elimina a necessidade de tripulacao treinada")
                        .opcaoD("Reduz o custo de construcao naval em 90%")
                        .respostaCorretaIndex(0)
                        .dificuldade(NivelDificuldade.DIFICIL)
                        .categoria(CategoriaPergunta.SUBMARINO_ALVARO_ALBERTO)
                        .build();

                repository.saveAll(List.of(q1, q2, q3, q4, q5));
                System.out.println(">>> SEEDING CONCLUIDO: 5 perguntas cadastradas com sucesso!");
            }
        };
    }
}
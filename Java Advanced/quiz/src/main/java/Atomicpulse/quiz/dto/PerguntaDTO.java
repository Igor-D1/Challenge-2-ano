package Atomicpulse.quiz.dto;

import Atomicpulse.quiz.model.CategoriaPergunta;
import Atomicpulse.quiz.model.NivelDificuldade;
import jakarta.validation.constraints.*;

public record PerguntaDTO(
        Long id,

        @NotBlank(message = "O enunciado da pergunta e obrigatorio.")
        @Size(min = 10, max = 500, message = "O enunciado deve conter entre 10 e 500 caracteres.")
        String enunciado,

        @NotBlank(message = "A Opcao A e obrigatoria.")
        @Size(max = 200, message = "A Opcao A deve ter no maximo 200 caracteres.")
        String opcaoA,

        @NotBlank(message = "A Opcao B e obrigatoria.")
        @Size(max = 200, message = "A Opcao B deve ter no maximo 200 caracteres.")
        String opcaoB,

        @NotBlank(message = "A Opcao C e obrigatoria.")
        @Size(max = 200, message = "A Opcao C deve ter no maximo 200 caracteres.")
        String opcaoC,

        @NotBlank(message = "A Opcao D e obrigatoria.")
        @Size(max = 200, message = "A Opcao D deve ter no maximo 200 caracteres.")
        String opcaoD,

        @NotNull(message = "O indice da resposta correta e obrigatorio.")
        @Min(value = 0, message = "O indice da resposta correta deve ser entre 0 e 3.")
        @Max(value = 3, message = "O indice da resposta correta deve ser entre 0 e 3.")
        Integer respostaCorretaIndex,

        @NotNull(message = "O nivel de dificuldade e obrigatorio.")
        NivelDificuldade dificuldade,

        @NotNull(message = "A categoria da pergunta e obrigatoria.")
        CategoriaPergunta categoria
) {}
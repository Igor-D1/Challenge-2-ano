package Atomicpulse.quiz.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "TB_AP_PERGUNTA")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Pergunta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 500)
    private String enunciado;

    @Column(nullable = false, length = 200)
    private String opcaoA;

    @Column(nullable = false, length = 200)
    private String opcaoB;

    @Column(nullable = false, length = 200)
    private String opcaoC;

    @Column(nullable = false, length = 200)
    private String opcaoD;

    @Column(nullable = false)
    private Integer respostaCorretaIndex;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private NivelDificuldade dificuldade;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 40)
    private CategoriaPergunta categoria;

    @Column(nullable = false, updatable = false)
    private LocalDateTime dataCriacao;

    @PrePersist
    protected void onCreate() {
        this.dataCriacao = LocalDateTime.now();
    }
}

package Atomicpulse.quiz.repository;

import Atomicpulse.quiz.model.CategoriaPergunta;
import Atomicpulse.quiz.model.NivelDificuldade;
import Atomicpulse.quiz.model.Pergunta;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PerguntaRepository extends JpaRepository<Pergunta, Long> {

    List<Pergunta> findByEnunciadoContainingIgnoreCase(String termo);

    List<Pergunta> findByDificuldade(NivelDificuldade dificuldade);

    List<Pergunta> findByCategoria(CategoriaPergunta categoria);
}
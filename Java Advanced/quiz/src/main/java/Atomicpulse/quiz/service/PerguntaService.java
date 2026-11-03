package Atomicpulse.quiz.service;

import Atomicpulse.quiz.dto.PerguntaDTO;
import Atomicpulse.quiz.exception.ResourceNotFoundException;
import Atomicpulse.quiz.model.CategoriaPergunta;
import Atomicpulse.quiz.model.NivelDificuldade;
import Atomicpulse.quiz.model.Pergunta;
import Atomicpulse.quiz.repository.PerguntaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PerguntaService {

    private final PerguntaRepository repository;

    @Transactional(readOnly = true)
    public List<PerguntaDTO> listarTodas() {
        return repository.findAll().stream()
                .map(this::toDTO)
                .toList();
    }

    @Transactional(readOnly = true)
    public PerguntaDTO buscarPorId(Long id) {
        Pergunta pergunta = repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Pergunta nao encontrada com ID: " + id));
        return toDTO(pergunta);
    }

    @Transactional(readOnly = true)
    public List<PerguntaDTO> buscarPorTexto(String termo) {
        return repository.findByEnunciadoContainingIgnoreCase(termo).stream()
                .map(this::toDTO)
                .toList();
    }

    @Transactional(readOnly = true)
    public List<PerguntaDTO> buscarPorDificuldade(NivelDificuldade dificuldade) {
        return repository.findByDificuldade(dificuldade).stream()
                .map(this::toDTO)
                .toList();
    }

    @Transactional
    public PerguntaDTO criar(PerguntaDTO dto) {
        Pergunta pergunta = toEntity(dto);
        pergunta.setId(null);
        Pergunta salva = repository.save(pergunta);
        return toDTO(salva);
    }

    @Transactional
    public PerguntaDTO atualizar(Long id, PerguntaDTO dto) {
        Pergunta existente = repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Pergunta nao encontrada com ID: " + id));

        existente.setEnunciado(dto.enunciado());
        existente.setOpcaoA(dto.opcaoA());
        existente.setOpcaoB(dto.opcaoB());
        existente.setOpcaoC(dto.opcaoC());
        existente.setOpcaoD(dto.opcaoD());
        existente.setRespostaCorretaIndex(dto.respostaCorretaIndex());
        existente.setDificuldade(dto.dificuldade());
        existente.setCategoria(dto.categoria());

        Pergunta atualizada = repository.save(existente);
        return toDTO(atualizada);
    }

    @Transactional
    public void deletar(Long id) {
        if (!repository.existsById(id)) {
            throw new ResourceNotFoundException("Pergunta nao encontrada com ID: " + id);
        }
        repository.deleteById(id);
    }

    private PerguntaDTO toDTO(Pergunta entity) {
        return new PerguntaDTO(
                entity.getId(),
                entity.getEnunciado(),
                entity.getOpcaoA(),
                entity.getOpcaoB(),
                entity.getOpcaoC(),
                entity.getOpcaoD(),
                entity.getRespostaCorretaIndex(),
                entity.getDificuldade(),
                entity.getCategoria()
        );
    }

    private Pergunta toEntity(PerguntaDTO dto) {
        return Pergunta.builder()
                .id(dto.id())
                .enunciado(dto.enunciado())
                .opcaoA(dto.opcaoA())
                .opcaoB(dto.opcaoB())
                .opcaoC(dto.opcaoC())
                .opcaoD(dto.opcaoD())
                .respostaCorretaIndex(dto.respostaCorretaIndex())
                .dificuldade(dto.dificuldade())
                .categoria(dto.categoria())
                .build();
    }
}

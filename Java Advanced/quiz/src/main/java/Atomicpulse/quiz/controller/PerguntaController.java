package Atomicpulse.quiz.controller;

import Atomicpulse.quiz.dto.PerguntaDTO;
import Atomicpulse.quiz.model.NivelDificuldade;
import Atomicpulse.quiz.service.PerguntaService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/perguntas")
@RequiredArgsConstructor
@Tag(name = "Perguntas do Quiz", description = "Endpoints RESTful para gerenciamento das perguntas do AtomicPulse")
public class PerguntaController {

    private final PerguntaService service;

    @GetMapping
    @Operation(summary = "Listar todas as perguntas")
    public ResponseEntity<List<PerguntaDTO>> listarTodas() {
        return ResponseEntity.ok(service.listarTodas());
    }

    @GetMapping("/{id}")
    @Operation(summary = "Buscar pergunta por ID")
    public ResponseEntity<PerguntaDTO> buscarPorId(@PathVariable Long id) {
        return ResponseEntity.ok(service.buscarPorId(id));
    }

    @GetMapping("/busca")
    @Operation(summary = "Busca por texto no enunciado (Query Method)")
    public ResponseEntity<List<PerguntaDTO>> buscarPorTexto(@RequestParam String termo) {
        return ResponseEntity.ok(service.buscarPorTexto(termo));
    }

    @GetMapping("/dificuldade/{dificuldade}")
    @Operation(summary = "Buscar por nivel de dificuldade")
    public ResponseEntity<List<PerguntaDTO>> buscarPorDificuldade(@PathVariable NivelDificuldade dificuldade) {
        return ResponseEntity.ok(service.buscarPorDificuldade(dificuldade));
    }

    @PostMapping
    @Operation(summary = "Cadastrar nova pergunta com validacao")
    public ResponseEntity<PerguntaDTO> criar(@Valid @RequestBody PerguntaDTO dto) {
        return ResponseEntity.status(HttpStatus.CREATED).body(service.criar(dto));
    }

    @PutMapping("/{id}")
    @Operation(summary = "Atualizar pergunta existente")
    public ResponseEntity<PerguntaDTO> atualizar(@PathVariable Long id, @Valid @RequestBody PerguntaDTO dto) {
        return ResponseEntity.ok(service.atualizar(id, dto));
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Deletar pergunta por ID")
    public ResponseEntity<Void> deletar(@PathVariable Long id) {
        service.deletar(id);
        return ResponseEntity.noContent().build();
    }
}

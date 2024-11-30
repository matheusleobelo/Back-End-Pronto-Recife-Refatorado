package com.start.pronto_recife.Repositories;

import com.start.pronto_recife.Models.PacienteModel;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import javax.swing.*;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface PacienteRepository extends JpaRepository<PacienteModel, String> {
    Optional<PacienteModel> findByCPF(@NotBlank @Pattern(regexp = "\\d{11}") String CPF);
    List<PacienteModel> findByResponsavelCpf(String CPF);

}
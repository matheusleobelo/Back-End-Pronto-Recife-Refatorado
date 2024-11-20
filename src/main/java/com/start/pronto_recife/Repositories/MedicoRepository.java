package com.start.pronto_recife.Repositories;

import com.start.pronto_recife.Models.MedicoModel;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface MedicoRepository extends JpaRepository<MedicoModel, String>  {
    Optional<MedicoModel> findByCRM(String CRM);
    @Transactional
    void deleteByCRM(String CRM);
}

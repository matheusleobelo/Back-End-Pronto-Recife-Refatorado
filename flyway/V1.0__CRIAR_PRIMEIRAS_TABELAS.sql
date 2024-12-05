CREATE SCHEMA IF NOT EXISTS `prontorecife` DEFAULT CHARACTER SET utf8;
USE `prontorecife`;

-- Tabela Laudos
CREATE TABLE IF NOT EXISTS `laudos` (
                                        `id` CHAR(36) NOT NULL DEFAULT (UUID()),
    `descricao` TEXT NULL DEFAULT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;

-- Tabela Responsável
CREATE TABLE IF NOT EXISTS `responsavel` (
                                             `id` CHAR(36) DEFAULT (UUID()),
    `nome_completo` VARCHAR(100) NULL,
    `grau_parentesco` VARCHAR(45) NULL,
    `endereco` VARCHAR(255) NULL,
    `telefone` VARCHAR(15) NULL,
    `email` VARCHAR(50) UNIQUE NULL,
    `cpf` VARCHAR(14) UNIQUE NULL,
    `data_nascimento` DATE NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `email_UNIQUE` (`email` ASC),
    UNIQUE INDEX `idx_cpf` (`cpf`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

-- Tabela Paciente
CREATE TABLE IF NOT EXISTS `paciente` (
                                          `id` CHAR(36) NOT NULL DEFAULT (UUID()),
    `nome_completo` VARCHAR(100) NOT NULL,
    `estado_civil` VARCHAR(50) NULL DEFAULT NULL,
    `cpf` VARCHAR(14) NOT NULL,
    `data_nascimento` DATE NULL DEFAULT NULL,
    `genero` VARCHAR(10) NULL DEFAULT NULL,
    `email` VARCHAR(100) NOT NULL,
    `senha` VARCHAR(255) NOT NULL,
    `telefone` VARCHAR(15) NULL DEFAULT NULL,
    `contato_representante` VARCHAR(15) NULL DEFAULT NULL,
    `endereco` VARCHAR(255) NULL DEFAULT NULL,
    `responsavel_cpf` VARCHAR(14) NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `cpf` (`cpf` ASC),
    UNIQUE INDEX `email` (`email` ASC),
    INDEX `fk_paciente_responsavel` (`responsavel_cpf` ASC),
    CONSTRAINT `fk_paciente_responsavel`
    FOREIGN KEY (`responsavel_cpf`)
    REFERENCES `responsavel` (`cpf`)
    ) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;

-- Tabela Médico
CREATE TABLE IF NOT EXISTS `medico` (
                                        `id` CHAR(36) NOT NULL DEFAULT (UUID()),
    `crm` VARCHAR(15) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `senha` VARCHAR(255) NOT NULL,
    `nome_completo` VARCHAR(100) NOT NULL,
    `telefone` VARCHAR(15) NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `crm` (`crm` ASC),
    UNIQUE INDEX `email` (`email` ASC)
    ) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;

-- Tabela Consulta
CREATE TABLE IF NOT EXISTS `consulta` (
                                          `id` CHAR(36) NOT NULL DEFAULT (UUID()),
    `data_consulta` DATE NOT NULL,
    `tratamentos_prescritos` TEXT NOT NULL,
    `instrucoes_recomendacoes` TEXT NOT NULL,
    `sintomas` TEXT NOT NULL,
    `historico_familiar` VARCHAR(255) NULL DEFAULT NULL,
    `paciente_id` CHAR(36) NOT NULL,
    `laudos_id` CHAR(36) NULL DEFAULT NULL,
    `medico_id` CHAR(36) NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_consulta_paciente` (`paciente_id` ASC),
    INDEX `fk_consulta_laudos` (`laudos_id` ASC),
    INDEX `fk_consulta_medico` (`medico_id` ASC),
    CONSTRAINT `fk_consulta_laudos`
    FOREIGN KEY (`laudos_id`)
    REFERENCES `laudos` (`id`),
    CONSTRAINT `fk_consulta_paciente`
    FOREIGN KEY (`paciente_id`)
    REFERENCES `paciente` (`id`),
    CONSTRAINT `fk_consulta_medico`
    FOREIGN KEY (`medico_id`)
    REFERENCES `medico` (`id`)
    ) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;

-- Tabela Exame do Paciente
CREATE TABLE IF NOT EXISTS `exame_do_paciente` (
                                                   `id` CHAR(36) NOT NULL DEFAULT (UUID()),
    `data_exame` DATE NOT NULL,
    `resultado` TEXT NOT NULL,
    `nome_do_exame` VARCHAR(100) NOT NULL,
    `paciente_cpf` VARCHAR(14) NOT NULL,
    `consulta_id` CHAR(36) NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_exame_consulta` (`consulta_id` ASC),
    CONSTRAINT `fk_exame_consulta`
    FOREIGN KEY (`consulta_id`)
    REFERENCES `consulta` (`id`),
    CONSTRAINT `fk_exame_paciente`
    FOREIGN KEY (`paciente_cpf`)
    REFERENCES `paciente` (`cpf`)
    ) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;

-- Tabela Histórico Médico
CREATE TABLE IF NOT EXISTS `historico_medico` (
                                                  `id` CHAR(36) NOT NULL DEFAULT (UUID()),
    `cirurgias_anteriores` TEXT NULL DEFAULT NULL,
    `condicoes_gerais` VARCHAR(255) NULL DEFAULT NULL,
    `paciente_id` CHAR(36) NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_historico_paciente` (`paciente_id` ASC),
    CONSTRAINT `fk_historico_paciente`
    FOREIGN KEY (`paciente_id`)
    REFERENCES `paciente` (`id`)
    ) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;

-- Tabela Estabelecimento
CREATE TABLE IF NOT EXISTS `estabelecimento` (
                                                 `id` CHAR(36) NOT NULL DEFAULT (UUID()),
    `cnpj` VARCHAR(18) NOT NULL,
    `nome` VARCHAR(255) NOT NULL,
    `endereco` VARCHAR(255) NULL DEFAULT NULL,
    `telefone` VARCHAR(15) NULL DEFAULT NULL,
    `email` VARCHAR(255) NOT NULL,
    `senha` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `cnpj` (`cnpj` ASC),
    UNIQUE INDEX `email` (`email` ASC)
    ) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;

-- Tabelas para relacionamentos
CREATE TABLE IF NOT EXISTS `estabelecimento_para_medicos` (
                                                              `estabelecimento_id` CHAR(36) NOT NULL,
    `medico_id` CHAR(36) NOT NULL,
    PRIMARY KEY (`estabelecimento_id`, `medico_id`),
    FOREIGN KEY (`estabelecimento_id`) REFERENCES `estabelecimento` (`id`),
    FOREIGN KEY (`medico_id`) REFERENCES `medico` (`id`)
    ) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;

CREATE TABLE IF NOT EXISTS `estabelecimento_para_profissionais` (
                                                                    `estabelecimento_id` CHAR(36) NOT NULL,
    `profissional_saude_id` CHAR(36) NOT NULL,
    PRIMARY KEY (`estabelecimento_id`, `profissional_saude_id`),
    FOREIGN KEY (`estabelecimento_id`) REFERENCES `estabelecimento` (`id`)
    ) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;

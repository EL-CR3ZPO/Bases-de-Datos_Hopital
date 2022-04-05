CREATE TABLE persona
(
    id_persona   SERIAL,
    nombre       VARCHAR(30),
    paterno      VARCHAR(30),
    materno      VARCHAR(30),
    correo       VARCHAR(40),
    nacimiento   DATE,
    telefono     INTEGER,
    id_genero    INTEGER,
    id_direccion INTEGER,
    PRIMARY KEY (id_persona),
    FOREIGN KEY (id_genero) REFERENCES cgenero(id_genero),
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)

);

CREATE TABLE cestado(
    id_estado                   SERIAL,
    estado                      VARCHAR(20),
    PRIMARY KEY (id_estado)
);

CREATE TABLE cmunicipio(
    id_municipio                SERIAL,
    municipio                   VARCHAR(30),
    id_estado                   INTEGER,
    PRIMARY KEY (id_municipio),
    FOREIGN KEY (id_estado) REFERENCES cestado(id_estado)
);

CREATE TABLE direccion(
    id_direccion                SERIAL,
    calle                       VARCHAR(30),
    cpostal                     VARCHAR(5),
    numerocalle                 INTEGER,
    id_municipio                INTEGER,
    PRIMARY KEY (id_direccion),
    FOREIGN KEY (id_municipio) REFERENCES cmunicipio(id_municipio)

);

CREATE TABLE personal(
    id_personal                 SERIAL,
    rfc                         VARCHAR(13),
    cedula                      VARCHAR(20),
    sueldo                      NUMERIC,
    id_persona                  INTEGER,
    id_tipopersonal             INTEGER,
    PRIMARY KEY (id_persona),
    FOREIGN KEY (id_persona) REFERENCES persona(id_persona),
    FOREIGN KEY (id_tipopersonal) REFERENCES ctipopersonal(id_tipopersonal)
);

CREATE TABLE especialista(
    id_especialista             SERIAL,
    id_universidad              INTEGER,
    id_personal                 INTEGER,
    PRIMARY KEY (id_especialista),
    FOREIGN KEY (id_universidad) REFERENCES cuniversidad(id_universidad),
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
);

CREATE TABLE especialidad(
    id_especialidad             SERIAL,
    especialidad                VARCHAR(30),
    PRIMARY KEY (id_especialidad)
);

CREATE TABLE cuniversidad(
    id_universidad              SERIAL,
    universidad                 VARCHAR(40),
    PRIMARY KEY (id_universidad)
);

CREATE TABLE paciente(
    id_paciente                 SERIAL,
    curp                        VARCHAR(18),
    id_persona                  INTEGER,
    id_tiposangre               INTEGER,
    PRIMARY KEY (id_paciente),
    FOREIGN KEY (id_persona) REFERENCES persona(id_persona),
    FOREIGN KEY (id_tiposangre) REFERENCES ctiposangre(id_tiposangre)
);

CREATE TABLE ctiposangre(
    id_tiposangre               SERIAL,
    tiposangre                  VARCHAR(3),
    PRIMARY KEY(id_tiposangre)
);

CREATE TABLE cgenero(
    id_genero                   SERIAL,
    etiqueta                    VARCHAR(20),
    PRIMARY KEY (id_genero)
);

CREATE TABLE calergia_paciente(
    id_alergia_paciente         SERIAL,
    id_alergia                  INTEGER,
    id_paciente                 INTEGER,
    PRIMARY KEY (id_alergia_paciente),
    FOREIGN KEY (id_alergia) REFERENCES calergia(id_alergia),
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente)
);

CREATE TABLE calergia (
    id_alergia                  SERIAL,
    alergia                     VARCHAR(30),
    PRIMARY KEY (id_alergia)
);

CREATE TABLE medicamento(
    id_medicamento              SERIAL,
    medicamento                 VARCHAR(50),
    PRIMARY KEY (id_medicamento)
);

CREATE TABLE medicamento_receta(
    id_medicamento_receta       SERIAL,
    id_medicamento              INTEGER,
    id_receta                   INTEGER,
    cantidad                    INTEGER,
    PRIMARY KEY (id_medicamento_receta),
    FOREIGN KEY (id_medicamento) REFERENCES medicamento(id_medicamento),
    FOREIGN KEY (id_receta) REFERENCES recetamedica(id_receta)
);

CREATE TABLE medicamento_venta(
    id_medicamento_venta        SERIAL,
    id_medicamento              INTEGER,
    id_venta                    INTEGER,
    PRIMARY KEY (id_medicamento_venta),
    FOREIGN KEY (id_medicamento) REFERENCES medicamento(id_medicamento),
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta)
);

CREATE TABLE medicamento_almacen(
    id_medicamento_almacen      SERIAL,
    id_medicamento              INTEGER,
    id_almacen                  INTEGER,
    id_venta_almacen            INTEGER,
    cantidad                    INTEGER,
    PRIMARY KEY (id_medicamento_almacen),
    FOREIGN KEY (id_medicamento) REFERENCES medicamento(id_medicamento),
    FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen),
    FOREIGN KEY (id_venta_almacen) REFERENCES venta_almacen(id_venta_almacen)
);

CREATE TABLE venta_receta(
    id_venta_receta             SERIAL,
    id_venta                    INTEGER,
    id_receta                   INTEGER,
    PRIMARY KEY (id_venta_receta),
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
    FOREIGN KEY (id_receta) REFERENCES recetamedica(id_receta)
);

CREATE TABLE personal_venta(
    id_personal_venta           SERIAL,
    id_personal                 INTEGER,
    id_venta                    INTEGER,
    PRIMARY KEY (id_personal_venta),
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta)
);

CREATE TABLE persona_venta(
    id_persona_venta            SERIAL,
    id_persona                  INTEGER,
    id_venta                    INTEGER,
    PRIMARY KEY (id_persona_venta),
    FOREIGN KEY (id_persona) REFERENCES persona(id_persona),
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta)

);

CREATE TABLE venta(
    id_venta                    SERIAL,
    fecha                       DATE,
    costo                       NUMERIC,
    hora                        TIME,
    PRIMARY KEY (id_venta)
);

CREATE TABLE venta_almacen(
    id_venta_almacen            SERIAL,
    id_venta                    INTEGER,
    id_almacen                  INTEGER,
    PRIMARY KEY (id_venta_almacen),
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
    FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen)
);

CREATE TABLE almacen(
    id_almacen                  SERIAL,
    snombrealmacen              VARCHAR(40),
    PRIMARY KEY (id_almacen)

);

CREATE TABLE ctipopersonal(
    id_tipopersonal             SERIAL,
    tpersonal                   VARCHAR(15),
    id_especialidad             INTEGER,
    PRIMARY KEY (id_tipopersonal),
    FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad)
);

CREATE TABLE alta(
    id_alta                     SERIAL,
    fechaegreso                 DATE,
    PRIMARY KEY (id_alta)
);

CREATE TABLE ingreso_cmotivo(
    id_ingreso_motivo       SERIAL,
    id_ingreso              INTEGER,
    id_motivo               INTEGER,
    PRIMARY KEY (id_ingreso_motivo),
    FOREIGN KEY (id_ingreso) REFERENCES ingreso(id_ingreso),
    FOREIGN KEY (id_motivo) REFERENCES cmotivo(id_motivo)
);

CREATE TABLE cmotivo(
    id_motivo                   SERIAL,
    motivo                      VARCHAR(50),
    PRIMARY KEY (id_motivo)
);

CREATE TABLE personal_ingreso(
    id_personal_ingreso         SERIAL,
    id_personal                 INTEGER,
    id_ingreso                  INTEGER,
    PRIMARY KEY (id_personal_ingreso),
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal),
    FOREIGN KEY (id_ingreso) REFERENCES ingreso(id_ingreso)
);

CREATE TABLE paciente_ingreso(
    id_paciente_ingreso         SERIAL,
    id_paciente                 INTEGER,
    id_ingreso                  INTEGER,
    PRIMARY KEY (id_paciente_ingreso),
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    FOREIGN KEY (id_ingreso) REFERENCES ingreso(id_ingreso)
);

CREATE TABLE ingreso(
    id_ingreso                  SERIAL,
    fechaingreso                DATE,
    preciopd                    NUMERIC,
    diagnostico                 TEXT,
    id_alta                     INTEGER,
    PRIMARY KEY (id_ingreso),
    FOREIGN KEY (id_alta) REFERENCES alta(id_alta)
);

CREATE TABLE ingreso_ccama(
    id_ingreso_cama             SERIAL,
    id_ingreso                  INTEGER,
    id_cama                     INTEGER,
    PRIMARY KEY (id_ingreso_cama),
    FOREIGN KEY (id_ingreso) REFERENCES ingreso(id_ingreso),
    FOREIGN KEY (id_cama) REFERENCES ccama(id_cama)
);

CREATE TABLE ccama(
    id_cama                     SERIAL,
    tipocama                    VARCHAR(10),
    numcama                     INTEGER,
    PRIMARY KEY (id_cama)
);

CREATE TABLE ingreso_chabitaciones(
    id_ingreso_habitacion    SERIAL,
    id_ingreso                  INTEGER,
    id_habitacion               INTEGER,
    PRIMARY KEY (id_ingreso_habitacion),
    FOREIGN KEY (id_ingreso) REFERENCES ingreso(id_ingreso),
    FOREIGN KEY (id_habitacion) REFERENCES chabitaciones(id_habitacion)

);

CREATE TABLE chabitaciones(
    id_habitacion               SERIAL,
    habitacion                  INTEGER,
    PRIMARY KEY (id_habitacion)
);

CREATE TABLE piso_habitacion(
    id_pisohab                  SERIAL,
    id_piso                     INTEGER,
    id_habitacion               INTEGER,
    PRIMARY KEY (id_pisohab),
    FOREIGN KEY (id_piso) REFERENCES piso(id_piso),
    FOREIGN KEY (id_habitacion) REFERENCES chabitaciones(id_habitacion)
);

CREATE TABLE piso(
    id_piso                     SERIAL,
    npiso                       INTEGER,
    PRIMARY KEY (id_piso)
);

CREATE TABLE piso_consultorio(
    id_pisoconsul               SERIAL,
    id_piso                     INTEGER,
    id_consultorio              INTEGER,
    PRIMARY KEY (id_pisoconsul),
    FOREIGN KEY (id_piso) REFERENCES piso(id_piso),
    FOREIGN KEY (id_consultorio) REFERENCES consultorio(id_consultorio)
);

CREATE TABLE consultorio(
    id_consultorio              SERIAL,
    consultorio                 INTEGER,
    PRIMARY KEY (id_consultorio)
);

CREATE TABLE consultorio_consulta(
    id_consultorio_consulta     SERIAL,
    id_consultorio              INTEGER,
    id_consulta                 INTEGER,
    PRIMARY KEY (id_consultorio_consulta),
    FOREIGN KEY (id_consultorio) REFERENCES consultorio(id_consultorio),
    FOREIGN KEY (id_consulta) REFERENCES consulta(id_consulta)
);

CREATE TABLE consulta(
    id_consulta                 SERIAL,
    fecha                       DATE,
    diagnostico                 TEXT,
    precio                      NUMERIC,
    hora                        TIME,
    id_especialidad             INTEGER,
    PRIMARY KEY (id_consulta),
    FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad)
);

CREATE TABLE consulta_paciente(
    id_consulta_paciente        SERIAL,
    id_consulta                 INTEGER,
    id_paciente                 INTEGER,
    PRIMARY KEY (id_consulta_paciente),
    FOREIGN KEY (id_consulta) REFERENCES consulta(id_consulta),
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente)
);

CREATE TABLE consulta_personal(
    id_consulta_personal        SERIAL,
    id_consulta                 INTEGER,
    id_personal                 INTEGER,
    PRIMARY KEY (id_consulta_personal),
    FOREIGN KEY (id_consulta) REFERENCES consulta(id_consulta),
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
);

CREATE TABLE receta_consulta(
    id_receta_consulta          SERIAL,
    id_consulta                 INTEGER,
    id_receta                   INTEGER,
    PRIMARY KEY (id_receta_consulta),
    FOREIGN KEY (id_consulta) REFERENCES consulta(id_consulta),
    FOREIGN KEY (id_receta) REFERENCES recetamedica(id_receta)
);

CREATE TABLE recetamedica(
    id_receta                   SERIAL,
    tratamiento                 TEXT,
    PRIMARY KEY (id_receta)
);



-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-03-2023 a las 08:31:24
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `biblioteca`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idCategoria` int(11) NOT NULL,
  `categoria` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`idCategoria`, `categoria`) VALUES
(1, ''),
(2, 'Lecturas de 1º BAC'),
(3, 'Lecturas de 2º BAC');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `idCurso` int(11) NOT NULL,
  `curso` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`idCurso`, `curso`) VALUES
(1, ''),
(2, '1º BAC H'),
(4, '1º BAC C'),
(5, '1º BAC T'),
(6, '2º BAC H'),
(8, '2º BAC C'),
(10, '2º BAC T');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `editorial`
--

CREATE TABLE `editorial` (
  `idEditorial` int(11) NOT NULL,
  `editorial` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `editorial`
--

INSERT INTO `editorial` (`idEditorial`, `editorial`) VALUES
(1, 'AGUILAR'),
(2, 'PLAZA & JANES'),
(3, 'CASTALIA DIDACTICA'),
(4, 'CÍRCULO DE LECTORES'),
(5, 'AUSTRAL'),
(6, 'DEBOLSILLO'),
(7, 'EDELVIVES'),
(10, 'EDEBE'),
(11, 'SAL TERRAE'),
(12, 'ALIANZA EDITORIAL'),
(13, 'MOLINO'),
(14, 'PLANETA'),
(15, 'SEIX BARRAL'),
(16, 'DESTINO'),
(17, 'EDICIONES SM'),
(18, 'ALFAGUARA'),
(20, 'LUMEN'),
(21, 'MAXI'),
(22, 'RBA'),
(23, 'MONTENA'),
(24, 'SALAMANDRA'),
(25, 'CATEDRA'),
(26, 'ANAYA'),
(27, 'DIVULGACIÓN TESTIMONIO'),
(28, 'VICENS VIVES'),
(30, 'PUNTO DE LECTURA'),
(31, 'GARA'),
(32, 'CLÁSICOS LITERARIOS COLECCIÓN DIDÁCTICA'),
(33, 'MONDADORI'),
(34, 'MAEVA EMBOLSILLO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libros`
--

CREATE TABLE `libros` (
  `isbn` varchar(20) NOT NULL,
  `titulo` varchar(40) NOT NULL,
  `autor1` varchar(50) NOT NULL,
  `autor2` varchar(50) NOT NULL,
  `idEditorial` int(11) NOT NULL,
  `idCategoria` int(11) NOT NULL,
  `sinopsis` varchar(255) NOT NULL,
  `ejemplares` int(11) NOT NULL,
  `disponibles` int(11) NOT NULL,
  `imagen` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `libros`
--

INSERT INTO `libros` (`isbn`, `titulo`, `autor1`, `autor2`, `idEditorial`, `idCategoria`, `sinopsis`, `ejemplares`, `disponibles`, `imagen`) VALUES
('8401413117', 'El nombre de la rosa', 'Umbro Eco', '', 2, 3, 'Un monje se va a encontrar una abadía de la Edad Media, con una serie de crímenes que pondrán a prueba toda su inteligencia. ', 1, 0, './ficheros/2654408.jpg'),
('8401492513', 'Los buscadores de conchas', 'Rosamunde Pilcher', '', 2, 3, 'La historia de Penélope Stern, sus hijos y sus relaciones y vivencias del pasado. Un relato lleno de ternura sobre la familia, el deseo de gozar de la vida...', 2, 2, './ficheros/27339pilcher.jpg'),
('8401540860', 'El síndrome de mi estocolmo', 'Magda Bandera', '', 2, 2, 'Libro de viajes relatando las impresiones de la autora por Suecia, Noruega y Finlandia con un montón de anécdotas que le sucedieron', 1, 1, './ficheros/elsindromedemiestocolmo.jpg'),
('8420400734', 'Los hijos del trueno', 'F. Lalana', 'J.M. Almácergui', 18, 2, 'Los alumnos de un colegio \"especial\" (Instituto Remanente) donde van los chicos más problemáticos o con ciertas carencias se atreven a presentarse a un concurso nacional retando a otros colegios más brillantes. Una obra llena de humor...', 2, 1, './ficheros/Loshijosdeltrueno.jpg'),
('8420481017', 'El Maestro de Esgrima', 'Arturo Pérez-Reverte', '', 18, 2, 'Novela histórica, de intriga y de amor ambientada en el siglo XIX. Un viejo maestro de esgrima da clases a una hermosa y enigmática dama alrededor de la cual aparecen misterios y asesinatos.', 1, 1, './ficheros/Arturo.jpg'),
('8420613665', 'Estoy en Puertomarte sin Hilda', 'Isaac Asimov', '', 12, 3, 'Varios relatos de ciencia ficción llenos de intriga y suspense', 1, 0, './ficheros/30241426176.jpg'),
('8420613819', 'El señor de las moscas', 'William Golding', '', 12, 2, 'Un grupo de niños sobrevive a un accidente aéreo en un isla desierta. La historia narra cómo se organizan, las disputas que se crean... con un final terriblemente inquietante.', 2, 0, './ficheros/El-señor-de-Las-Mouches-William-Golding-Alliance.jpg'),
('8420790680', 'Una luz en el atardecer', 'Félix Teira Cubel', '', 26, 2, 'Alberto no va a clase a veces. Tiene problemas con las notas, con sus padres... En una de esas escapadas conoce a Clara y comienza una relación que le va a obligar a madurar', 5, 4, './ficheros/9788420790688.jpg'),
('8422645394', 'Usted puede sanar su vida.', 'Louise L. Hay', '', 4, 3, 'La autora nos enseña el poder que tenemos dentro de nosotros. Mediante afirmaciones y visualizaciones podemos potenciar nuestra autoestima.', 1, 1, './ficheros/sanar-su-vida-foto.jpg'),
('8423307328', 'La familia de Pascual Duarte', 'Camilo José Cela', '', 16, 3, 'Historia de Pascual desde su juventud hasta su estancia en la cárcel acusado de varios crímenes.', 1, 0, './ficheros/9788423307326-es.jpg'),
('8423311309', 'Cinco horas con Mario', 'Miguel Delibes', '', 16, 3, 'Una mujer vela el cadáver de su marido recién fallecido y mantiene un monólogo intenso recordando cómo era su vida con él.', 1, 0, './ficheros/22107503344.jpg'),
('8426429807', 'El nombre de la rosa', 'Umbro Eco', '', 20, 3, 'Un monje se va a encontrar en una abadía de la Edad Media con una serie de crímenes misteriosos que pondrán a prueba toda su inteligencia.', 1, 0, './ficheros/nombre_rosa_grande.jpeg.jpg'),
('8429306382', 'El canto del pájaro', 'Anthony de Mello,s.j.', '', 11, 2, 'Conjunto de cuentos con un pequeño pensamiento. Para leer despacio, degustando las historias dejándote empapar por su mensaje', 1, 1, './ficheros/4183asgMC0L.jpg'),
('8432038741', 'Rimas/Leyendas. Cartas desde mi celda', 'Gustavo Adolfo Bécquer', 'María del Pilar Palomo', 14, 2, 'Su personalidad se revela en los personajes de sus \"Leyendas\" o en la confesión de sus \"cartas\", tanto como en el mensaje puramente lírico de sus versos. Un mensaje intimista y subjetivo de profundismo y certero poder de comunicación', 1, 1, './ficheros/76807207.jpg'),
('8439711115', 'Crónica de una muerte anunciada', 'Gabriel García Márquez', '', 33, 3, 'Historia de la muerte de Santiago Nasar acusado de que Ángela Vicario no llegase virgen al matrimonio', 1, 0, './ficheros/d2725af3-85dd-4db7-8d02-0494a9629571.jpeg.jpg'),
('8480940050', 'Réquiem por un labrador español ', 'Ramón José Sender', '', 31, 3, 'Mosén Millán se dispone a celebrar una misa por el alma de un joven al que había querido como a un hijo. Mientras va recordando la vida de dicho joven ', 1, 1, './ficheros/descarga.jpeg.jpg'),
('8484500012', 'La piel del tambor', 'Arturo Pérez-Reverte', '', 6, 3, 'Intrifa, el Vaticano, una mujer hermosa y enifmática, un joven cura en medio de un misterio, unos matones sevillanos...', 1, 1, './ficheros/LA-PIEL-DEL-TAMBOR-85365.jpg'),
('8495501058', 'Plenilunio', 'Antonio Muñoz Molina', '', 30, 3, 'Un inspector de policía investiga un crimen horrible y a la vez se va a encontrar a sí mismo en el proceso ', 1, 1, './ficheros/181476._SY475_.jpg'),
('8495501465', 'Dios vuelve en una Harley', 'Joan Brady', '', 30, 3, 'Christine recibe una visita inesperada: Dios conduciendo una Harley. La conversación con Él le va a cambiar la vida', 1, 0, './ficheros/DIOS-VUELVE-EN-UNA-HARLEY-104651.jpg'),
('9788401352867', 'Hija de la fortuna.', 'Isabel Allende', '', 2, 3, 'Una joven chilena de mitad del s. XIX decide seguir a su novio a California donde se ha descubierto oro.  Allí le ayudará un médico chino: Tao chien. Historia llena de aventuras, amor y retratos profundos de la condición humana.', 1, 1, './ficheros/Screenshot_20220914-102358_Gallery.jpg'),
('9788401428432', 'Eva Luna', 'Isabel Allende', '', 2, 2, 'La vida de una chica que tiene una gran capacidad para contar historias. A través de ellas descubrimos cómo es, cómo se siente...', 1, 1, './ficheros/s84Aqd_20181002124014_evaluna.jpeg.jpg'),
('9788403102002', 'Reacciona.', 'Varios autores.', '', 1, 3, 'Diez artículos sobre la crisis económica, política y social.', 1, 1, './ficheros/9788403102002.jpg'),
('9788408011743', 'El informe Pelícano.', 'John Grisham', '', 14, 3, 'Una estudiante de derecho escribe una teoría sobre la muerte de dos jueces. Sin quererlo acierta de pleno y va a ser perseguida para evitar que pueda hablar.', 1, 1, './ficheros/fa33bd4deb7117db7c7fb68b2aad8a54.jpg'),
('9788408095361', 'Angel caído.', 'Asa Achwarz', '', 14, 2, 'Una adolescente de diecisiete años muy especial es acusada de un crimen. No tendrá más remedio que investigar lo ocurrido con la ayuda de algunos amigos.', 1, 0, './ficheros/b7c7169b434cc7be0ccbd0ea9d2758fa.jpg'),
('9788408165859', 'Los mares del sur.', 'Manuel Vázquez Montalbán', '', 14, 2, 'El inspector de policía Pepe Carvalho se ve envuelto en un caso en plena transición democrática española que le llevará a un largo viaje por el Pacífico para solucionarlo.', 1, 1, './ficheros/LosMares.jpg'),
('9788415140207', 'El Clan del oso cavernario.', 'Jean M. Auel', '', 34, 3, 'Ayla, una niña de cinco años, queda aislada de su tribu tras un terremoto y encuentra refugio en un grupo de neandertales con los que aprenderá muchisimo.\r\n', 3, 2, './ficheros/41DMJX4LigL._SX328_BO1,204,203,200_.jpg'),
('9788420468839', 'El manuscrito de piedra', 'Luis García Jambrina', '', 18, 2, 'A finales del s. XV, Fernando de Rojas, estudiante de Leyes en la Universidad de Salamanca, deberá investigar el asesinato de un catedrático de Teología. Novela histórica, policiaca, de misterio y simbólica.', 1, 1, './ficheros/9788420468839-es.jpg'),
('9788423344116', 'En el mar hay cocodrilos', 'Fabio Geda', '', 16, 2, 'Enaiatollah sale de Afganistán con su madre buscando un futuro mejor. Ella le abandona por su propio bien y él inicia un largo viaje buscando un lugar donde crecer. Un libro la dignidad del ser humano y el coraje de sobrevivir.', 1, 1, './ficheros/81cDmsz-IpL.jpg'),
('9788423346189', 'Lo mejor que le puede pasar a un cruasán', 'Pablo Tusset.', '', 14, 3, 'Miralles, treinteañero inadaptado, debe investigar la desaparición de su hermano en circunstancias extrañas. Libro lleno de una fina ironía ambientado en Barcelona.', 1, 1, './ficheros/418xOWq8N3L._SX330_BO1,204,203,200_.jpg'),
('9788423353705', 'Cinco horas con Mario', 'Miguel Delibes', '', 5, 3, 'Una mujer vela el cadáver de su marido recién fallecido y mantiene un monólogo intenso recordando cómo era su vida con él.', 1, 0, './ficheros/71qUhHluz2L.jpg'),
('9788423657841', 'Historias extraordinarias', 'Edgar Allan Poe', '', 10, 2, 'Varios relatos de terror y misterio contados de manera magistral ', 1, 1, './ficheros/9788423657841.jpg'),
('9788427202122', 'Los juegos del hambre', 'Suzzane Collins', '', 13, 2, 'Doce chicos y doce chicas se ven obligados a participar en un reality show llamado \"Los juegos del hambre\". Solo hay una regla matar o morir. ', 1, 1, './ficheros/losjuegos.jpg'),
('9788427202139', 'Los juegos del hambre: En llamas.', 'Suzanne Collins', '', 13, 2, 'Contra todo pronostico, Katniss Everdeen y Peeta Mellark siguen vivos. Aunque Katniss debería sentirse  aliviada, se rumoreo que existe una rebelión contra el Capitolio, una rebelión que puede que Katniss y Peeta hayan ayudado a inspirar.', 1, 1, './ficheros/41ZY8q3OXqL._SX328_BO1,204,203,200_.jpg'),
('9788427202146', 'Los juegos del hambre: Sinsajo.', 'Suzanne Collins', '', 13, 2, 'Katnis se enfrenta ahora a otros peligros. La revolución se extiende y ella tiene el papel más importante de todos: convertirse en el Sinsajo, el símbolo de la rebelión.', 1, 1, './ficheros/60886347.jpg'),
('9788431664459', 'Leyendas y rimas', 'Gustavo Adolfo Bécquer', '', 28, 2, 'Historias típicas del romanticismo con el estilo lírico propio de Bécquer', 2, 0, './ficheros/22630865531.jpg'),
('9788432217005', 'La verdad sobre el caso Savolta.', 'Eduardo Mendoza.', '', 15, 3, 'Novela de intriga, acción e historia.  Nos relata la vida de Barcelona de finales del siglo XIX llena de convulsiones políticas, económicas y sociales.', 1, 1, './ficheros/9788432217005.jpg'),
('9788432217012', 'El misterio de la cripta embrujada', 'Eduardo Mendoza', '', 15, 2, 'Parodia de las novelas de detectives. Un loco ingresado en un psiquiátrico se verá envuelto en una trama de asesinatos y desapariciones en un colegio', 1, 1, './ficheros/libro_1322013267.jpeg.jpg'),
('9788432221255', 'Sin noticias de Gurb', 'Eduardo Mendoza', '', 15, 3, 'Dos extraterrestres aterrizan en la Barcelona del 92 con la misión de explorar el planeta. Uno se pierde y el otro lo va a buscar. ', 1, 0, './ficheros/71b110Qa0LL.jpg'),
('9788434839861', 'Falso movimiento ', 'Alejandro Gándara ', '', 17, 2, 'Una hija adolescente que no llega a casa. Una madre que empuja al padre para que vaya a buscarla. Él va al bar donde suele estar su novio pero este no ha aparecido y no se sabe dónde está. Padre e hija inician un viaje por la noche de Madrid para buscarle', 1, 0, './ficheros/md31230459260.jpg'),
('9788434845091', 'Falso movimiento ', 'Alejandro Gándara', '', 17, 2, 'Una hija adolescente que bo llega a casa. Una madre que empuja al padre para que vaya a buscarla. Él va al bar donde suele estar con su novio pero este no ha aparecido y no se sabe dónde está. Padre e hija inician un viaje por la noche de Madrid para busc', 1, 1, './ficheros/md2925719475.jpg'),
('9788437624662', 'Veinte poemas de amor y una canción', 'Pablo Neruda', 'Gabriele Morelli', 25, 3, 'Primer libro de poesía del autor', 1, 0, './ficheros/veinte.jpeg'),
('9788448106270', 'Artículos escogidos', 'M. J. Larra', '', 32, 3, 'Reflexiones, críticas...sobre la sociedad de finales del siglo XIX.', 1, 0, './ficheros/Articulos-escogidos-i1n9956.jpg'),
('9788466305716', 'Cien preguntas sobre el nuevo desorden.', 'Carlos Taibo.', '', 30, 3, 'Una mirada lúdica y crítica sobre la globalización y sus consecuencias.', 1, 1, './ficheros/51cJKM7B9IL._SX328_BO1,204,203,200_.jpg'),
('9788468333083', 'Historias extraordinarias.', 'Edgar Allan Poe', '', 10, 2, 'Varios relatos de terror y misterio contados de manera magistral', 1, 1, './ficheros/img_server.jpg'),
('9788484416937', 'Juntos', 'Ally Condie', '', 23, 2, 'En el mundo de Cassia las autoridades lo deciden todo: trabajo, novios... Cuando le dicen que se casara con su mejor amigo se alegra pero todo se complica al conocer al misterioso Ky quien le planteará preguntas inquietantes...', 1, 0, './ficheros/9788484416937.jpg'),
('9788484417217', 'La chica del lago', 'Steph Bowe', '', 23, 2, 'En el momento más oscuro de su vida, Santa Thomas conoce a la solitaria y excepcional Jewel Valentine. Unidos por un vínculo mágico e indestructible lograrán enterar su pasado y, vivirán una aventura alocada y liberadora...', 1, 0, './ficheros/1662976197310561005880508552713.jpg'),
('9788484604686', 'Diario de un skin.', 'Antonio Salas.', '', 14, 3, 'El autor estuvo un año camuflado bajo la piel de un skinhead y nos cuenta su tremenda experiencia.', 2, 0, './ficheros/00106520978989____3__640x640.jpg'),
('9788484607380', 'Yo vencí la anorexia ', 'Nieves Álvarez ', '', 27, 2, 'La modelo nos cuenta una parte de su vida donde cayó en la anorexia', 1, 0, './ficheros/71zHHru1VmL.jpg'),
('9788490628324', 'El Maestro de esgrima', 'Arturo Pérez Reverte', '', 6, 2, 'Novela histórica, de intriga y de amor ambientada en el siglo XIX. Un viejo maestro de esgrima da clases a una hermosa y enigmática dama alrededor de la cual aparecen misterios y asesinatos. ', 2, 1, './ficheros/elmaes.jpg'),
('9788490667316', 'Patria', 'Fernando Aramburu', '', 21, 3, 'Historia de un asesino de ETA en el País Vasco desde diferentes perspectivas.', 1, 1, './ficheros/9788490667316.jpg'),
('9788492966813', 'Los juegos del hambre: Sinsajo.', 'Suzanne Collins', '', 22, 2, 'Katnis se enfrenta ahora a otros peligros. La revolución se extiende y ella tiene el papel más importante de todos: convertirse en el Sinsajo, el símbolo de la revelión.', 1, 0, './ficheros/71WYaTDXu4L.jpg'),
('9788497408035', 'El Buscón', 'Francisco de Quevedo', '', 3, 2, 'Novela picaresca que retrata la vida azarosa de un joven en el s. XVII.', 1, 0, './ficheros/_visd_0000JPG029Z4.jpg'),
('9788497592437', 'Crónica de una muerte anunciada', 'Gabriel García Márquez', '', 6, 3, 'Historia de la muerte de Santiago Nasar acusado de que Ángela Vicario no llegase virgen al matrimonio ', 1, 0, './ficheros/91Dax7AnPpL.jpg'),
('9788497939164', 'Tres metros sobre el cielo', 'Federico Moccia', '', 6, 2, 'Historia de dos adolescentes de mundos sociales muy distintos que un día se conocen y vivirán un amor especial.', 2, 1, './ficheros/tres metros sobre el cielo.jpg'),
('9788498380798', 'El niño con el pijama de rayas.', 'John Boyne', '', 24, 2, 'El hijo del jefe de un campo de exterminio nazi entabla amistad con un niño judío sin saber la realidad qué ocurre en ese extraño lugar rodeado por alambradas.', 1, 0, './ficheros/51LqwIHmKrL._SX312_BO1,204,203,200_.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamos`
--

CREATE TABLE `prestamos` (
  `idPrestamo` int(11) NOT NULL,
  `isbn` varchar(20) NOT NULL,
  `idSocio` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `dias` date NOT NULL,
  `devuelto` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socios`
--

CREATE TABLE `socios` (
  `idSocio` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `clave` varchar(20) NOT NULL,
  `idCurso` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idusuario` varchar(9) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `nombrecompleto` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `movil` varchar(13) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `clave` varchar(16) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `fechaultimoacceso` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idusuario`, `nombrecompleto`, `email`, `movil`, `clave`, `fechaultimoacceso`) VALUES
('admin', 'Persona de biblioteca', '', '', 'admin', '2022-03-15 12:25:58');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idCategoria`);

--
-- Indices de la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`idCurso`);

--
-- Indices de la tabla `editorial`
--
ALTER TABLE `editorial`
  ADD PRIMARY KEY (`idEditorial`);

--
-- Indices de la tabla `libros`
--
ALTER TABLE `libros`
  ADD PRIMARY KEY (`isbn`),
  ADD KEY `idEditorial` (`idEditorial`) USING BTREE,
  ADD KEY `idCategoria` (`idCategoria`) USING BTREE;

--
-- Indices de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD PRIMARY KEY (`idPrestamo`),
  ADD KEY `isbn` (`isbn`),
  ADD KEY `idSocio` (`idSocio`);

--
-- Indices de la tabla `socios`
--
ALTER TABLE `socios`
  ADD PRIMARY KEY (`idSocio`),
  ADD KEY `idCurso` (`idCurso`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idusuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idCategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `idCurso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `editorial`
--
ALTER TABLE `editorial`
  MODIFY `idEditorial` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  MODIFY `idPrestamo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT de la tabla `socios`
--
ALTER TABLE `socios`
  MODIFY `idSocio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `libros`
--
ALTER TABLE `libros`
  ADD CONSTRAINT `libros_ibfk_1` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`idCategoria`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `libros_ibfk_2` FOREIGN KEY (`idEditorial`) REFERENCES `editorial` (`idEditorial`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Czas generowania: 21 Stycznia 2018, 12:52
-- Wersja serwera: 10.1.13-MariaDB
-- Wersja PHP: 5.6.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `projektsklep`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `kategorie`
--

CREATE TABLE `kategorie` (
  `id_kategorii` int(11) NOT NULL,
  `nazwa` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL,
  `opis` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `kategorie`
--

INSERT INTO `kategorie` (`id_kategorii`, `nazwa`, `opis`) VALUES
(1, 'Soki i Napoje', 'Napoje bezalkoholowe do picia'),
(2, 'Warzywa', 'Świeże warzywa z ogrodów'),
(4, 'Przekąski', 'Coś dla każdego'),
(5, 'Pieczywo', 'Świeże jedzenie'),
(8, 'Mięso', 'Prosto z rzeźni');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `logi`
--

CREATE TABLE `logi` (
  `id_logu` int(11) NOT NULL,
  `id_usera` int(11) NOT NULL,
  `data` date NOT NULL,
  `a_co_to_to` text NOT NULL,
  `info` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `produkty`
--

CREATE TABLE `produkty` (
  `id_produktu` int(11) NOT NULL,
  `nazwa` text COLLATE utf8_polish_ci NOT NULL,
  `cena` double NOT NULL,
  `obrazek` text COLLATE utf8_polish_ci NOT NULL,
  `ilosc` int(11) NOT NULL,
  `opis` text COLLATE utf8_polish_ci NOT NULL,
  `kategoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `produkty`
--

INSERT INTO `produkty` (`id_produktu`, `nazwa`, `cena`, `obrazek`, `ilosc`, `opis`, `kategoria`) VALUES
(10, 'Sok porzeczka ', 6, 'sok_porzeczkowy.jpg', 498, 'Dobry soczek porzeczkowy', 1),
(11, 'Sok pomarańczowy', 4.2, 'sok_pomaranczowy.jpg', 4, 'Dobry soczek pomarańczowy', 1),
(12, 'Sok jabłkowy', 10, 'sok_jablkowy.jpg', 2, 'Dobry soczek jabłkowy', 1),
(26, 'Śledź', 0.5, 'sledzik1.jpg', 587, 'Śledzik lubi pływać', 4),
(29, 'Kinder Niespodzianka', 3, 'kinder.jpg', 400, 'Słodkie dla dzieci i dorosłych', 4),
(31, 'Razowy', 1.9, 'razowy1.jpg', 191, 'Dobry chleb, świeży', 5),
(32, 'Słonecznikowy', 2.89, 'slonecznik.jpg', 117, 'Dobry chleb, świeży', 5),
(33, 'Baltonowski', 1.29, 'baltonowski1.jpg', 80, 'Dobry chleb, świeży', 5),
(34, 'Bułka', 0.25, 'bulka.jpg', 500, 'Świeża bułka z piekarni', 5),
(45, 'Schab Gotowany', 14.99, 'gotowany.png', 20, 'Dobre i świeże mięso ', 8),
(46, 'Schab Wędzony', 16.99, 'schab2.jpg', 21, 'Dobre i świeże mięso ', 8),
(47, 'Schab Surowy', 8.99, 'surowy.jpg', 23, 'Dobre i świeże mięso ', 8),
(48, 'Schab Pieczony', 19.99, 'schab.jpg', 54, 'Dobre i świeże mięso ', 8),
(49, 'Marchew', 0.5, 'marchew.png', 300, 'Świeża marchew z Polski', 2),
(52, 'Ziemniak', 0.1, 'ziemniaki.jpg', 300, 'Ziemniaki z Polski', 2),
(53, 'Pomidor', 0.7, 'pomidor.jpg', 400, 'Pomidory z Hiszpanii', 2),
(54, 'Chrupki słone', 3.5, 'chrupki.jpg', 400, 'Chrupki o smaku soli', 4),
(55, 'Paluszki', 2, 'PALUSZKI.png', 400, 'Paluszki', 4),
(56, 'Orzeszki', 4, 'ORZESZKI.png', 250, 'Orzeszki solone', 4);

--
-- Wyzwalacze `produkty`
--
DELIMITER $$
CREATE TRIGGER `edycja_produktu` AFTER UPDATE ON `produkty` FOR EACH ROW INSERT INTO logi (id_usera, data, a_co_to_to, info)
VALUES (NEW.id_produktu, NOW(), 'edycja produktu, drogi userze', NEW.nazwa)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `usun_z_magazynu` AFTER DELETE ON `produkty` FOR EACH ROW INSERT INTO logi (id_usera, data, a_co_to_to, info)
VALUES (OLD.id_produktu, NOW(), 'usuwanie drogi panie', OLD.nazwa)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `sprzedaz`
--

CREATE TABLE `sprzedaz` (
  `id_sprzedazy` int(11) NOT NULL,
  `id_zamowienia` int(11) NOT NULL COMMENT 'Id jednego zamówienia. Kilka produktów może mieć takie samo id, bo moga byc zamawiane na raz',
  `id_uzytkownika` int(11) NOT NULL,
  `id_produktu` int(11) NOT NULL,
  `ilosc` int(11) NOT NULL,
  `data` date NOT NULL,
  `typ_wysylki` text NOT NULL,
  `potwierdzenie` text CHARACTER SET utf8 COLLATE utf8_polish_ci NOT NULL COMMENT 'tak - potwierdzone, czeka - w trakcie przetwarzania, nowe - jeszcze nie potwierdzone, blocked - odrzucone',
  `id_pracownika_co_weryfikowal` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `sprzedaz`
--

INSERT INTO `sprzedaz` (`id_sprzedazy`, `id_zamowienia`, `id_uzytkownika`, `id_produktu`, `ilosc`, `data`, `typ_wysylki`, `potwierdzenie`, `id_pracownika_co_weryfikowal`) VALUES
(1, 1517967414, 1, 10, 2, '2018-01-31', 'poczta polska', 'tak', 1),
(2, 1517967414, 1, 11, 2, '2018-01-31', 'poczta polska', 'tak', 1),
(3, 1517967414, 1, 32, 3, '2018-01-31', 'poczta polska', 'tak', 1),
(4, 1517967414, 1, 45, 5, '2018-01-31', 'poczta polska', 'tak', 1),
(5, 1517967771, 1, 10, 4, '2018-01-31', 'poczta polska', 'blocked', 1);

--
-- Wyzwalacze `sprzedaz`
--
DELIMITER $$
CREATE TRIGGER `sprzedalem_cos` AFTER INSERT ON `sprzedaz` FOR EACH ROW INSERT INTO logi (id_usera, data, a_co_to_to, info)
VALUES (NEW.id_uzytkownika, NOW(), 'sprzedaz panie kochany', NEW.potwierdzenie)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uzytkownicy`
--

CREATE TABLE `uzytkownicy` (
  `id` int(11) NOT NULL,
  `login` text COLLATE utf8_polish_ci NOT NULL,
  `haslo` text COLLATE utf8_polish_ci NOT NULL,
  `imie` text COLLATE utf8_polish_ci NOT NULL,
  `nazwisko` text COLLATE utf8_polish_ci NOT NULL,
  `typ` text COLLATE utf8_polish_ci NOT NULL,
  `email` text COLLATE utf8_polish_ci NOT NULL,
  `adres` text COLLATE utf8_polish_ci NOT NULL,
  `miasto` text COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `uzytkownicy`
--

INSERT INTO `uzytkownicy` (`id`, `login`, `haslo`, `imie`, `nazwisko`, `typ`, `email`, `adres`, `miasto`) VALUES
(1, 'test', 'test', 'Ziemowit', 'Wielki', 'p', 'test@wp.pl', 'Belweder 20', 'Łękołody');

--
-- Wyzwalacze `uzytkownicy`
--
DELIMITER $$
CREATE TRIGGER `dodaj_po_rejestracji` AFTER INSERT ON `uzytkownicy` FOR EACH ROW INSERT INTO logi (id_usera, data, a_co_to_to, info)
VALUES (NEW.id, NOW(), 'rejestracja panie dziejaszku', 'brak')
$$
DELIMITER ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `kategorie`
--
ALTER TABLE `kategorie`
  ADD PRIMARY KEY (`id_kategorii`),
  ADD KEY `id_kategorii` (`id_kategorii`),
  ADD KEY `id_kategorii_2` (`id_kategorii`);

--
-- Indexes for table `logi`
--
ALTER TABLE `logi`
  ADD PRIMARY KEY (`id_logu`);

--
-- Indexes for table `produkty`
--
ALTER TABLE `produkty`
  ADD PRIMARY KEY (`id_produktu`),
  ADD KEY `kategoria` (`kategoria`),
  ADD KEY `kategoria_2` (`kategoria`);

--
-- Indexes for table `sprzedaz`
--
ALTER TABLE `sprzedaz`
  ADD PRIMARY KEY (`id_sprzedazy`),
  ADD KEY `id_uzytkownika` (`id_uzytkownika`),
  ADD KEY `id_produktu` (`id_produktu`),
  ADD KEY `id_pracownika_co_weryfikowal` (`id_pracownika_co_weryfikowal`);

--
-- Indexes for table `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `kategorie`
--
ALTER TABLE `kategorie`
  MODIFY `id_kategorii` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT dla tabeli `logi`
--
ALTER TABLE `logi`
  MODIFY `id_logu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;
--
-- AUTO_INCREMENT dla tabeli `produkty`
--
ALTER TABLE `produkty`
  MODIFY `id_produktu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;
--
-- AUTO_INCREMENT dla tabeli `sprzedaz`
--
ALTER TABLE `sprzedaz`
  MODIFY `id_sprzedazy` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT dla tabeli `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `produkty`
--
ALTER TABLE `produkty`
  ADD CONSTRAINT `produkty_ibfk_1` FOREIGN KEY (`kategoria`) REFERENCES `kategorie` (`id_kategorii`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `sprzedaz`
--
ALTER TABLE `sprzedaz`
  ADD CONSTRAINT `sprzedaz_ibfk_1` FOREIGN KEY (`id_uzytkownika`) REFERENCES `uzytkownicy` (`id`),
  ADD CONSTRAINT `sprzedaz_ibfk_2` FOREIGN KEY (`id_pracownika_co_weryfikowal`) REFERENCES `uzytkownicy` (`id`),
  ADD CONSTRAINT `sprzedaz_ibfk_3` FOREIGN KEY (`id_produktu`) REFERENCES `produkty` (`id_produktu`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

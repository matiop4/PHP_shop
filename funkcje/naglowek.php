<?php
    /*
     * Plik zawiera nagłówekv (górną belkę) strony wyświetlany na każdej podstronie
     */
?>
<div class="row" id="naglowek">

 <nav  class="navbar navbar-toggleable-md bg-faded navbar-fixed-top"  style="background-color: #50a000; " >
     
  <div class="container">
  
  <div class="navbar-header">
        <a class="navbar-brand" href="index.php"><img src="img/sklep.png" class="img-rounded"></a>
    </div>
  <div class="collapse navbar-collapse" id="navbarTogglerDemo01">

    <ul class="nav navbar-nav  navbar-right  mr-auto mt-2 mt-lg-0 ">
    <?php
    // przycisk KOSZYK z menu rozwijanym
    w_pokaz_koszyk_dropdown();
    // jeżeli NIE zalogowano
        if (!zalogowany())
        {      
    ?>
      <li class="nav-item" ><a style="color: white;" href="?v=tresc/rejestracja/rejestracja">|&nbsp&nbsp&nbsp&nbsp&nbsp&nbspRejestracja&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp|</a></li>
      <li class="dropdown">
        <a style="color: white;" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Logowanie <span class="caret"></span></a>
        <ul class="dropdown-menu">
          <form action="index.php?v=tresc/logowanie/logowanie&logowanie=tak" method="post" accept-charset="utf-8">
            <li>
              <div class="form-group">
                 <input type="text" name="login" class="form-control" placeholder="Login">
              </div>
              <div class="form-group">
                 <input type="password" name="haslo" class="form-control" placeholder="Hasło">
              </div>
              <button type="submit" class="btn btn-default">Zaloguj</button>
            </li>
          </form>
        </ul>
      </li>
    <?php
        }
        // jeśli zalogowano
        else if (zalogowany())
        {   
            if (klient()) 
            {   // jeśli klient, to przyciski dla klienta
                standardowy_przycisk("?v=tresc/u_zamowienia/moje_zamowienia", "Moje zamówienia");
            }
            else if (pracownik()) 
            {   // jeśli pracownik to przyciski dla pracownika
                standardowy_przycisk("?v=tresc/p_zarzadzanie/p_panel", "Zarządzanie zamówieniami");
            }
            // przyciski dla wszystkich
            standardowy_przycisk("index.php", "Witaj <b>{$_SESSION['login']}</b>", 0);
            standardowy_przycisk("tresc/logowanie/wyloguj.php?wyloguj=tak", "Wyloguj");
        }

    ?>
    </ul>
  </div>
  </div>
 </nav>
</div> 






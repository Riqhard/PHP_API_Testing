<?php
if (isset($_POST['payment']) && $_POST['payment'] == 'success') {
    $orderNumber = $_POST['order_number'];
    $authCode = $_POST['authcode'];
    $returnCode = $_POST['return_code'];
    $settled = $_POST['settled'];


    insertMaksettuVuoro($orderNumber, $authCode, $returnCode, $settled);
    // Näytä viesti käyttäjälle maksun onnistumisesta

    // Muuta paikka ostetuksi
    muutaVuoroOstetuksi($orderNumber);

        // Tyhjennä ostoskori
        unset($_SESSION['ostoskori']);

    // Näytä viesti käyttäjälle maksun onnistumisesta
    // ...
}

function insertMaksettuLippu($orderNumber, $authCode, $returnCode, $settled) {
    global $link; // Oletetaan, että $link on MySQLi-tietokantayhteys

    try {
        // Valmistele SQL-lause, joka päivittää lipun tiedot
        $sql = "UPDATE asiakkaan_liput SET 
                    Authcode = ?, 
                    Return_code = ?, 
                    Settled = ?, 
                    Payment = ? 
                WHERE Tilausnumero = ?";

        // Määritä Payment arvo riippuen RETURN_CODE:sta
        $paymentStatus = ($returnCode == '0') ? 'success' : 'failed';

        // Valmistele kysely
        if ($stmt = $link->prepare($sql)) {
            // Sitoo parametrit
            $stmt->bind_param("siiss", $authCode, $returnCode, $settled, $paymentStatus, $orderNumber);
            
            // Suorita päivitys
            $stmt->execute();

            // Tarkista, päivitettiinkö rivejä
            if ($stmt->affected_rows > 0) {
                $stmt->close();
                return true; // Rivejä päivitettiin
            } else {
                $stmt->close();
                return false; // Ei päivitetty rivejä
            }
        } else {
            return false; // Valmistelu epäonnistui
        }
    } catch (Exception $e) {
        // Virheenkäsittely
        error_log("Tietokantavirhe: " . $e->getMessage());
        return false; // Palauttaa false, jos tietokantaoperaatio epäonnistuu
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Epassi Payment Tester</title>
    <link rel="stylesheet" href="style.css">

</head>
<body>

<?php
            // Tarkistetaan ensin, onko kyseessä POST-pyyntö ja onko csrf_token olemassa ja oikein
            if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['csrf_token']) && $_POST['csrf_token'] === $csrf_token) {

                // Luo tilausnumero
                $asiakasID = $_SESSION['asiakasID'];
                // $products = $_SESSION['products'];
                $aikaleima = time();
                $eritystarkiste = bin2hex(random_bytes(4));
                $tilausnumero = $asiakasID . '-' . $eritystarkiste . '-' . $aikaleima;
                $enimi = $asiakas['Enimi'];
                $snimi = $asiakas['Snimi'];
                $sposti = $asiakas['Sposti'];
                $lahiosoite = $asiakas['Lahiosoite'];
                $postinro = $asiakas['Postinro'];
                $postitmp = $asiakas['Postitmp'];

                // Alustetaan tapahtumapaikan nimi:
                $tapahtumapaikka = "nimi";
                // Käsittele jokainen tuote ostoskorista
                // Tarkistetaan, onko POST-pyynnössä 'tuote' kenttää
                if (isset($_POST['tuote']) && is_array($_POST['tuote'])) {
                    // Alustetaan tuotteiden taulukko
                    $products = [];

                    // Käy läpi jokainen 'tuote' kenttä
                    foreach ($_POST['tuote'] as $tuoteJson) {
                        // Dekoodataan JSON-merkkijono takaisin PHP-arrayksi
                        $tuote = json_decode($tuoteJson, true);

                        // Tarkistetaan, onnistuiko dekoodaus
                        if ($tuote) {
                            // Lisää tuote tuotteiden taulukkoon
                            $products[] = $tuote;
                        }
                    }
                    // Tässä kohtaa $products sisältää kaikki tuotteet PHP-arrayna
                    // Voit nyt käsitellä tuotteita tarpeesi mukaan, esimerkiksi tallentaa tietokantaan

                    // Alusta totalPrice
                    $totalPrice = 0;

                    // Tulosta tuotteiden tiedot taulukkona
                    // Huom! Javascriptin 'DOMContentLoaded', function () VismaPaylle lähetettävät tiedot
                    // taulukosta 'products', joten muista pitää tämä näkymä taulukkomuodossa.
                    echo "<table border='1'>";
                    echo "<tr><th>VuoroID</th><th>Kenttä</th><th>Päivä</th><th>Lohko</th><th>Tunti</th><th>Hinta</th></tr>";
                    foreach ($products as $product) {
                        echo "<tr>";
                        echo "<td class='tuoteID'>" . htmlspecialchars($product['tuoteID']) . "</td>";
                        echo "<td class=tapahtumapaikka'>" . htmlspecialchars($product['tapahtumapaikka']) . "</td>";
                        echo "<td class='haettavaPaiva'>" . htmlspecialchars($product['haettavaPaiva']) . "</td>";
                        echo "<td class='block'>" . htmlspecialchars($product['block']) . "</td>";
                        echo "<td class='hour'>" . htmlspecialchars($product['hour']) . "</td>";
                        echo "<td class='hinta'>" . htmlspecialchars(number_format($product['hinta'], 2, ',', '')) . "€</td>";
                        $totalPrice += $product['hinta'] * 100;
                        echo "</tr>";
                    }
                    echo "</table>";

                }

                // Varmista, että totalPrice on oikeassa muodossa lomakkeen 'amount' kenttää varten
                // Huomaa, että totalPrice on sentteinä, joten jos haluat näyttää sen euroina, 
                // muista muuntaa se takaisin jakamalla 100:lla
                $euroina = $totalPrice / 100;
                // Tässä kohtaa $totalPrice sisältää kokonaishinnan sentteinä
            }
            
        // Jatketaan käsittelyä (maksuprosessin käynnistäminen)
        ?>
    
        
        <div class="total-price-button">
            <form action="/omat_koodit/public_html/Verkkolippu/visma-pay/visma-pay/example/index.php" method="post">
                <input type="hidden" name="asiakasID" value="<?php echo htmlspecialchars($asiakasID); ?>">
                <input type="hidden" name="tilausnumero" value="<?php echo htmlspecialchars($tilausnumero); ?>">
                <input type="hidden" name="enimi" value="<?php echo htmlspecialchars($enimi); ?>">
                <input type="hidden" name="snimi" value="<?php echo htmlspecialchars($snimi); ?>">
                <input type="hidden" name="sposti" value="<?php echo htmlspecialchars($sposti); ?>">
                <input type="hidden" name="lahiosoite" value="<?php echo htmlspecialchars($lahiosoite); ?>">
                <input type="hidden" name="postinro" value="<?php echo htmlspecialchars($postinro); ?>">
                <input type="hidden" name="postitmp" value="<?php echo htmlspecialchars($postitmp); ?>">
                <input type="hidden" name="products" id="products" value='<?php echo htmlspecialchars(json_encode($products)); ?>'>
                <input type="hidden" name="amount" value="<?php echo $totalPrice; ?>">
                <button type="submit" class="maksa-painike">Tarkista ja siirry maksamaan.<br>Yhteensä: <span id="totalPrice"><?php echo number_format($totalPrice / 100, 2, ',', ''); ?>€</span></button>
            </form>

        </div>

</body>



</html>
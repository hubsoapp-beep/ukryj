# Ukryj

Mała aplikacja na pasek menu macOS. Jeden klik chowa wszystkie ikony na lewo od strzałki, kolejny je pokazuje. Zostaje zegar i ikony systemowe.

## Użycie

- Lewy klik na strzałce `‹` / `›` przełącza widoczność ikon.
- Prawy klik (lub Ctrl+klik) otwiera menu „Zakończ".
- Start jest zawsze zwinięty.

## Budowanie

Wymagane: Xcode Command Line Tools (`swiftc`).

```sh
./build.sh
open build/Ukryj.app
```

## Jak działa

Dwie ikony `NSStatusItem`: toggle i separator. Zwinięty separator ma długość 10000 i wypycha ikony po swojej lewej poza ekran. Domyślne pozycje (odległość od prawej krawędzi) ustawia `main.swift`; ⌘+przeciągnięcie je nadpisuje.

## Ograniczenia

- Ikon systemowych (Wi-Fi, Spotlight, Centrum sterowania) nie da się schować. Wyłącz je w Ustawieniach systemowych → Centrum sterowania.
- Ikona, która wyląduje na prawo od strzałki, zostaje widoczna. Przeciągnij ją ⌘ na lewo.
- Testowane na macOS 15, pasek z auto-ukrywaniem.

## Licencja

MIT

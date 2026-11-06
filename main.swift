import AppKit

// Chowa ikony na lewo od separatora: separator o długości 10000 wypycha je poza ekran.
// Układ w pasku: [inne ikony] [separator] [toggle] [ikony systemowe + zegar]
final class App: NSObject, NSApplicationDelegate {
    var toggle: NSStatusItem!
    var separator: NSStatusItem!
    var collapsed = false

    func applicationDidFinishLaunching(_ n: Notification) {
        // Bez zapisanej pozycji macOS wstawia ikony na lewo od innych apek i nic nie ma do ukrycia.
        // Wartości = odległość od prawej krawędzi (px): tuż na lewo od ikon systemowych.
        // Ręczne przeciągnięcie ⌘ nadpisuje te wartości.
        let d = UserDefaults.standard
        for (key, pos) in [("ukryj-toggle", 295.0), ("ukryj-separator", 323.0)]
        where d.object(forKey: "NSStatusItem Preferred Position \(key)") == nil {
            d.set(pos, forKey: "NSStatusItem Preferred Position \(key)")
        }

        // Kolejność tworzenia ma znaczenie: pierwszy element ląduje najbardziej na prawo.
        toggle = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        separator = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        toggle.autosaveName = "ukryj-toggle"
        separator.autosaveName = "ukryj-separator"

        toggle.button?.target = self
        toggle.button?.action = #selector(clicked)
        toggle.button?.sendAction(on: [.leftMouseUp, .rightMouseUp])
        separator.button?.title = "|"

        // Opóźnienie: przy pierwszym starcie długość ustawiona od razu bywała ignorowana.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { self.setCollapsed(true) }
    }

    func setCollapsed(_ value: Bool) {
        collapsed = value
        separator.length = value ? 10000 : NSStatusItem.variableLength
        separator.button?.title = value ? "" : "|"
        let symbol = value ? "chevron.left" : "chevron.right"
        toggle.button?.image = NSImage(systemSymbolName: symbol, accessibilityDescription: nil)
    }

    @objc func clicked() {
        let e = NSApp.currentEvent
        if e?.type == .rightMouseUp || e?.modifierFlags.contains(.control) == true {
            let menu = NSMenu()
            menu.addItem(withTitle: "Zakończ", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
            toggle.menu = menu
            toggle.button?.performClick(nil)
            toggle.menu = nil // inaczej menu przejmie też lewy klik
        } else {
            setCollapsed(!collapsed)
        }
    }
}

let app = NSApplication.shared
let delegate = App()
app.delegate = delegate
app.setActivationPolicy(.accessory) // bez ikony w Docku
app.run()

import SwiftUI

struct Feature: Identifiable {
    let id: String
    let title: String
    let detail: String
}

struct ContentView: View {
    @State private var enabledFeatures: Set<String> = []

    private let features: [Feature] = [
        .init(id: "region", title: "Региональные параметры", detail: "Нужно исследовать, какие настройки реально доступны в iOS."),
        .init(id: "downloads", title: "Сохранение видео и изображений", detail: "Заготовка настройки; загрузка пока не реализована."),
        .init(id: "appearance", title: "Темы и цвета", detail: "Настройки интерфейса будущего приложения."),
        .init(id: "playback", title: "Дополнительные параметры видео", detail: "Нужно отдельно реализовать и проверить."),
        .init(id: "ads", title: "Реклама", detail: "Нельзя отключить рекламу TikTok этим переключателем."),
        .init(id: "extras", title: "Дополнительные функции", detail: "Каждую функцию нужно портировать и тестировать отдельно."),
        .init(id: "plugins", title: "Плагины и обновления", detail: "Пока не подключены.")
    ]

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Это стартовый интерфейс iOS-порта MargyT. Переключатели демонстрационные и пока не изменяют TikTok.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Section("Функции для портирования") {
                    ForEach(features) { feature in
                        Toggle(isOn: binding(for: feature.id)) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(feature.title)
                                Text(feature.detail)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }

                Section {
                    Label("Android-код нельзя напрямую собрать в IPA", systemImage: "info.circle")
                    Text("Сначала потребуется отдельная iOS-реализация. Этот проект не включает и не патчит TikTok.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("MargyT iOS")
        }
    }

    private func binding(for id: String) -> Binding<Bool> {
        Binding(
            get: { enabledFeatures.contains(id) },
            set: { isEnabled in
                if isEnabled {
                    enabledFeatures.insert(id)
                } else {
                    enabledFeatures.remove(id)
                }
            }
        )
    }
}

import SwiftUI

struct CustomLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
            configuration.title
        }
        .alignmentGuide(.listRowSeparatorLeading) { dimension in
            return dimension[.listRowSeparatorLeading] + 32
        }
    }
}

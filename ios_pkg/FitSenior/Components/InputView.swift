import SwiftUI

// Usar cores nativas do SwiftUI

struct TextInput: View {
    let title: String
    @Binding var text: String
    var placeholder: String = ""
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    var showSearchIcon: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if showSearchIcon {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.teal)
                        .font(.caption)
                    Text(title)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
            } else {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            
            if isSecure {
                SecureField(placeholder, text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(keyboardType)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.teal.opacity(0.3), lineWidth: 1)
                    )
            } else {
                TextField(placeholder, text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(keyboardType)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.teal.opacity(0.3), lineWidth: 1)
                    )
            }
        }
    }
}

struct TextArea: View {
    let title: String
    @Binding var text: String
    var placeholder: String = ""
    var height: CGFloat = 100
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            TextEditor(text: $text)
                .frame(height: height)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
                .overlay(
                    Group {
                        if text.isEmpty {
                            Text(placeholder)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 8)
                                .allowsHitTesting(false)
                        }
                    },
                    alignment: .topLeading
                )
        }
    }
}


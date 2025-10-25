import SwiftUI

struct AnswerMenuView: View {
    @Binding var path: [AnswerRoute]
    
    var body: some View {
        List {
            Section("Contribute") {
                Button {
                    path.append(.pickQuestion)
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "questionmark.bubble.fill")
                            .foregroundColor(.blue)
                            .frame(width: 26, height: 26)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Answer an existing question")
                                .font(.headline)
                            Text("Browse what people want to know right now")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }
                
                Button {
                    path.append(.writeCustomAnswer)
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "pencil.and.outline")
                            .foregroundColor(.blue)
                            .frame(width: 26, height: 26)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Share your own perspective")
                                .font(.headline)
                            Text("Write your own headline and answer it")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Answer")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AnswerMenuView(path: .constant([]))
    }
}

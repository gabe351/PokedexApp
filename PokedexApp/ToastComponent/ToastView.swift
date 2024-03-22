import SwiftUI

struct ToastView: View {

  var style: ToastStyle
  var message: String
  var width = CGFloat.infinity
  var onCancelTapped: (() -> Void)

  var body: some View {
    HStack(alignment: .center, spacing: 12) {
      Image(systemName: style.iconFileName)
        .foregroundColor(style.themeColor)
      Text(message)
        .font(Font.caption)
        .foregroundColor(style.themeColor)

      Spacer(minLength: 10)

      Button {
        onCancelTapped()
      } label: {
        Image(systemName: "xmark")
          .foregroundColor(style.themeColor)
      }
    }
    .padding()
    .frame(minWidth: 0, maxWidth: width)
    .background(.white)
    .overlay(
        RoundedRectangle(cornerRadius: 8)
            .stroke(style.themeColor, lineWidth: 1)
    )

    .padding(.horizontal, 16)
  }
}

import UIKit
import UniformTypeIdentifiers
import Social
import os

class ShareViewController: UIViewController {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "VRCN.ShareExtension",
        category: "ShareExtension"
    )

    // キャンセル時のエラー定義
    enum ShareError: Error {
        case cancel
        case urlProcessingFailed
        case appNotFound
    }

    // ビューがロードされた時の処理
    override func viewDidLoad() {
        super.viewDidLoad()

        // シンプルなUIを作成
        view.backgroundColor = UIColor.systemBackground

        // ローディングインジケーターを表示
        showLoadingIndicator()

        Task {
            await processSharedContent()
        }
    }

    // ローディングインジケーターを表示
    private func showLoadingIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)

        let label = UILabel()
        label.text = "VRCNで開いています..."
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: activityIndicator.frame.maxY + 20, width: view.frame.width, height: 20)
        view.addSubview(label)
    }

    @MainActor
    private func processSharedContent() async {
        do {
            _ = try await extractAndHandleURL()

            // 処理完了を短い遅延の後に通知
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
            }

        } catch {
            logger.error("共有処理エラー: \(String(describing: error), privacy: .public)")

            // エラー時も拡張を終了
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
            }
        }
    }

    private func extractAndHandleURL() async throws -> Bool {
        // 1. 共有されたアイテムの取得
        guard let item = extensionContext?.inputItems.first as? NSExtensionItem,
              let itemProvider = item.attachments?.first else {
            logger.error("共有アイテムが見つかりませんでした")
            throw ShareError.urlProcessingFailed
        }

        // 2. 共有アイテムがURLタイプかチェック
        guard itemProvider.hasItemConformingToTypeIdentifier(UTType.url.identifier) else {
            logger.error("URLタイプではありません")
            throw ShareError.urlProcessingFailed
        }

        // 3. URLデータの読み込み
        let data = try await itemProvider.loadItem(forTypeIdentifier: UTType.url.identifier, options: nil)

        // 4. URLの処理
        guard let url = data as? URL else {
            logger.error("URL変換に失敗しました")
            throw ShareError.urlProcessingFailed
        }

        logger.info("共有されたURL: \(url.absoluteString, privacy: .public)")

        // 5. カスタムURLスキームでメインアプリに渡す
        return try await openMainApp(with: url)
    }

    private func openMainApp(with url: URL) async throws -> Bool {
        // URLをエンコード（特殊文字を安全に扱えるように）
        guard let encodedUrl = url.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let openAppUrl = URL(string: "vrcn://share?url=\(encodedUrl)") else {
            logger.error("URL処理に失敗しました")
            throw ShareError.urlProcessingFailed
        }

        logger.info("アプリを開きます: \(openAppUrl.absoluteString, privacy: .public)")

        return await withCheckedContinuation { continuation in
            self.extensionContext?.open(openAppUrl, completionHandler: { success in
                self.logger.info("アプリオープン結果: \(success, privacy: .public)")
                continuation.resume(returning: success)
            })
        }
    }
}

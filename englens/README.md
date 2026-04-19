# EngLens - Ứng dụng học tiếng Anh thông minh tích hợp OCR

EngLens là một giải pháp di động toàn diện hỗ trợ học tập tiếng Anh, giúp rút ngắn khoảng cách giữa tài liệu giấy và việc học kỹ thuật số. Ứng dụng cho phép người dùng trích xuất từ vựng trực tiếp từ hình ảnh, tra cứu tức thì và ghi nhớ hiệu quả thông qua các phương pháp khoa học.

## 🚀 Các tính năng chính

* **Nhận diện văn bản (OCR):** Tích hợp Google ML Kit giúp quét và trích xuất văn bản tiếng Anh từ Camera hoặc thư viện ảnh với độ chính xác cao.
* **Tra từ & Dịch thuật:** Hệ thống tra cứu đa năng hỗ trợ cả từ điển Offline (Hive) và dịch thuật trực tuyến qua API, cung cấp đầy đủ phiên âm, loại từ và ví dụ.
* **Hệ thống Flashcard thông minh:** Áp dụng thuật toán **Lặp lại ngắt quãng (Spaced Repetition)** và hệ thống **Leitner** giúp tối ưu hóa khả năng ghi nhớ dài hạn.
* **Chiến lược Offline-First:** Sử dụng Hive Database để đảm bảo ứng dụng hoạt động mượt mà, cho phép tra cứu và ôn tập từ vựng ngay cả khi không có kết nối mạng.
* **Đồng bộ hóa đám mây:** Tích hợp Firebase (Auth & Firestore) để bảo mật tài khoản và đồng bộ hóa tiến trình học tập trên nhiều thiết bị.
* **Hỗ trợ phát âm (TTS):** Sử dụng công nghệ Text-to-Speech giúp người dùng luyện nghe và phát âm chuẩn xác theo giọng bản ngữ.

## 🛠 Tech Stack

* **Framework:** Flutter (Dart)
* **State Management:** GetX (Reactive programming)
* **Local Database:** Hive (Lightweight & High performance)
* **Backend as a Service:** Firebase (Authentication, Firestore)
* **AI/ML:** Google ML Kit (Text Recognition)
* **Networking:** Dio

## 🏗 Kiến trúc dự án (Pragmatic Clean Architecture)

Dự án được tổ chức theo hướng **Feature-First** kết hợp với kiến trúc **Clean Architecture thực dụng**. Để tối ưu tốc độ phát triển (fast iteration) và bảo trì, mỗi tính năng được chia tách rõ ràng thành 2 tầng chính (lược bỏ tầng domain):

* **Presentation Layer:** Quản lý giao diện (Widgets/Screens) và logic điều khiển trạng thái (GetX Controllers).
* **Data Layer:** Quản lý dữ liệu bao gồm Models (DTOs), Data Sources (giao tiếp Hive/Firebase) và triển khai Repositories.

### Cấu trúc thư mục:

    lib/
    ├── core/                   # Chứa constants, theme, utils và các component dùng chung.
    └── features/               # Chia theo từng tính năng (Home, Scan, Flashcard, Auth...)
        └── [feature_name]/
            ├── data/           # Models, Repositories Implementation, Data Sources.
            └── presentation/   # UI Screens, Widgets, GetX Controllers.

## 📦 Hướng dẫn cài đặt

1. **Clone dự án:**

    git clone [https://github.com/Scrdoctor1412/my_english_mobile_app.git](https://github.com/Scrdoctor1412/my_english_mobile_app.git)
    cd my_english_mobile_app

2. **Cài đặt thư viện:**

    flutter pub get

3. **Cấu hình Firebase:**
   * Tạo project trên Firebase Console.
   * Thêm ứng dụng Android/iOS.
   * Tải và đặt file `google-services.json` vào `android/app/` và `GoogleService-Info.plist` vào `ios/Runner/`.

4. **Chạy ứng dụng:**

    flutter run

## 🎥 Demo

* **Video giới thiệu:** [Xem Demo tại đây](https://drive.google.com/file/d/1QQi7NUdynZ6aiXUsEYcnDUE9avIZqKuP/view?usp=sharing)

<p align="center">
  <img src="[https://via.placeholder.com/250x500?text=Scan+Feature](https://via.placeholder.com/250x500?text=Scan+Feature)" width="250" />
  <img src="[https://via.placeholder.com/250x500?text=Flashcard+System](https://via.placeholder.com/250x500?text=Flashcard+System)" width="250" />
</p>

## 👤 Thông tin tác giả

**Quách Khải Nguyên**
* **Vị trí:** Mobile Developer (Flutter / iOS / Android)
* **Học vấn:** ngành CNTT - Phân hiệu Đại học Thủy Lợi (GPA: 3.73)
* **GitHub:** [Scrdoctor1412](https://github.com/Scrdoctor1412)

---
*Dự án là Đồ án tốt nghiệp khóa 2021-2025 tại Phân hiệu Trường Đại học Thủy Lợi.*
